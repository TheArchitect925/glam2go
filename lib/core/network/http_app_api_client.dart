import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../config/app_config.dart';
import '../errors/app_failure.dart';
import '../result/app_result.dart';
import 'app_api_client.dart';

class HttpAppApiClient extends AppApiClient {
  HttpAppApiClient(this.config, {HttpClient? httpClient})
    : _httpClient = httpClient ?? HttpClient();

  final AppConfig config;
  final HttpClient _httpClient;

  @override
  Future<AppResult<ApiResponse>> send(ApiRequest request) async {
    final uri = Uri.parse(
      config.apiBaseUrl,
    ).resolve(request.path).replace(queryParameters: request.queryParameters);

    try {
      _log('-> ${request.method.name.toUpperCase()} $uri');
      final httpRequest = await _openRequest(request.method, uri);
      request.headers.forEach(httpRequest.headers.set);
      httpRequest.headers.set(HttpHeaders.acceptHeader, 'application/json');

      if (request.body != null) {
        httpRequest.headers.set(
          HttpHeaders.contentTypeHeader,
          ContentType.json.mimeType,
        );
        httpRequest.write(jsonEncode(request.body));
      }

      final response = await httpRequest.close();
      final responseBody = await response.transform(utf8.decoder).join();
      final responseData = responseBody.isEmpty
          ? null
          : _decodeResponseBody(responseBody);

      final apiResponse = ApiResponse(
        statusCode: response.statusCode,
        data: responseData,
        headers: const {},
      );
      _log('<- ${response.statusCode} $uri');
      return AppSuccess(apiResponse);
    } on SocketException catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.network,
          message: 'Unable to reach the Glam2GO API.',
          cause: error,
        ),
      );
    } on HttpException catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.network,
          message: 'HTTP request failed before a valid response was received.',
          cause: error,
        ),
      );
    } on FormatException catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.serialization,
          message: 'API response could not be decoded.',
          cause: error,
        ),
      );
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.unknown,
          message: 'Unexpected API client failure.',
          cause: error,
        ),
      );
    }
  }

  Future<HttpClientRequest> _openRequest(AppHttpMethod method, Uri uri) {
    return switch (method) {
      AppHttpMethod.get => _httpClient.getUrl(uri),
      AppHttpMethod.post => _httpClient.postUrl(uri),
      AppHttpMethod.put => _httpClient.putUrl(uri),
      AppHttpMethod.patch => _httpClient.patchUrl(uri),
      AppHttpMethod.delete => _httpClient.deleteUrl(uri),
    };
  }

  Object? _decodeResponseBody(String responseBody) {
    final decoded = jsonDecode(responseBody);
    if (decoded is Map<String, dynamic>) {
      return decoded.cast<String, Object?>();
    }
    if (decoded is List) {
      return decoded.cast<Object?>();
    }
    return decoded;
  }

  void _log(String message) {
    if (!config.enableApiDebugLogging || !kDebugMode) {
      return;
    }
    debugPrint('[Glam2GO API] $message');
  }
}

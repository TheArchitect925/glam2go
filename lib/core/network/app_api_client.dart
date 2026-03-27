import '../result/app_result.dart';

typedef JsonMap = Map<String, Object?>;
typedef JsonData = Object?;

enum AppHttpMethod { get, post, put, patch, delete }

class ApiRequest {
  const ApiRequest({
    required this.method,
    required this.path,
    this.queryParameters = const <String, String>{},
    this.headers = const <String, String>{},
    this.body,
  });

  final AppHttpMethod method;
  final String path;
  final Map<String, String> queryParameters;
  final Map<String, String> headers;
  final JsonData body;
}

class ApiResponse {
  const ApiResponse({
    required this.statusCode,
    required this.data,
    this.headers = const <String, String>{},
  });

  final int statusCode;
  final JsonData data;
  final Map<String, String> headers;
}

abstract class AppApiClient {
  const AppApiClient();

  Future<AppResult<ApiResponse>> send(ApiRequest request);
}

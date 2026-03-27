import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/app_api_client.dart';
import '../../../../core/result/app_result.dart';
import '../dtos/discovery_catalog_dto.dart';

class DiscoveryRemoteDataSource {
  const DiscoveryRemoteDataSource(this._client);

  final AppApiClient _client;

  Future<AppResult<DiscoveryCatalogDto>> loadCatalog() async {
    final response = await _client.send(
      const ApiRequest(
        method: AppHttpMethod.get,
        path: '/v1/discovery/catalog',
      ),
    );

    if (response.failureOrNull != null) {
      return AppFailureResult(response.failureOrNull!);
    }

    final apiResponse = response.dataOrNull!;
    if (apiResponse.statusCode == 401) {
      return AppFailureResult(
        const AppFailure(
          type: AppFailureType.unauthorized,
          message: 'Discovery request was not authorized.',
        ),
      );
    }
    if (apiResponse.statusCode < 200 || apiResponse.statusCode >= 300) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.network,
          message:
              'Discovery request failed with status ${apiResponse.statusCode}.',
        ),
      );
    }

    final data = apiResponse.data;
    if (data is! Map<String, Object?>) {
      return AppFailureResult(
        const AppFailure(
          type: AppFailureType.serialization,
          message: 'Discovery response payload was not a JSON object.',
        ),
      );
    }

    try {
      return AppSuccess(DiscoveryCatalogDto.fromMap(data));
    } on FormatException catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.serialization,
          message: 'Discovery response payload could not be parsed.',
          cause: error,
        ),
      );
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.serialization,
          message: 'Discovery payload shape was invalid.',
          cause: error,
        ),
      );
    }
  }
}

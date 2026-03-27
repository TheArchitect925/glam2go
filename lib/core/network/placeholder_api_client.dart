import '../config/app_config.dart';
import '../errors/app_failure.dart';
import '../result/app_result.dart';
import 'app_api_client.dart';

class PlaceholderApiClient extends AppApiClient {
  const PlaceholderApiClient(this.config);

  final AppConfig config;

  @override
  Future<AppResult<ApiResponse>> send(ApiRequest request) async {
    return AppFailureResult(
      AppFailure(
        type: AppFailureType.network,
        message:
            'Remote API integration is not configured for ${request.method.name.toUpperCase()} ${request.path} in ${config.environment.name}.',
      ),
    );
  }
}

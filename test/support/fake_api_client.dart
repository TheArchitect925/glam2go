import 'package:glam2go/core/errors/app_failure.dart';
import 'package:glam2go/core/network/app_api_client.dart';
import 'package:glam2go/core/result/app_result.dart';

typedef ApiHandler =
    Future<AppResult<ApiResponse>> Function(ApiRequest request);

class FakeAppApiClient extends AppApiClient {
  FakeAppApiClient({required Map<String, ApiHandler> handlers})
    : _handlers = handlers;

  final Map<String, ApiHandler> _handlers;

  @override
  Future<AppResult<ApiResponse>> send(ApiRequest request) async {
    final key = '${request.method.name.toUpperCase()} ${request.path}';
    final handler = _handlers[key];
    if (handler == null) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.network,
          message: 'No fake API handler registered for $key.',
        ),
      );
    }
    return handler(request);
  }
}

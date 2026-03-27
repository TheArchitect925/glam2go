import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/app_api_client.dart';
import '../../../../core/result/app_result.dart';
import '../dtos/auth_session_dto.dart';

class SessionRemoteDataSource {
  const SessionRemoteDataSource(this._client);

  final AppApiClient _client;

  Future<AppResult<AuthSessionDto>> signIn({
    required String email,
    required String displayName,
    required String role,
    String? artistProfileId,
  }) {
    return _sendAuthRequest(
      path: '/v1/auth/sign-in',
      body: {
        'email': email,
        'displayName': displayName,
        'role': role,
        'artistProfileId': artistProfileId,
      },
    );
  }

  Future<AppResult<AuthSessionDto>> signUp({
    required String email,
    required String displayName,
    required String role,
    String? artistProfileId,
  }) {
    return _sendAuthRequest(
      path: '/v1/auth/sign-up',
      body: {
        'email': email,
        'displayName': displayName,
        'role': role,
        'artistProfileId': artistProfileId,
      },
    );
  }

  Future<AppResult<AuthSessionDto>> restoreSession(String token) async {
    final response = await _client.send(
      ApiRequest(
        method: AppHttpMethod.get,
        path: '/v1/session',
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return _parseAuthResponse(response);
  }

  Future<AppResult<void>> signOut(String token) async {
    final response = await _client.send(
      ApiRequest(
        method: AppHttpMethod.post,
        path: '/v1/auth/sign-out',
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    if (response.failureOrNull != null) {
      return AppFailureResult(response.failureOrNull!);
    }

    final statusCode = response.dataOrNull!.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      return const AppSuccess(null);
    }

    if (statusCode == 401) {
      return AppFailureResult(
        const AppFailure(
          type: AppFailureType.unauthorized,
          message: 'Session is no longer authorized for sign out.',
        ),
      );
    }

    return AppFailureResult(
      AppFailure(
        type: AppFailureType.network,
        message: 'Sign out failed with status $statusCode.',
      ),
    );
  }

  Future<AppResult<AuthSessionDto>> _sendAuthRequest({
    required String path,
    required Map<String, Object?> body,
  }) async {
    final response = await _client.send(
      ApiRequest(method: AppHttpMethod.post, path: path, body: body),
    );
    return _parseAuthResponse(response);
  }

  AppResult<AuthSessionDto> _parseAuthResponse(
    AppResult<ApiResponse> response,
  ) {
    if (response.failureOrNull != null) {
      return AppFailureResult(response.failureOrNull!);
    }

    final apiResponse = response.dataOrNull!;
    if (apiResponse.statusCode == 401) {
      return AppFailureResult(
        const AppFailure(
          type: AppFailureType.unauthorized,
          message: 'Session request was rejected by the API.',
        ),
      );
    }

    if (apiResponse.statusCode < 200 || apiResponse.statusCode >= 300) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.network,
          message: 'Auth request failed with status ${apiResponse.statusCode}.',
        ),
      );
    }

    final data = apiResponse.data;
    if (data is! Map<String, Object?>) {
      return AppFailureResult(
        const AppFailure(
          type: AppFailureType.serialization,
          message: 'Auth response payload was not a JSON object.',
        ),
      );
    }

    try {
      return AppSuccess(AuthSessionDto.fromMap(data));
    } on FormatException catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.serialization,
          message: 'Auth response payload could not be parsed.',
          cause: error,
        ),
      );
    }
  }
}

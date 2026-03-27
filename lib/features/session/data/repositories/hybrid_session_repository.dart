import '../../../../core/config/app_config.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/app_result.dart';
import '../../domain/models/session_models.dart';
import '../../domain/repositories/session_repository.dart';
import '../dtos/session_storage_dto.dart';
import '../local_session_storage.dart';
import '../remote/session_remote_data_source.dart';

class HybridSessionRepository implements SessionRepository {
  const HybridSessionRepository({
    required LocalSessionStorage storage,
    required SessionRemoteDataSource remoteDataSource,
    required AppConfig config,
  }) : _storage = storage,
       _remoteDataSource = remoteDataSource,
       _config = config;

  final LocalSessionStorage _storage;
  final SessionRemoteDataSource _remoteDataSource;
  final AppConfig _config;

  @override
  Future<AppResult<SessionState?>> loadSession() async {
    try {
      final persisted = await _storage.load();
      if (persisted == null) {
        return const AppSuccess(null);
      }

      if (!_config.enableRemoteSession ||
          persisted.authStatus != AuthStatus.authenticated.name ||
          persisted.authToken == null ||
          persisted.authToken!.isEmpty) {
        return AppSuccess(persisted.toDomain());
      }

      final remoteResult = await _remoteDataSource.restoreSession(
        persisted.authToken!,
      );

      if (remoteResult.dataOrNull != null) {
        final restored = remoteResult.dataOrNull!.toSessionState().copyWith(
          pendingProtectedAction: persisted.toDomain().pendingProtectedAction,
        );
        await _save(restored, authToken: remoteResult.dataOrNull!.token);
        return AppSuccess(restored);
      }

      if (remoteResult.failureOrNull?.type == AppFailureType.unauthorized) {
        await _storage.clear();
        return const AppSuccess(SessionState.guest());
      }

      return AppSuccess(persisted.toDomain());
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to restore session state.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<void>> saveSession(SessionState state) async {
    try {
      final existing = await _storage.load();
      final authToken = state.isAuthenticated ? existing?.authToken : null;
      await _save(state, authToken: authToken);
      return const AppSuccess(null);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to persist session state.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<SessionState>> signIn({
    required String displayName,
    required String email,
    required AppUserMode mode,
    required AuthIntent intent,
    String? artistProfileId,
    bool useDebugDefaultAccount = false,
  }) async {
    return _authenticate(
      isSignUp: false,
      displayName: displayName,
      email: email,
      mode: mode,
      intent: intent,
      artistProfileId: artistProfileId,
      useDebugDefaultAccount: useDebugDefaultAccount,
    );
  }

  @override
  Future<AppResult<SessionState>> signUp({
    required String displayName,
    required String email,
    required AppUserMode mode,
    required AuthIntent intent,
    String? artistProfileId,
    bool useDebugDefaultAccount = false,
  }) async {
    return _authenticate(
      isSignUp: true,
      displayName: displayName,
      email: email,
      mode: mode,
      intent: intent,
      artistProfileId: artistProfileId,
      useDebugDefaultAccount: useDebugDefaultAccount,
    );
  }

  @override
  Future<AppResult<void>> signOut() async {
    try {
      final existing = await _storage.load();
      if (_config.enableRemoteSession &&
          existing?.authToken != null &&
          existing!.authToken!.isNotEmpty) {
        await _remoteDataSource.signOut(existing.authToken!);
      }
      await _storage.clear();
      return const AppSuccess(null);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to clear session state.',
          cause: error,
        ),
      );
    }
  }

  Future<AppResult<SessionState>> _authenticate({
    required bool isSignUp,
    required String displayName,
    required String email,
    required AppUserMode mode,
    required AuthIntent intent,
    String? artistProfileId,
    required bool useDebugDefaultAccount,
  }) async {
    try {
      final normalizedName = displayName.trim();
      final normalizedEmail = email.trim();

      if (!_config.enableRemoteSession ||
          (_config.enableDebugDefaultAccounts && useDebugDefaultAccount)) {
        final localState = SessionState.authenticated(
          userMode: mode,
          userSummary: SessionUserSummary(
            userId:
                '${mode.name}-${normalizedEmail.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-')}',
            displayName: normalizedName,
            email: normalizedEmail,
            mode: mode,
            isNewAccount:
                intent == AuthIntent.signUp || intent == AuthIntent.joinArtist,
            artistProfileId: artistProfileId,
          ),
        );
        await _save(localState);
        return AppSuccess(localState);
      }

      final remoteResult = isSignUp
          ? await _remoteDataSource.signUp(
              email: normalizedEmail,
              displayName: normalizedName,
              role: mode.name,
              artistProfileId: artistProfileId,
            )
          : await _remoteDataSource.signIn(
              email: normalizedEmail,
              displayName: normalizedName,
              role: mode.name,
              artistProfileId: artistProfileId,
            );

      if (remoteResult.dataOrNull == null) {
        return AppFailureResult(remoteResult.failureOrNull!);
      }

      final state = remoteResult.dataOrNull!.toSessionState();
      await _save(state, authToken: remoteResult.dataOrNull!.token);
      return AppSuccess(state);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.unknown,
          message: 'Unable to complete the auth flow.',
          cause: error,
        ),
      );
    }
  }

  Future<void> _save(SessionState state, {String? authToken}) {
    return _storage.save(
      SessionStorageDto.fromDomain(state, authToken: authToken),
    );
  }
}

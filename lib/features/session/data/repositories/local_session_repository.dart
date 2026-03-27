import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/app_result.dart';
import '../../domain/models/session_models.dart';
import '../../domain/repositories/session_repository.dart';
import '../dtos/session_storage_dto.dart';
import '../local_session_storage.dart';

class LocalSessionRepository implements SessionRepository {
  const LocalSessionRepository(this._storage);

  final LocalSessionStorage _storage;

  @override
  Future<AppResult<SessionState>> signIn({
    required String displayName,
    required String email,
    required AppUserMode mode,
    required AuthIntent intent,
    String? artistProfileId,
    bool useDebugDefaultAccount = false,
  }) async {
    final state = SessionState.authenticated(
      userMode: mode,
      userSummary: SessionUserSummary(
        userId:
            '${mode.name}-${email.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-')}',
        displayName: displayName.trim(),
        email: email.trim(),
        mode: mode,
        isNewAccount:
            intent == AuthIntent.signUp || intent == AuthIntent.joinArtist,
        artistProfileId: artistProfileId,
      ),
    );
    final persisted = await saveSession(state);
    if (persisted.isFailure) {
      return AppFailureResult(persisted.failureOrNull!);
    }
    return AppSuccess(state);
  }

  @override
  Future<AppResult<SessionState>> signUp({
    required String displayName,
    required String email,
    required AppUserMode mode,
    required AuthIntent intent,
    String? artistProfileId,
    bool useDebugDefaultAccount = false,
  }) {
    return signIn(
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
      await _storage.clear();
      return const AppSuccess(null);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to clear local session state.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<SessionState?>> loadSession() async {
    try {
      final dto = await _storage.load();
      return AppSuccess(dto?.toDomain());
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to restore local session state.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<void>> saveSession(SessionState state) async {
    try {
      await _storage.save(SessionStorageDto.fromDomain(state));
      return const AppSuccess(null);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to persist local session state.',
          cause: error,
        ),
      );
    }
  }
}

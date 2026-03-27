import '../../../../core/result/app_result.dart';
import '../models/session_models.dart';

abstract class SessionRepository {
  Future<AppResult<SessionState>> signIn({
    required String displayName,
    required String email,
    required AppUserMode mode,
    required AuthIntent intent,
    String? artistProfileId,
    bool useDebugDefaultAccount = false,
  });
  Future<AppResult<SessionState>> signUp({
    required String displayName,
    required String email,
    required AppUserMode mode,
    required AuthIntent intent,
    String? artistProfileId,
    bool useDebugDefaultAccount = false,
  });
  Future<AppResult<SessionState?>> loadSession();
  Future<AppResult<void>> saveSession(SessionState state);
  Future<AppResult<void>> signOut();
}

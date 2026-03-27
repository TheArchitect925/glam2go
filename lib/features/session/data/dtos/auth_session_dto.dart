import '../../domain/models/session_models.dart';

class AuthSessionDto {
  const AuthSessionDto({
    required this.token,
    required this.userId,
    required this.displayName,
    required this.email,
    required this.role,
    required this.isNewAccount,
    this.artistProfileId,
  });

  factory AuthSessionDto.fromMap(Map<String, Object?> map) {
    final token = map['token'];
    final user = map['user'];
    if (token is! String || user is! Map<Object?, Object?>) {
      throw const FormatException('Missing auth session payload.');
    }

    final userMap = user.cast<String, Object?>();
    final userId = userMap['userId'];
    final displayName = userMap['displayName'];
    final email = userMap['email'];
    final role = userMap['role'];
    final isNewAccount = userMap['isNewAccount'];

    if (userId is! String ||
        displayName is! String ||
        email is! String ||
        role is! String ||
        isNewAccount is! bool) {
      throw const FormatException('Invalid auth session user payload.');
    }

    return AuthSessionDto(
      token: token,
      userId: userId,
      displayName: displayName,
      email: email,
      role: role,
      isNewAccount: isNewAccount,
      artistProfileId: switch (userMap['artistProfileId']) {
        final String value => value,
        _ => null,
      },
    );
  }

  final String token;
  final String userId;
  final String displayName;
  final String email;
  final String role;
  final bool isNewAccount;
  final String? artistProfileId;

  SessionState toSessionState() {
    final mode = AppUserMode.values.byName(role);
    return SessionState.authenticated(
      userMode: mode,
      userSummary: SessionUserSummary(
        userId: userId,
        displayName: displayName,
        email: email,
        mode: mode,
        isNewAccount: isNewAccount,
        artistProfileId: artistProfileId,
      ),
    );
  }
}

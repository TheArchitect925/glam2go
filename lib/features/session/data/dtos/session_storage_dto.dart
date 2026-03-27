import '../../domain/models/session_models.dart';

class SessionStorageDto {
  const SessionStorageDto({
    required this.userMode,
    required this.authStatus,
    this.userSummary,
    this.pendingProtectedAction,
    this.authToken,
  });

  factory SessionStorageDto.fromDomain(
    SessionState state, {
    String? authToken,
  }) {
    return SessionStorageDto(
      userMode: state.userMode.name,
      authStatus: state.authStatus.name,
      userSummary: state.userSummary?.toMap(),
      pendingProtectedAction: state.pendingProtectedAction?.toMap(),
      authToken: authToken,
    );
  }

  factory SessionStorageDto.fromMap(Map<String, Object?> map) {
    return SessionStorageDto(
      userMode: map['userMode'] as String,
      authStatus: map['authStatus'] as String,
      userSummary: switch (map['userSummary']) {
        final Map<Object?, Object?> raw => raw.cast<String, Object?>(),
        _ => null,
      },
      pendingProtectedAction: switch (map['pendingProtectedAction']) {
        final Map<Object?, Object?> raw => raw.cast<String, Object?>(),
        _ => null,
      },
      authToken: switch (map['authToken']) {
        final String value => value,
        _ => null,
      },
    );
  }

  final String userMode;
  final String authStatus;
  final Map<String, Object?>? userSummary;
  final Map<String, Object?>? pendingProtectedAction;
  final String? authToken;

  Map<String, Object?> toMap() {
    return {
      'userMode': userMode,
      'authStatus': authStatus,
      'userSummary': userSummary,
      'pendingProtectedAction': pendingProtectedAction,
      'authToken': authToken,
    };
  }

  SessionState toDomain() {
    return SessionState.fromMap(toMap()) ?? const SessionState.guest();
  }
}

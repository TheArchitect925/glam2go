import 'package:flutter/foundation.dart';

enum AppUserMode { guest, customer, artist }

enum AuthStatus { guest, authenticated }

enum AuthIntent { signIn, signUp, joinArtist }

enum ProtectedActionRequirement {
  customerAccount,
  favorites,
  bookingSubmission,
  artistTools,
}

@immutable
class PendingProtectedAction {
  const PendingProtectedAction({
    required this.path,
    required this.requirement,
    this.preferredAuthIntent,
    this.artistId,
  });

  final String path;
  final ProtectedActionRequirement requirement;
  final AuthIntent? preferredAuthIntent;
  final String? artistId;

  Map<String, Object?> toMap() {
    return {
      'path': path,
      'requirement': requirement.name,
      'preferredAuthIntent': preferredAuthIntent?.name,
      'artistId': artistId,
    };
  }

  static PendingProtectedAction? fromMap(Map<String, Object?> map) {
    final path = map['path'];
    final requirement = map['requirement'];
    if (path is! String || requirement is! String) {
      return null;
    }

    return PendingProtectedAction(
      path: path,
      requirement: ProtectedActionRequirement.values.byName(requirement),
      preferredAuthIntent: switch (map['preferredAuthIntent']) {
        final String value => AuthIntent.values.byName(value),
        _ => null,
      },
      artistId: switch (map['artistId']) {
        final String value => value,
        _ => null,
      },
    );
  }
}

@immutable
class SessionUserSummary {
  const SessionUserSummary({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.mode,
    required this.isNewAccount,
    this.artistProfileId,
  });

  final String userId;
  final String displayName;
  final String email;
  final AppUserMode mode;
  final bool isNewAccount;
  final String? artistProfileId;

  Map<String, Object?> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'mode': mode.name,
      'isNewAccount': isNewAccount,
      'artistProfileId': artistProfileId,
    };
  }

  static SessionUserSummary? fromMap(Map<String, Object?> map) {
    final userId = map['userId'];
    final displayName = map['displayName'];
    final email = map['email'];
    final mode = map['mode'];
    final isNewAccount = map['isNewAccount'];
    if (userId is! String ||
        displayName is! String ||
        email is! String ||
        mode is! String ||
        isNewAccount is! bool) {
      return null;
    }

    return SessionUserSummary(
      userId: userId,
      displayName: displayName,
      email: email,
      mode: AppUserMode.values.byName(mode),
      isNewAccount: isNewAccount,
      artistProfileId: switch (map['artistProfileId']) {
        final String value => value,
        _ => null,
      },
    );
  }
}

@immutable
class SessionState {
  const SessionState({
    required this.userMode,
    required this.authStatus,
    required this.hasHydrated,
    this.userSummary,
    this.pendingProtectedAction,
  });

  const SessionState.initializing()
    : userMode = AppUserMode.guest,
      authStatus = AuthStatus.guest,
      hasHydrated = false,
      userSummary = null,
      pendingProtectedAction = null;

  const SessionState.guest({this.hasHydrated = true})
    : userMode = AppUserMode.guest,
      authStatus = AuthStatus.guest,
      userSummary = null,
      pendingProtectedAction = null;

  const SessionState.authenticated({
    required this.userMode,
    required this.userSummary,
    this.hasHydrated = true,
  }) : authStatus = AuthStatus.authenticated,
       pendingProtectedAction = null;

  final AppUserMode userMode;
  final AuthStatus authStatus;
  final bool hasHydrated;
  final SessionUserSummary? userSummary;
  final PendingProtectedAction? pendingProtectedAction;

  bool get isGuest => userMode == AppUserMode.guest;
  bool get isCustomer => userMode == AppUserMode.customer;
  bool get isArtist => userMode == AppUserMode.artist;
  bool get isAuthenticated => authStatus == AuthStatus.authenticated;
  bool get hasPendingProtectedAction => pendingProtectedAction != null;
  bool get hasPendingProtectedPath => hasPendingProtectedAction;
  String? get pendingProtectedPath => pendingProtectedAction?.path;
  ProtectedActionRequirement? get pendingRequirement =>
      pendingProtectedAction?.requirement;

  SessionState copyWith({
    AppUserMode? userMode,
    AuthStatus? authStatus,
    bool? hasHydrated,
    SessionUserSummary? userSummary,
    bool clearUserSummary = false,
    PendingProtectedAction? pendingProtectedAction,
    bool clearPendingProtectedAction = false,
  }) {
    return SessionState(
      userMode: userMode ?? this.userMode,
      authStatus: authStatus ?? this.authStatus,
      hasHydrated: hasHydrated ?? this.hasHydrated,
      userSummary: clearUserSummary ? null : userSummary ?? this.userSummary,
      pendingProtectedAction: clearPendingProtectedAction
          ? null
          : pendingProtectedAction ?? this.pendingProtectedAction,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'userMode': userMode.name,
      'authStatus': authStatus.name,
      'userSummary': userSummary?.toMap(),
      'pendingProtectedAction': pendingProtectedAction?.toMap(),
    };
  }

  static SessionState? fromMap(Map<String, Object?> map) {
    final userMode = map['userMode'];
    final authStatus = map['authStatus'];
    if (userMode is! String || authStatus is! String) {
      return null;
    }

    return SessionState(
      userMode: AppUserMode.values.byName(userMode),
      authStatus: AuthStatus.values.byName(authStatus),
      hasHydrated: true,
      userSummary: switch (map['userSummary']) {
        final Map<Object?, Object?> raw => SessionUserSummary.fromMap(
          raw.cast<String, Object?>(),
        ),
        _ => null,
      },
      pendingProtectedAction: switch (map['pendingProtectedAction']) {
        final Map<Object?, Object?> raw => PendingProtectedAction.fromMap(
          raw.cast<String, Object?>(),
        ),
        _ => null,
      },
    );
  }
}

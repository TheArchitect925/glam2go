import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/analytics/analytics_service.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/crash_reporting/crash_reporting_service.dart';
import '../../../../core/network/network_providers.dart';
import '../../../../core/notifications/notification_service.dart';
import '../../../../core/result/app_result.dart';
import '../data/local_session_storage.dart';
import '../data/remote/session_remote_data_source.dart';
import '../data/repositories/hybrid_session_repository.dart';
import '../domain/models/session_models.dart';
import '../domain/repositories/session_repository.dart';

final localSessionStorageProvider = Provider<LocalSessionStorage>((ref) {
  return const LocalSessionStorage();
});

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return HybridSessionRepository(
    storage: ref.watch(localSessionStorageProvider),
    remoteDataSource: SessionRemoteDataSource(ref.watch(appApiClientProvider)),
    config: ref.watch(appConfigProvider),
  );
});

final sessionControllerProvider =
    NotifierProvider<SessionController, SessionState>(SessionController.new);

class SessionController extends Notifier<SessionState> {
  @override
  SessionState build() {
    Future.microtask(_restore);
    return const SessionState.initializing();
  }

  void continueAsGuest() {
    state = const SessionState.guest();
    unawaited(
      ref
          .read(analyticsServiceProvider)
          .track(
            const AnalyticsEvent(name: AnalyticsEventName.appModeSelected),
          ),
    );
    unawaited(ref.read(notificationServiceProvider).syncSession(state));
    _persist();
  }

  void setPendingProtectedAction({
    required String path,
    required ProtectedActionRequirement requirement,
    AuthIntent? preferredAuthIntent,
    String? artistId,
  }) {
    state = state.copyWith(
      pendingProtectedAction: PendingProtectedAction(
        path: path,
        requirement: requirement,
        preferredAuthIntent: preferredAuthIntent,
        artistId: artistId,
      ),
    );
    _persist();
  }

  void setPendingProtectedPath(
    String path,
    ProtectedActionRequirement requirement,
  ) {
    setPendingProtectedAction(path: path, requirement: requirement);
  }

  Future<AppResult<String>> signInAsCustomer({
    required String displayName,
    required String email,
    required String fallbackPath,
    AuthIntent intent = AuthIntent.signIn,
    bool useDebugDefaultAccount = false,
  }) async {
    return _completeAuth(
      mode: AppUserMode.customer,
      displayName: displayName,
      email: email,
      fallbackPath: fallbackPath,
      intent: intent,
      useDebugDefaultAccount: useDebugDefaultAccount,
    );
  }

  Future<AppResult<String>> activateCustomer({required String fallbackPath}) {
    final summary = state.userSummary;
    return signInAsCustomer(
      displayName: summary?.displayName ?? 'Sana Malik',
      email: summary?.email ?? 'sana.malik@example.com',
      fallbackPath: fallbackPath,
    );
  }

  Future<AppResult<String>> signInAsArtist({
    required String displayName,
    required String email,
    required String fallbackPath,
    AuthIntent intent = AuthIntent.signIn,
    String? artistProfileId,
    bool useDebugDefaultAccount = false,
  }) async {
    return _completeAuth(
      mode: AppUserMode.artist,
      displayName: displayName,
      email: email,
      fallbackPath: fallbackPath,
      intent: intent,
      artistProfileId: artistProfileId,
      useDebugDefaultAccount: useDebugDefaultAccount,
    );
  }

  Future<AppResult<String>> activateArtist({required String fallbackPath}) {
    final summary = state.userSummary;
    return signInAsArtist(
      displayName: summary?.displayName ?? 'Aaliyah Noor',
      email: summary?.email ?? 'artist@glam2go.example',
      fallbackPath: fallbackPath,
      artistProfileId: summary?.artistProfileId,
    );
  }

  void switchToCustomer() {
    state = state.copyWith(
      userMode: AppUserMode.customer,
      authStatus: AuthStatus.authenticated,
      clearPendingProtectedAction: true,
    );
    _persist();
  }

  void switchToArtist() {
    state = state.copyWith(
      userMode: AppUserMode.artist,
      authStatus: AuthStatus.authenticated,
      clearPendingProtectedAction: true,
    );
    _persist();
  }

  void clearPendingProtectedAction() {
    state = state.copyWith(clearPendingProtectedAction: true);
    _persist();
  }

  void clearPendingProtectedPath() {
    clearPendingProtectedAction();
  }

  void signOut() {
    state = const SessionState.guest();
    unawaited(ref.read(notificationServiceProvider).syncSession(state));
    unawaited(ref.read(sessionRepositoryProvider).signOut());
  }

  Future<AppResult<String>> _completeAuth({
    required AppUserMode mode,
    required String displayName,
    required String email,
    required String fallbackPath,
    required AuthIntent intent,
    String? artistProfileId,
    bool useDebugDefaultAccount = false,
  }) async {
    final destination = state.pendingProtectedAction?.path ?? fallbackPath;
    final authResult = intent == AuthIntent.signIn
        ? await ref
              .read(sessionRepositoryProvider)
              .signIn(
                displayName: displayName,
                email: email,
                mode: mode,
                intent: intent,
                artistProfileId: artistProfileId,
                useDebugDefaultAccount: useDebugDefaultAccount,
              )
        : await ref
              .read(sessionRepositoryProvider)
              .signUp(
                displayName: displayName,
                email: email,
                mode: mode,
                intent: intent,
                artistProfileId: artistProfileId,
                useDebugDefaultAccount: useDebugDefaultAccount,
              );

    if (authResult.dataOrNull == null) {
      final failure = authResult.failureOrNull!;
      unawaited(
        ref
            .read(analyticsServiceProvider)
            .track(
              AnalyticsEvent(
                name: intent == AuthIntent.signIn
                    ? AnalyticsEventName.signInFailed
                    : AnalyticsEventName.signUpFailed,
                parameters: {'mode': mode.name},
              ),
            ),
      );
      unawaited(
        ref
            .read(crashReportingServiceProvider)
            .recordError(
              failure.message,
              context: CrashReportingContext(
                reason: 'session_auth_failed',
                metadata: {
                  'mode': mode.name,
                  'intent': intent.name,
                  'type': failure.type.name,
                },
              ),
            ),
      );
      return AppFailureResult(authResult.failureOrNull!);
    }

    state = authResult.dataOrNull!.copyWith(hasHydrated: true);
    unawaited(
      ref
          .read(analyticsServiceProvider)
          .track(
            AnalyticsEvent(
              name: intent == AuthIntent.signIn
                  ? AnalyticsEventName.signInSucceeded
                  : AnalyticsEventName.signUpSucceeded,
              parameters: {'mode': mode.name},
            ),
          ),
    );
    unawaited(ref.read(notificationServiceProvider).syncSession(state));
    return AppSuccess(destination);
  }

  Future<void> _restore() async {
    final result = await ref.read(sessionRepositoryProvider).loadSession();
    final restored = result.dataOrNull;
    if (restored == null) {
      if (!state.hasHydrated) {
        state = const SessionState.guest();
        unawaited(ref.read(notificationServiceProvider).syncSession(state));
      }
      return;
    }

    state = restored.copyWith(hasHydrated: true);
    unawaited(ref.read(notificationServiceProvider).syncSession(state));
  }

  void _persist() {
    unawaited(
      ref
          .read(sessionRepositoryProvider)
          .saveSession(state.copyWith(hasHydrated: true)),
    );
  }
}

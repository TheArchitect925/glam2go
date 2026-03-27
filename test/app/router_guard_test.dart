import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:glam2go/app/app_router.dart';
import 'package:glam2go/core/l10n/localization.dart';
import 'package:glam2go/core/theme/app_theme.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';

void main() {
  Future<void> pumpRouter(WidgetTester tester, GoRouter router) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizationSetup.delegates,
          supportedLocales: AppLocalizationSetup.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('authenticated customer is redirected away from sign in', (
    tester,
  ) async {
    final router = buildAppRouter(
      const SessionState.authenticated(
        userMode: AppUserMode.customer,
        userSummary: SessionUserSummary(
          userId: 'customer-sana-malik',
          displayName: 'Sana Malik',
          email: 'sana.malik@example.com',
          mode: AppUserMode.customer,
          isNewAccount: false,
        ),
      ),
      initialLocation: AppRoutePaths.signIn,
    );

    await pumpRouter(tester, router);

    expect(router.routeInformationProvider.value.uri.path, AppRoutePaths.home);
  });

  testWidgets('ready artist is redirected away from artist onboarding', (
    tester,
  ) async {
    final router = buildAppRouter(
      const SessionState.authenticated(
        userMode: AppUserMode.artist,
        userSummary: SessionUserSummary(
          userId: 'artist-aaliyah-noor',
          displayName: 'Aaliyah Noor',
          email: 'artist@glam2go.example',
          mode: AppUserMode.artist,
          isNewAccount: false,
          artistProfileId: 'aaliyah-noor',
        ),
      ),
      artistReadinessProgress: 1,
      initialLocation: AppRoutePaths.artistOnboarding,
    );

    await pumpRouter(tester, router);

    expect(
      router.routeInformationProvider.value.uri.path,
      AppRoutePaths.artistDashboard,
    );
  });

  testWidgets('guest is redirected away from protected artist routes', (
    tester,
  ) async {
    final router = buildAppRouter(
      const SessionState.guest(),
      initialLocation: AppRoutePaths.artistDashboard,
    );

    await pumpRouter(tester, router);

    expect(
      router.routeInformationProvider.value.uri.path,
      AppRoutePaths.artistOnboarding,
    );
  });

  testWidgets('guest can open privacy policy route directly', (tester) async {
    final router = buildAppRouter(
      const SessionState.guest(),
      initialLocation: AppRoutePaths.privacyPolicy,
    );

    await pumpRouter(tester, router);

    expect(
      router.routeInformationProvider.value.uri.path,
      AppRoutePaths.privacyPolicy,
    );
  });

  testWidgets('guest can open support and booking policy routes directly', (
    tester,
  ) async {
    final supportRouter = buildAppRouter(
      const SessionState.guest(),
      initialLocation: AppRoutePaths.support,
    );

    await pumpRouter(tester, supportRouter);

    expect(
      supportRouter.routeInformationProvider.value.uri.path,
      AppRoutePaths.support,
    );

    final bookingPolicyRouter = buildAppRouter(
      const SessionState.guest(),
      initialLocation: AppRoutePaths.bookingPolicy,
    );

    await pumpRouter(tester, bookingPolicyRouter);

    expect(
      bookingPolicyRouter.routeInformationProvider.value.uri.path,
      AppRoutePaths.bookingPolicy,
    );
  });
}

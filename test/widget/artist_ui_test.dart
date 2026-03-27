import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/core/l10n/localization.dart';
import 'package:glam2go/core/theme/app_theme.dart';
import 'package:glam2go/features/artist_availability/presentation/screens/artist_availability_screen.dart';
import 'package:glam2go/features/artist_bookings/presentation/screens/artist_bookings_screen.dart';
import 'package:glam2go/features/artist_dashboard/presentation/screens/artist_dashboard_screen.dart';
import 'package:glam2go/features/artist_packages/presentation/screens/artist_packages_screen.dart';
import 'package:glam2go/features/session/application/session_providers.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> pumpArtistScreen(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sessionControllerProvider.overrideWith(ArtistSessionController.new),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizationSetup.delegates,
          supportedLocales: AppLocalizationSetup.supportedLocales,
          home: child,
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('artist dashboard renders readiness and quick actions', (
    tester,
  ) async {
    await pumpArtistScreen(tester, const ArtistDashboardScreen());

    expect(find.text('Profile readiness'), findsOneWidget);
    expect(find.text('Quick actions'), findsOneWidget);
    expect(find.text('Manage packages'), findsOneWidget);
    expect(find.text('View bookings'), findsOneWidget);
  });

  testWidgets('artist packages screen renders package management surface', (
    tester,
  ) async {
    await pumpArtistScreen(tester, const ArtistPackagesScreen());

    expect(find.text('Manage packages and services.'), findsOneWidget);
    expect(find.text('Signature Bridal'), findsOneWidget);
    expect(find.text('Mark inactive'), findsWidgets);
  });

  testWidgets('artist availability screen renders weekly setup rows', (
    tester,
  ) async {
    await pumpArtistScreen(tester, const ArtistAvailabilityScreen());

    expect(find.text('Set weekly availability.'), findsOneWidget);
    expect(find.text('Monday'), findsOneWidget);
    expect(find.text('Add time window'), findsWidgets);
  });

  testWidgets('artist bookings screen renders requests tab and actions', (
    tester,
  ) async {
    await pumpArtistScreen(tester, const ArtistBookingsScreen());

    expect(find.text('Requests'), findsOneWidget);
    expect(find.text('Accept request'), findsOneWidget);
    expect(find.text('Decline request'), findsOneWidget);
  });
}

class ArtistSessionController extends SessionController {
  @override
  SessionState build() => const SessionState.authenticated(
    userMode: AppUserMode.artist,
    userSummary: SessionUserSummary(
      userId: 'artist-aaliyah-noor',
      displayName: 'Aaliyah Noor',
      email: 'artist@glam2go.example',
      mode: AppUserMode.artist,
      isNewAccount: false,
      artistProfileId: 'aaliyah-noor',
    ),
  );
}

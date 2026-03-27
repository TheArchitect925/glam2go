import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/core/l10n/localization.dart';
import 'package:glam2go/core/theme/app_theme.dart';
import 'package:glam2go/features/bookings/presentation/screens/booking_detail_screen.dart';
import 'package:glam2go/features/bookings/presentation/screens/bookings_screen.dart';
import 'package:glam2go/features/profile/presentation/screens/profile_screen.dart';
import 'package:glam2go/features/session/application/session_providers.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> pumpAccountScreen(
    WidgetTester tester,
    Widget child, {
    bool asCustomer = false,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (asCustomer)
            sessionControllerProvider.overrideWith(
              CustomerSessionController.new,
            ),
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

  testWidgets('guest bookings screen renders access gate', (tester) async {
    await pumpAccountScreen(tester, const BookingsScreen());

    expect(find.text('Sign in to view your bookings'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('bookings screen renders upcoming and past tabs', (tester) async {
    await pumpAccountScreen(tester, const BookingsScreen(), asCustomer: true);

    expect(find.text('Upcoming'), findsOneWidget);
    expect(find.text('Past'), findsOneWidget);
    expect(find.text('Aaliyah Noor'), findsWidgets);
    expect(find.text('Signature Bridal'), findsOneWidget);
  });

  testWidgets('booking detail renders summary and policy sections', (
    tester,
  ) async {
    await pumpAccountScreen(
      tester,
      const BookingDetailScreen(bookingId: 'bk-upcoming-bridal'),
      asCustomer: true,
    );

    expect(find.text('Booking summary'), findsOneWidget);
    expect(find.text('Request timeline'), findsOneWidget);
    expect(find.text('What happens next'), findsOneWidget);
    expect(find.text('Policy and support'), findsOneWidget);
  });

  testWidgets('profile screen renders account hub sections', (tester) async {
    await pumpAccountScreen(tester, const ProfileScreen(), asCustomer: true);

    expect(find.text('Account hub'), findsOneWidget);
    expect(find.text('Preferences'), findsOneWidget);
    expect(find.text('Saved addresses'), findsOneWidget);
  });
}

class CustomerSessionController extends SessionController {
  @override
  SessionState build() => const SessionState.authenticated(
    userMode: AppUserMode.customer,
    userSummary: SessionUserSummary(
      userId: 'customer-sana-malik',
      displayName: 'Sana Malik',
      email: 'sana.malik@example.com',
      mode: AppUserMode.customer,
      isNewAccount: false,
    ),
  );
}

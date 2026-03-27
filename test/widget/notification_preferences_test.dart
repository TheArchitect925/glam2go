import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/core/l10n/localization.dart';
import 'package:glam2go/core/theme/app_theme.dart';
import 'package:glam2go/features/profile/presentation/screens/notification_preferences_screen.dart';
import 'package:glam2go/features/session/application/session_providers.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('customer notification preferences render lifecycle toggles', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sessionControllerProvider.overrideWith(CustomerSessionController.new),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizationSetup.delegates,
          supportedLocales: AppLocalizationSetup.supportedLocales,
          home: const NotificationPreferencesScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Manage notifications'), findsOneWidget);
    expect(find.text('Booking updates'), findsOneWidget);
    expect(find.text('Artist responses'), findsOneWidget);
    expect(find.text('Appointment reminders'), findsOneWidget);
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

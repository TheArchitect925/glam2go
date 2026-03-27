import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/core/config/app_config.dart';
import 'package:glam2go/core/config/app_environment.dart';
import 'package:glam2go/features/session/application/session_providers.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('sign in resumes pending protected destination', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container
        .read(sessionControllerProvider.notifier)
        .setPendingProtectedAction(
          path: '/booking/review',
          requirement: ProtectedActionRequirement.bookingSubmission,
          preferredAuthIntent: AuthIntent.signIn,
        );

    final destination = await container
        .read(sessionControllerProvider.notifier)
        .signInAsCustomer(
          displayName: 'Sana Malik',
          email: 'sana.malik@example.com',
          fallbackPath: '/home',
        );

    final state = container.read(sessionControllerProvider);
    expect(destination.dataOrNull, '/booking/review');
    expect(state.isCustomer, isTrue);
    expect(state.isAuthenticated, isTrue);
    expect(state.userSummary?.displayName, 'Sana Malik');
    expect(state.pendingProtectedAction, isNull);
  });

  test('session controller restores persisted session state', () async {
    SharedPreferences.setMockInitialValues({
      'glam2go.session_state.v1': jsonEncode({
        'userMode': 'customer',
        'authStatus': 'authenticated',
        'userSummary': {
          'userId': 'customer-sana-malik',
          'displayName': 'Sana Malik',
          'email': 'sana.malik@example.com',
          'mode': 'customer',
          'isNewAccount': false,
        },
      }),
    });

    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(sessionControllerProvider);
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final state = container.read(sessionControllerProvider);
    expect(state.hasHydrated, isTrue);
    expect(state.isCustomer, isTrue);
    expect(state.userSummary?.email, 'sana.malik@example.com');
  });

  test(
    'debug default account sign in succeeds with remote session enabled',
    () async {
      final container = ProviderContainer(
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(
              environment: AppEnvironment.development,
              apiBaseUrl: 'https://api.dev.glam2go.example',
              enableLocalPersistence: true,
              enableDebugDefaultAccounts: true,
              enableLifecycleTimeline: true,
              enableRemoteSession: true,
              enableRemoteDiscovery: false,
              enableRemoteBookings: false,
              enableRemoteArtistManagement: false,
              enableNotificationDelivery: false,
              enableAnalytics: true,
              enableCrashReporting: false,
              enableApiDebugLogging: false,
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final result = await container
          .read(sessionControllerProvider.notifier)
          .signInAsCustomer(
            displayName: 'Sana Malik',
            email: 'sana.malik@example.com',
            fallbackPath: '/home',
            useDebugDefaultAccount: true,
          );

      expect(result.dataOrNull, '/home');
      expect(container.read(sessionControllerProvider).isCustomer, isTrue);
    },
  );
}

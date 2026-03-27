import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/core/config/app_config.dart';
import 'package:glam2go/core/config/app_environment.dart';
import 'package:glam2go/core/errors/app_failure.dart';
import 'package:glam2go/core/result/app_result.dart';
import 'package:glam2go/core/network/app_api_client.dart';
import 'package:glam2go/features/session/data/dtos/session_storage_dto.dart';
import 'package:glam2go/features/session/data/local_session_storage.dart';
import 'package:glam2go/features/session/data/remote/session_remote_data_source.dart';
import 'package:glam2go/features/session/data/repositories/hybrid_session_repository.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';

import '../support/fake_api_client.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  const remoteConfig = AppConfig(
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
  );

  test('hybrid session repository stores remote sign in payload', () async {
    final storage = const LocalSessionStorage();
    final repository = HybridSessionRepository(
      storage: storage,
      remoteDataSource: SessionRemoteDataSource(
        FakeAppApiClient(
          handlers: {
            'POST /v1/auth/sign-in': (request) async => AppSuccess(
              const ApiResponse(
                statusCode: 200,
                data: {
                  'token': 'session-token-123',
                  'user': {
                    'userId': 'customer-sana-malik',
                    'displayName': 'Sana Malik',
                    'email': 'sana.malik@example.com',
                    'role': 'customer',
                    'isNewAccount': false,
                  },
                },
              ),
            ),
          },
        ),
      ),
      config: remoteConfig,
    );

    final result = await repository.signIn(
      displayName: 'Sana Malik',
      email: 'sana.malik@example.com',
      mode: AppUserMode.customer,
      intent: AuthIntent.signIn,
    );

    expect(result.dataOrNull?.isCustomer, isTrue);
    final stored = await storage.load();
    expect(stored?.authToken, 'session-token-123');
    expect(stored?.userSummary?['displayName'], 'Sana Malik');
  });

  test(
    'hybrid session repository falls back to debug customer account locally',
    () async {
      final storage = const LocalSessionStorage();
      final repository = HybridSessionRepository(
        storage: storage,
        remoteDataSource: SessionRemoteDataSource(
          FakeAppApiClient(
            handlers: {
              'POST /v1/auth/sign-in': (request) async => AppFailureResult(
                const AppFailure(
                  type: AppFailureType.network,
                  message: 'Remote auth should not be used for debug shortcut.',
                ),
              ),
            },
          ),
        ),
        config: remoteConfig,
      );

      final result = await repository.signIn(
        displayName: 'Sana Malik',
        email: 'sana.malik@example.com',
        mode: AppUserMode.customer,
        intent: AuthIntent.signIn,
        useDebugDefaultAccount: true,
      );

      expect(result.dataOrNull?.isCustomer, isTrue);
      expect(result.failureOrNull, isNull);
      final stored = await storage.load();
      expect(stored?.authToken, isNull);
      expect(stored?.userSummary?['email'], 'sana.malik@example.com');
    },
  );

  test(
    'hybrid session repository falls back to debug artist account locally',
    () async {
      final storage = const LocalSessionStorage();
      final repository = HybridSessionRepository(
        storage: storage,
        remoteDataSource: SessionRemoteDataSource(
          FakeAppApiClient(
            handlers: {
              'POST /v1/auth/sign-in': (request) async => AppFailureResult(
                const AppFailure(
                  type: AppFailureType.network,
                  message: 'Remote auth should not be used for debug shortcut.',
                ),
              ),
            },
          ),
        ),
        config: remoteConfig,
      );

      final result = await repository.signIn(
        displayName: 'Aaliyah Noor',
        email: 'artist@glam2go.example',
        mode: AppUserMode.artist,
        intent: AuthIntent.signIn,
        artistProfileId: 'aaliyah-noor',
        useDebugDefaultAccount: true,
      );

      expect(result.dataOrNull?.isArtist, isTrue);
      expect(result.failureOrNull, isNull);
      final stored = await storage.load();
      expect(stored?.authToken, isNull);
      expect(stored?.userSummary?['artistProfileId'], 'aaliyah-noor');
    },
  );

  test(
    'hybrid session repository clears unauthorized persisted session',
    () async {
      final storage = const LocalSessionStorage();
      await storage.save(
        SessionStorageDto.fromDomain(
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
          authToken: 'expired-token',
        ),
      );

      final repository = HybridSessionRepository(
        storage: storage,
        remoteDataSource: SessionRemoteDataSource(
          FakeAppApiClient(
            handlers: {
              'GET /v1/session': (request) async =>
                  const AppSuccess(ApiResponse(statusCode: 401, data: {})),
            },
          ),
        ),
        config: remoteConfig,
      );

      final restored = await repository.loadSession();

      expect(restored.dataOrNull?.isGuest, isTrue);
      expect(await storage.load(), isNull);
    },
  );
}

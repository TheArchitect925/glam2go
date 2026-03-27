import 'package:flutter_test/flutter_test.dart';

import 'package:glam2go/core/config/app_config.dart';
import 'package:glam2go/core/config/app_environment.dart';
import 'package:glam2go/core/notifications/notification_service.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';

void main() {
  const enabledConfig = AppConfig(
    environment: AppEnvironment.development,
    apiBaseUrl: 'https://api.dev.glam2go.example',
    enableLocalPersistence: true,
    enableDebugDefaultAccounts: true,
    enableLifecycleTimeline: true,
    enableRemoteSession: false,
    enableRemoteDiscovery: false,
    enableRemoteBookings: false,
    enableRemoteArtistManagement: false,
    enableNotificationDelivery: true,
    enableAnalytics: true,
    enableCrashReporting: false,
    enableApiDebugLogging: false,
  );

  test(
    'notification service marks authenticated sessions as delivery-ready',
    () async {
      const service = PlaceholderNotificationService(enabledConfig);

      final result = await service.syncSession(
        const SessionState.authenticated(
          userMode: AppUserMode.customer,
          userSummary: SessionUserSummary(
            userId: 'customer-1',
            displayName: 'Sana Malik',
            email: 'sana@example.com',
            mode: AppUserMode.customer,
            isNewAccount: false,
          ),
        ),
      );

      expect(result.capability, NotificationDeliveryCapability.structureReady);
      expect(result.isSessionBound, isTrue);
    },
  );
}

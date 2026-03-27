import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/session/domain/models/session_models.dart';
import '../config/app_config.dart';

enum NotificationPermissionState {
  notDetermined,
  unavailable,
  structurallyReady,
}

enum NotificationDeliveryCapability { unavailable, structureReady }

enum NotificationEventType {
  bookingRequestSubmitted,
  bookingAccepted,
  bookingDeclined,
  bookingStatusUpdated,
  bookingReminder,
  artistOperationalAlert,
}

@immutable
class NotificationEvent {
  const NotificationEvent({
    required this.type,
    required this.recipientMode,
    this.referenceId,
  });

  final NotificationEventType type;
  final AppUserMode recipientMode;
  final String? referenceId;
}

@immutable
class DeviceRegistrationState {
  const DeviceRegistrationState({
    required this.permissionState,
    required this.capability,
    required this.isSessionBound,
  });

  const DeviceRegistrationState.unavailable()
    : permissionState = NotificationPermissionState.unavailable,
      capability = NotificationDeliveryCapability.unavailable,
      isSessionBound = false;

  final NotificationPermissionState permissionState;
  final NotificationDeliveryCapability capability;
  final bool isSessionBound;
}

abstract class NotificationService {
  const NotificationService();

  Future<DeviceRegistrationState> syncSession(SessionState session);

  Future<void> handleEvent(NotificationEvent event);
}

class PlaceholderNotificationService implements NotificationService {
  const PlaceholderNotificationService(this._config);

  final AppConfig _config;

  @override
  Future<void> handleEvent(NotificationEvent event) async {
    if (!_config.enableNotificationDelivery) {
      return;
    }
    debugPrint(
      '[notifications] ${event.type.name} for ${event.recipientMode.name} (${event.referenceId ?? 'n/a'})',
    );
  }

  @override
  Future<DeviceRegistrationState> syncSession(SessionState session) async {
    if (!_config.enableNotificationDelivery) {
      return const DeviceRegistrationState.unavailable();
    }

    return DeviceRegistrationState(
      permissionState: NotificationPermissionState.structurallyReady,
      capability: NotificationDeliveryCapability.structureReady,
      isSessionBound: session.isAuthenticated,
    );
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return PlaceholderNotificationService(ref.watch(appConfigProvider));
});

final notificationDeliveryRefreshProvider = StateProvider<int>((ref) => 0);

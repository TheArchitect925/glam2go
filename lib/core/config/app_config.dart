import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_environment.dart';

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLocalPersistence,
    required this.enableDebugDefaultAccounts,
    required this.enableLifecycleTimeline,
    required this.enableRemoteSession,
    required this.enableRemoteDiscovery,
    required this.enableRemoteBookings,
    required this.enableRemoteArtistManagement,
    required this.enableNotificationDelivery,
    required this.enableAnalytics,
    required this.enableCrashReporting,
    required this.enableApiDebugLogging,
  });

  factory AppConfig.fromEnvironment() {
    const envValue = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'development',
    );
    const configuredApiBaseUrl = String.fromEnvironment('API_BASE_URL');

    final environment = switch (envValue) {
      'production' => AppEnvironment.production,
      'staging' => AppEnvironment.staging,
      _ => AppEnvironment.development,
    };
    final apiBaseUrl = configuredApiBaseUrl.isNotEmpty
        ? configuredApiBaseUrl
        : switch (environment) {
            AppEnvironment.production => 'https://api.glam2go.example',
            AppEnvironment.staging => 'https://api.staging.glam2go.example',
            AppEnvironment.development => 'https://api.dev.glam2go.example',
          };
    const debugDefaultAccountsValue = String.fromEnvironment(
      'ENABLE_DEBUG_DEFAULT_ACCOUNTS',
      defaultValue: '',
    );
    final enableDebugDefaultAccounts = switch (debugDefaultAccountsValue) {
      'true' => true,
      'false' => false,
      _ => environment == AppEnvironment.development,
    };

    return AppConfig(
      environment: environment,
      apiBaseUrl: apiBaseUrl,
      enableLocalPersistence: const bool.fromEnvironment(
        'ENABLE_LOCAL_PERSISTENCE',
        defaultValue: true,
      ),
      enableDebugDefaultAccounts: enableDebugDefaultAccounts,
      enableLifecycleTimeline: const bool.fromEnvironment(
        'ENABLE_LIFECYCLE_TIMELINE',
        defaultValue: true,
      ),
      enableRemoteSession: const bool.fromEnvironment(
        'ENABLE_REMOTE_SESSION',
        defaultValue: false,
      ),
      enableRemoteDiscovery: const bool.fromEnvironment(
        'ENABLE_REMOTE_DISCOVERY',
        defaultValue: false,
      ),
      enableRemoteBookings: const bool.fromEnvironment(
        'ENABLE_REMOTE_BOOKINGS',
        defaultValue: false,
      ),
      enableRemoteArtistManagement: const bool.fromEnvironment(
        'ENABLE_REMOTE_ARTIST_MANAGEMENT',
        defaultValue: false,
      ),
      enableNotificationDelivery: const bool.fromEnvironment(
        'ENABLE_NOTIFICATION_DELIVERY',
        defaultValue: false,
      ),
      enableAnalytics: const bool.fromEnvironment(
        'ENABLE_ANALYTICS',
        defaultValue: true,
      ),
      enableCrashReporting: const bool.fromEnvironment(
        'ENABLE_CRASH_REPORTING',
        defaultValue: false,
      ),
      enableApiDebugLogging: const bool.fromEnvironment(
        'ENABLE_API_DEBUG_LOGGING',
        defaultValue: false,
      ),
    );
  }

  final AppEnvironment environment;
  final String apiBaseUrl;
  final bool enableLocalPersistence;
  final bool enableDebugDefaultAccounts;
  final bool enableLifecycleTimeline;
  final bool enableRemoteSession;
  final bool enableRemoteDiscovery;
  final bool enableRemoteBookings;
  final bool enableRemoteArtistManagement;
  final bool enableNotificationDelivery;
  final bool enableAnalytics;
  final bool enableCrashReporting;
  final bool enableApiDebugLogging;
}

final appConfigProvider = Provider<AppConfig>((ref) {
  return AppConfig.fromEnvironment();
});

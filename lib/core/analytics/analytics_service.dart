import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';

enum AnalyticsEventName {
  appModeSelected,
  guestProtectedActionTriggered,
  signInSucceeded,
  signInFailed,
  signUpSucceeded,
  signUpFailed,
  artistProfileViewed,
  artistProfileSaved,
  bookingFlowStarted,
  bookingRequestSubmitted,
  artistRequestAccepted,
  artistRequestDeclined,
  artistPackageSaved,
  artistAvailabilitySaved,
  artistTravelPolicySaved,
  artistPortfolioSaved,
  artistPortfolioRemoved,
}

@immutable
class AnalyticsEvent {
  const AnalyticsEvent({
    required this.name,
    this.parameters = const <String, Object?>{},
  });

  final AnalyticsEventName name;
  final Map<String, Object?> parameters;
}

abstract class AnalyticsService {
  const AnalyticsService();

  Future<void> track(AnalyticsEvent event);
}

class DebugAnalyticsService implements AnalyticsService {
  const DebugAnalyticsService(this._config);

  final AppConfig _config;

  @override
  Future<void> track(AnalyticsEvent event) async {
    if (!_config.enableAnalytics) {
      return;
    }
    debugPrint('[analytics] ${event.name.name}: ${event.parameters}');
  }
}

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return DebugAnalyticsService(ref.watch(appConfigProvider));
});

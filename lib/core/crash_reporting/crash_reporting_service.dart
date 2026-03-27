import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';

@immutable
class CrashReportingContext {
  const CrashReportingContext({
    required this.reason,
    this.metadata = const <String, Object?>{},
  });

  final String reason;
  final Map<String, Object?> metadata;
}

abstract class CrashReportingService {
  const CrashReportingService();

  Future<void> recordError(
    Object error, {
    StackTrace? stackTrace,
    CrashReportingContext? context,
    bool fatal = false,
  });

  Future<void> recordFlutterError(
    FlutterErrorDetails details, {
    CrashReportingContext? context,
    bool fatal = false,
  });
}

class DebugCrashReportingService implements CrashReportingService {
  const DebugCrashReportingService(this._config);

  final AppConfig _config;

  @override
  Future<void> recordError(
    Object error, {
    StackTrace? stackTrace,
    CrashReportingContext? context,
    bool fatal = false,
  }) async {
    if (!_config.enableCrashReporting) {
      return;
    }
    debugPrint(
      '[crash] fatal=$fatal reason=${context?.reason ?? 'unknown'} error=$error',
    );
    if (stackTrace != null) {
      debugPrint(stackTrace.toString());
    }
  }

  @override
  Future<void> recordFlutterError(
    FlutterErrorDetails details, {
    CrashReportingContext? context,
    bool fatal = false,
  }) {
    return recordError(
      details.exception,
      stackTrace: details.stack,
      context: context,
      fatal: fatal,
    );
  }
}

final crashReportingServiceProvider = Provider<CrashReportingService>((ref) {
  return DebugCrashReportingService(ref.watch(appConfigProvider));
});

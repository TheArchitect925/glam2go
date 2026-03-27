import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/crash_reporting/crash_reporting_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  final crashReporting = container.read(crashReportingServiceProvider);

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    unawaited(
      crashReporting.recordFlutterError(
        details,
        fatal: true,
        context: const CrashReportingContext(reason: 'flutter_error'),
      ),
    );
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    unawaited(
      crashReporting.recordError(
        error,
        stackTrace: stackTrace,
        fatal: true,
        context: const CrashReportingContext(reason: 'platform_dispatcher'),
      ),
    );
    return true;
  };

  runApp(
    UncontrolledProviderScope(container: container, child: const Glam2GoApp()),
  );
}

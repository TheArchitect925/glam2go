import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/l10n/localization.dart';
import '../core/theme/app_theme.dart';
import 'app_providers.dart';

class Glam2GoApp extends ConsumerWidget {
  const Glam2GoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Glam2GO',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizationSetup.delegates,
      supportedLocales: AppLocalizationSetup.supportedLocales,
    );
  }
}

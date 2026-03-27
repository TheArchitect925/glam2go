import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:glam2go/core/l10n/localization.dart';
import 'package:glam2go/core/theme/app_theme.dart';
import 'package:glam2go/features/profile/presentation/screens/policy_surface_screen.dart';
import 'package:glam2go/features/profile/presentation/screens/support_screen.dart';

void main() {
  Future<void> pumpScreen(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizationSetup.delegates,
        supportedLocales: AppLocalizationSetup.supportedLocales,
        home: child,
      ),
    );
    await tester.pump();
  }

  testWidgets('support screen renders policy and FAQ sections', (tester) async {
    await pumpScreen(tester, const SupportScreen());

    expect(find.text('Help and policies'), findsOneWidget);
    expect(find.text('Get help'), findsOneWidget);
    expect(find.text('Policies'), findsOneWidget);
    expect(find.text('Common questions'), findsOneWidget);
    expect(find.text('Privacy policy'), findsOneWidget);
    expect(find.text('Booking policy'), findsWidgets);
  });

  testWidgets('policy screen renders editable legal notice', (tester) async {
    await pumpScreen(
      tester,
      const PolicySurfaceScreen(surface: PolicySurfaceType.privacy),
    );

    expect(find.text('Privacy policy'), findsWidgets);
    expect(find.text('Draft legal content'), findsOneWidget);
    expect(find.text('What Glam2GO collects'), findsOneWidget);
  });
}

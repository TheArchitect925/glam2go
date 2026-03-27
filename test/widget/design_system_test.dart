import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:glam2go/core/l10n/localization.dart';
import 'package:glam2go/core/theme/app_theme.dart';
import 'package:glam2go/shared/widgets/app_button.dart';
import 'package:glam2go/shared/widgets/app_card.dart';

void main() {
  Future<void> pumpDesignSystem(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizationSetup.delegates,
        supportedLocales: AppLocalizationSetup.supportedLocales,
        home: Scaffold(body: Center(child: child)),
      ),
    );
    await tester.pump();
  }

  testWidgets('app button uses themed filled button styling', (tester) async {
    await pumpDesignSystem(
      tester,
      const AppButton(label: 'Book now', onPressed: null),
    );

    final buttonWidget = tester.widget<FilledButton>(find.byType(FilledButton));

    expect(find.text('Book now'), findsOneWidget);
    expect(buttonWidget.onPressed, isNull);
    expect(find.byType(FilledButton), findsOneWidget);
  });

  testWidgets('app card renders child content with standardized surface', (
    tester,
  ) async {
    await pumpDesignSystem(tester, const AppCard(child: Text('Card content')));

    expect(find.text('Card content'), findsOneWidget);
    expect(find.byType(AppCard), findsOneWidget);
  });
}

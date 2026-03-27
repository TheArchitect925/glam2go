import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:glam2go/core/l10n/localization.dart';
import 'package:glam2go/core/theme/app_theme.dart';
import 'package:glam2go/features/artist_profile/presentation/screens/artist_profile_screen.dart';
import 'package:glam2go/features/home/presentation/screens/home_screen.dart';

void main() {
  Future<void> pumpDiscoveryScreen(WidgetTester tester, Widget child) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizationSetup.delegates,
          supportedLocales: AppLocalizationSetup.supportedLocales,
          home: child,
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
  }

  testWidgets('home screen renders discovery sections', (tester) async {
    await pumpDiscoveryScreen(tester, const HomeScreen());

    expect(find.text('Featured artists'), findsOneWidget);
    expect(find.text('Popular packages'), findsOneWidget);
    expect(find.text('Aaliyah Noor'), findsOneWidget);
  });

  testWidgets('artist profile renders packages and travel details', (
    tester,
  ) async {
    await pumpDiscoveryScreen(
      tester,
      const ArtistProfileScreen(artistId: 'aaliyah-noor'),
    );

    expect(find.text('Aaliyah Noor'), findsOneWidget);
    expect(find.text('Packages and services'), findsOneWidget);
    expect(find.text('Signature Bridal'), findsOneWidget);
    expect(find.text('Travel and service area'), findsOneWidget);
  });
}

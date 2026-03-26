import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:glam2go/app/app.dart';

void main() {
  testWidgets('app boots to the Glam2GO baseline shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: Glam2GoApp()));
    await tester.pump();

    expect(find.text('Glam2GO'), findsWidgets);
    expect(find.text('Continue'), findsOneWidget);
  });
}

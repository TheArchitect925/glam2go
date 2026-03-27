import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:glam2go/core/l10n/localization.dart';
import 'package:glam2go/core/theme/app_theme.dart';
import 'package:glam2go/features/booking/application/booking_flow_controller.dart';
import 'package:glam2go/features/booking/presentation/screens/booking_review_screen.dart';

void main() {
  testWidgets('booking review screen shows selected booking summary', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizationSetup.delegates,
          supportedLocales: AppLocalizationSetup.supportedLocales,
          home: const BookingReviewScreen(),
        ),
      ),
    );

    final controller = container.read(bookingFlowControllerProvider.notifier);
    controller.startFlow(
      artistId: 'aaliyah-noor',
      preselectedPackageId: 'bridal-signature',
    );
    controller.updateEventDetails(
      occasion: 'Bridal',
      partySize: 1,
      notes: 'Natural skin finish',
    );
    await tester.pump();
    controller.selectDate(container.read(bookingAvailableDatesProvider).first);
    await tester.pump();
    controller.selectTime(
      container.read(bookingAvailableTimeSlotsProvider).first,
    );
    controller.updateLocation(
      addressLine1: '100 Queen Street West',
      unitDetails: '',
      cityArea: 'Toronto',
      accessNotes: '',
    );
    await tester.pump();

    expect(find.text('Review booking'), findsOneWidget);
    expect(find.text('Aaliyah Noor'), findsOneWidget);
    expect(find.text('Signature Bridal'), findsOneWidget);
    expect(find.text('Price summary'), findsOneWidget);
  });
}

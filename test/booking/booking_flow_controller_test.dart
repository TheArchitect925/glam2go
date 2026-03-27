import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glam2go/features/booking/application/booking_flow_controller.dart';

void main() {
  test('booking controller carries artist, package, and travel fee state', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final controller = container.read(bookingFlowControllerProvider.notifier);

    controller.startFlow(
      artistId: 'aaliyah-noor',
      preselectedPackageId: 'bridal-signature',
    );

    expect(
      container.read(bookingFlowControllerProvider).selectedPackage?.id,
      'bridal-signature',
    );

    controller.updateEventDetails(
      occasion: 'Bridal',
      partySize: 2,
      notes: 'Need a soft radiant finish',
    );

    final date = container.read(bookingAvailableDatesProvider).first;
    controller.selectDate(date);

    final time = container.read(bookingAvailableTimeSlotsProvider).first;
    controller.selectTime(time);

    controller.updateLocation(
      addressLine1: '88 Bay Street',
      unitDetails: 'Unit 1802',
      cityArea: 'Mississauga',
      accessNotes: 'Concierge access',
    );

    final draft = container.read(bookingFlowControllerProvider);
    expect(draft.canReview, true);
    expect(draft.travelFeeSummary?.isIncluded, false);
    expect(draft.priceSummary?.travelFee, 25);
    expect(draft.priceSummary?.total, 345);
  });
}

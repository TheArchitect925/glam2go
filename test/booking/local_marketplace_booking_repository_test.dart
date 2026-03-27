import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/features/booking/data/local_marketplace_booking_storage.dart';
import 'package:glam2go/features/booking/data/repositories/local_marketplace_booking_repository.dart';
import 'package:glam2go/features/booking/domain/models/booking_models.dart';
import 'package:glam2go/features/booking/domain/models/marketplace_booking_models.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
    'local marketplace booking repository persists lifecycle updates',
    () async {
      final repository = LocalMarketplaceBookingRepository(
        const LocalMarketplaceBookingStorage(),
      );

      final record = MarketplaceBookingRecord(
        id: 'bk-test',
        customerId: 'customer-sana',
        customerName: 'Sana Malik',
        artistId: 'aaliyah-noor',
        artistName: 'Aaliyah Noor',
        packageId: 'bridal-signature',
        packageTitle: 'Signature Bridal',
        status: BookingLifecycleStatus.pendingArtistResponse,
        scheduledAt: DateTime(2026, 4, 20),
        timeLabel: '9:00 AM',
        location: BookingLocation(
          addressLine1: '121 King Street West',
          unitDetails: 'Unit 1804',
          cityArea: 'Toronto',
          accessNotes: 'Concierge access',
        ),
        eventDetails: BookingEventDetails(
          occasion: 'Bridal',
          partySize: 1,
          notes: 'Soft glam bridal look',
        ),
        travelFeeSummary: TravelFeeSummary(
          isIncluded: true,
          locationKnown: true,
          fee: 0,
        ),
        priceSummary: BookingPriceSummary(
          subtotal: 320,
          travelFee: 0,
          total: 320,
        ),
        timeline: [
          BookingStatusTimelineEntry(
            status: BookingLifecycleStatus.pendingArtistResponse,
            occurredAt: DateTime(2026, 3, 26, 10, 0),
            note: 'Booking request submitted for artist review.',
          ),
        ],
        requestedAt: DateTime(2026, 3, 26, 10, 0),
        isUpcoming: true,
        originatedAsGuest: false,
        policySummary: 'Pending artist confirmation.',
        nextStepNote: 'Awaiting artist response.',
      );

      await repository.saveCache([record]);
      final restored = await repository.loadBookings();

      expect(restored.dataOrNull, hasLength(1));
      expect(
        restored.dataOrNull?.first.status,
        BookingLifecycleStatus.pendingArtistResponse,
      );
      expect(restored.dataOrNull?.first.customerName, 'Sana Malik');
    },
  );
}

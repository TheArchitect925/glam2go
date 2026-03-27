import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:glam2go/features/booking/application/booking_flow_controller.dart';
import 'package:glam2go/features/booking/application/marketplace_booking_providers.dart';
import 'package:glam2go/features/booking/domain/models/marketplace_booking_models.dart';
import 'package:glam2go/features/session/application/session_providers.dart';
import 'package:glam2go/features/session/domain/models/session_models.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
    'marketplace booking controller submits and updates request lifecycle',
    () async {
      final container = ProviderContainer(
        overrides: [
          sessionControllerProvider.overrideWith(CustomerSessionController.new),
        ],
      );
      addTearDown(container.dispose);
      await container.read(marketplaceBookingsControllerProvider.future);

      final draftController = container.read(
        bookingFlowControllerProvider.notifier,
      );
      draftController.startFlow(
        artistId: 'aaliyah-noor',
        preselectedPackageId: 'bridal-signature',
      );
      draftController.updateEventDetails(
        occasion: 'Bridal',
        partySize: 1,
        notes: 'Soft glam bridal look',
      );
      draftController.selectDate(
        container.read(bookingAvailableDatesProvider).first,
      );
      draftController.selectTime(
        container.read(bookingAvailableTimeSlotsProvider).first,
      );
      draftController.updateLocation(
        addressLine1: '121 King Street West',
        unitDetails: 'Unit 1804',
        cityArea: 'Toronto',
        accessNotes: 'Concierge access',
      );

      final detailsResult = await container
          .read(marketplaceBookingsControllerProvider.notifier)
          .submitCurrentDraftAsRequest();
      final details = detailsResult.dataOrNull;

      expect(details, isNotNull);
      final submitted = container.read(
        marketplaceBookingByIdProvider(details!.bookingId),
      );
      expect(
        submitted.valueOrNull?.status,
        BookingLifecycleStatus.pendingArtistResponse,
      );

      await container
          .read(marketplaceBookingsControllerProvider.notifier)
          .applyArtistDecision(
            details.bookingId,
            BookingRequestDecision.accept,
          );

      final accepted = container.read(
        marketplaceBookingByIdProvider(details.bookingId),
      );
      expect(accepted.valueOrNull?.status, BookingLifecycleStatus.accepted);
      expect(accepted.valueOrNull?.timeline.length, 2);

      await container
          .read(marketplaceBookingsControllerProvider.notifier)
          .cancelBookingRequest(details.bookingId);

      final cancelled = container.read(
        marketplaceBookingByIdProvider(details.bookingId),
      );
      expect(cancelled.valueOrNull?.status, BookingLifecycleStatus.cancelled);
      expect(cancelled.valueOrNull?.timeline.length, 3);
    },
  );
}

class CustomerSessionController extends SessionController {
  @override
  SessionState build() => const SessionState.authenticated(
    userMode: AppUserMode.customer,
    userSummary: SessionUserSummary(
      userId: 'customer-sana-malik',
      displayName: 'Sana Malik',
      email: 'sana.malik@example.com',
      mode: AppUserMode.customer,
      isNewAccount: false,
    ),
  );
}

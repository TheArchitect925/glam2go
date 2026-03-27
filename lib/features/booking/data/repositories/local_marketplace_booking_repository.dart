import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/app_result.dart';
import '../../../session/domain/models/session_models.dart';
import '../../domain/models/booking_models.dart';
import '../../domain/models/marketplace_booking_models.dart';
import '../../domain/repositories/marketplace_booking_repository.dart';
import '../dtos/marketplace_booking_dto.dart';
import '../local_marketplace_booking_storage.dart';
import '../mock_marketplace_bookings.dart';

class LocalMarketplaceBookingRepository
    implements MarketplaceBookingRepository {
  const LocalMarketplaceBookingRepository(this._storage);

  final LocalMarketplaceBookingStorage _storage;

  @override
  Future<AppResult<List<MarketplaceBookingRecord>>> loadBookings() async {
    try {
      final raw = await _storage.loadBookings();
      if (raw == null) {
        return AppSuccess(
          List<MarketplaceBookingRecord>.from(mockMarketplaceBookings),
        );
      }

      final records = raw
          .map(MarketplaceBookingDto.fromMap)
          .map((dto) => dto.toDomain())
          .toList(growable: false);
      return AppSuccess(records);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to restore marketplace bookings.',
          cause: error,
        ),
      );
    }
  }

  Future<AppResult<void>> saveCache(
    List<MarketplaceBookingRecord> records,
  ) async {
    try {
      await _storage.saveBookings(
        records
            .map(MarketplaceBookingDto.fromDomain)
            .map((dto) => dto.toMap())
            .toList(growable: false),
      );
      return const AppSuccess(null);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to persist marketplace bookings.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<MarketplaceBookingRecord>> submitBookingRequest({
    required BookingDraft draft,
    required SessionUserSummary customer,
    required bool originatedAsGuest,
  }) async {
    if (!draft.canReview ||
        draft.artistId == null ||
        draft.artistName == null ||
        draft.selectedPackage == null ||
        draft.eventDetails == null ||
        draft.dateSelection == null ||
        draft.timeSelection == null ||
        draft.location == null ||
        draft.travelFeeSummary == null ||
        draft.priceSummary == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.validation,
          message: 'Booking draft is incomplete and cannot be submitted.',
        ),
      );
    }

    final record = MarketplaceBookingRecord(
      id: 'g2g-${DateTime.now().millisecondsSinceEpoch}',
      customerId: customer.userId,
      customerName: customer.displayName,
      artistId: draft.artistId!,
      artistName: draft.artistName!,
      packageId: draft.selectedPackage!.id,
      packageTitle: draft.selectedPackage!.title,
      status: BookingLifecycleStatus.pendingArtistResponse,
      scheduledAt: draft.dateSelection!.date,
      timeLabel: draft.timeSelection!.label,
      location: draft.location!,
      eventDetails: draft.eventDetails!,
      travelFeeSummary: draft.travelFeeSummary!,
      priceSummary: draft.priceSummary!,
      requestedAt: DateTime.now(),
      isUpcoming: true,
      originatedAsGuest: originatedAsGuest,
      nextStepNote:
          'Your request is waiting on the artist to confirm availability, timing, and travel details.',
      policySummary:
          'This request is not a final confirmed appointment until the artist accepts it.',
      timeline: [
        BookingStatusTimelineEntry(
          status: BookingLifecycleStatus.pendingArtistResponse,
          occurredAt: DateTime.now(),
          note: 'Booking request submitted for artist review.',
        ),
      ],
    );

    final existing = await loadBookings();
    final updated = [
      record,
      ...(existing.dataOrNull ?? const <MarketplaceBookingRecord>[]),
    ];
    final saveResult = await saveCache(updated);
    if (saveResult.isFailure) {
      return AppFailureResult(saveResult.failureOrNull!);
    }
    return AppSuccess(record);
  }

  @override
  Future<AppResult<MarketplaceBookingRecord>> applyArtistDecision({
    required String bookingId,
    required BookingRequestDecision decision,
  }) async {
    final existing = await loadBookings();
    final records = existing.dataOrNull;
    if (records == null) {
      return AppFailureResult(existing.failureOrNull!);
    }
    final index = records.indexWhere((item) => item.id == bookingId);
    if (index < 0) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.validation,
          message: 'Booking request could not be found.',
        ),
      );
    }

    final updatedRecord = _applyDecision(records[index], decision);
    final updated = [...records];
    updated[index] = updatedRecord;
    final saveResult = await saveCache(updated);
    if (saveResult.isFailure) {
      return AppFailureResult(saveResult.failureOrNull!);
    }
    return AppSuccess(updatedRecord);
  }

  @override
  Future<AppResult<MarketplaceBookingRecord>> cancelBookingRequest(
    String bookingId,
  ) async {
    final existing = await loadBookings();
    final records = existing.dataOrNull;
    if (records == null) {
      return AppFailureResult(existing.failureOrNull!);
    }
    final index = records.indexWhere((item) => item.id == bookingId);
    if (index < 0) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.validation,
          message: 'Booking request could not be found.',
        ),
      );
    }

    final updatedRecord = _cancelRecord(records[index]);
    final updated = [...records];
    updated[index] = updatedRecord;
    final saveResult = await saveCache(updated);
    if (saveResult.isFailure) {
      return AppFailureResult(saveResult.failureOrNull!);
    }
    return AppSuccess(updatedRecord);
  }

  MarketplaceBookingRecord _applyDecision(
    MarketplaceBookingRecord record,
    BookingRequestDecision decision,
  ) {
    final now = DateTime.now();
    final status = switch (decision) {
      BookingRequestDecision.accept => BookingLifecycleStatus.accepted,
      BookingRequestDecision.decline => BookingLifecycleStatus.declined,
    };
    final note = switch (decision) {
      BookingRequestDecision.accept =>
        'Artist accepted the request and held the requested appointment slot.',
      BookingRequestDecision.decline =>
        'Artist declined the request based on current availability or fit.',
    };

    return record.copyWith(
      status: status,
      nextStepNote: switch (decision) {
        BookingRequestDecision.accept =>
          'Your request has been accepted. Final prep and timing details will follow.',
        BookingRequestDecision.decline =>
          'This request was declined. You can browse other artists or submit a new request.',
      },
      policySummary: switch (decision) {
        BookingRequestDecision.accept =>
          'Accepted bookings should use support guidance if event details change.',
        BookingRequestDecision.decline =>
          'Declined requests keep their original summary for reference, but no appointment was reserved.',
      },
      timeline: [
        ...record.timeline,
        BookingStatusTimelineEntry(status: status, occurredAt: now, note: note),
      ],
    );
  }

  MarketplaceBookingRecord _cancelRecord(MarketplaceBookingRecord record) {
    final now = DateTime.now();
    return record.copyWith(
      status: BookingLifecycleStatus.cancelled,
      isUpcoming: false,
      nextStepNote:
          'This request or appointment has been cancelled. You can browse artists again when you are ready to rebook.',
      policySummary:
          'Cancelled items remain visible for reference, but the original appointment slot is no longer reserved.',
      timeline: [
        ...record.timeline,
        BookingStatusTimelineEntry(
          status: BookingLifecycleStatus.cancelled,
          occurredAt: now,
          note:
              'Customer cancelled this request before final service completion.',
        ),
      ],
    );
  }
}

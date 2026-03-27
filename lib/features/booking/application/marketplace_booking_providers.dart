import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/analytics/analytics_service.dart';
import '../../../core/config/app_config.dart';
import '../../../core/crash_reporting/crash_reporting_service.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/network/network_providers.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../core/result/app_result.dart';
import '../../session/application/session_providers.dart';
import '../../session/domain/models/session_models.dart';
import '../data/local_marketplace_booking_storage.dart';
import '../data/remote/marketplace_booking_remote_data_source.dart';
import '../data/repositories/hybrid_marketplace_booking_repository.dart';
import '../data/repositories/local_marketplace_booking_repository.dart';
import '../domain/models/booking_models.dart';
import '../domain/models/marketplace_booking_models.dart';
import '../domain/repositories/marketplace_booking_repository.dart';
import 'booking_flow_controller.dart';

final localMarketplaceBookingStorageProvider =
    Provider<LocalMarketplaceBookingStorage>((ref) {
      return const LocalMarketplaceBookingStorage();
    });

final localMarketplaceBookingRepositoryProvider =
    Provider<LocalMarketplaceBookingRepository>((ref) {
      return LocalMarketplaceBookingRepository(
        ref.watch(localMarketplaceBookingStorageProvider),
      );
    });

final marketplaceBookingRepositoryProvider =
    Provider<MarketplaceBookingRepository>((ref) {
      return HybridMarketplaceBookingRepository(
        bookingStorage: ref.watch(localMarketplaceBookingStorageProvider),
        sessionStorage: ref.watch(localSessionStorageProvider),
        remoteDataSource: MarketplaceBookingRemoteDataSource(
          ref.watch(appApiClientProvider),
        ),
        config: ref.watch(appConfigProvider),
      );
    });

final marketplaceBookingMutationIdsProvider = StateProvider<Set<String>>((ref) {
  return <String>{};
});

final marketplaceBookingsControllerProvider =
    AsyncNotifierProvider<
      MarketplaceBookingsController,
      List<MarketplaceBookingRecord>
    >(MarketplaceBookingsController.new);

final marketplaceBookingByIdProvider =
    Provider.family<AsyncValue<MarketplaceBookingRecord?>, String>((
      ref,
      bookingId,
    ) {
      return ref.watch(marketplaceBookingsControllerProvider).whenData((
        records,
      ) {
        for (final record in records) {
          if (record.id == bookingId) {
            return record;
          }
        }
        return null;
      });
    });

final currentCustomerMarketplaceBookingsProvider =
    Provider<AsyncValue<List<MarketplaceBookingRecord>>>((ref) {
      final recordsAsync = ref.watch(marketplaceBookingsControllerProvider);
      final session = ref.watch(sessionControllerProvider);

      if (!session.isCustomer) {
        return const AsyncData(<MarketplaceBookingRecord>[]);
      }

      return recordsAsync.whenData(
        (records) => records.toList(growable: false),
      );
    });

final currentArtistMarketplaceBookingsProvider =
    Provider<AsyncValue<List<MarketplaceBookingRecord>>>((ref) {
      final session = ref.watch(sessionControllerProvider);
      if (!session.isArtist) {
        return const AsyncData(<MarketplaceBookingRecord>[]);
      }

      final recordsAsync = ref.watch(marketplaceBookingsControllerProvider);
      final artistId = session.userSummary?.artistProfileId;
      if (artistId == null) {
        return const AsyncData(<MarketplaceBookingRecord>[]);
      }
      return recordsAsync.whenData(
        (records) => records
            .where((record) => record.artistId == artistId)
            .toList(growable: false),
      );
    });

final pendingArtistRequestsProvider =
    Provider<AsyncValue<List<MarketplaceBookingRecord>>>((ref) {
      return ref
          .watch(currentArtistMarketplaceBookingsProvider)
          .whenData(
            (records) => records
                .where(
                  (record) =>
                      record.status ==
                      BookingLifecycleStatus.pendingArtistResponse,
                )
                .toList(growable: false),
          );
    });

final acceptedArtistBookingsProvider =
    Provider<AsyncValue<List<MarketplaceBookingRecord>>>((ref) {
      return ref
          .watch(currentArtistMarketplaceBookingsProvider)
          .whenData(
            (records) => records
                .where(
                  (record) =>
                      record.status == BookingLifecycleStatus.accepted &&
                      record.isUpcoming,
                )
                .toList(growable: false),
          );
    });

final pastArtistBookingsProvider =
    Provider<AsyncValue<List<MarketplaceBookingRecord>>>((ref) {
      return ref
          .watch(currentArtistMarketplaceBookingsProvider)
          .whenData(
            (records) => records
                .where(
                  (record) =>
                      record.status == BookingLifecycleStatus.completed ||
                      !record.isUpcoming,
                )
                .toList(growable: false),
          );
    });

class MarketplaceBookingsController
    extends AsyncNotifier<List<MarketplaceBookingRecord>> {
  @override
  Future<List<MarketplaceBookingRecord>> build() async {
    return _loadBookings();
  }

  Future<AppResult<BookingConfirmationDetails>>
  submitCurrentDraftAsRequest() async {
    final session = ref.read(sessionControllerProvider);
    if (!session.isCustomer) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message: 'A customer session is required to submit bookings.',
        ),
      );
    }

    final draft = ref.read(bookingFlowControllerProvider);
    final customer = session.userSummary;

    if (!draft.canReview ||
        customer == null ||
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
          message: 'Booking details are incomplete and cannot be submitted.',
        ),
      );
    }

    ref.read(marketplaceBookingMutationIdsProvider.notifier).state = {
      ...ref.read(marketplaceBookingMutationIdsProvider),
      '__submit__',
    };
    final result = await ref
        .read(marketplaceBookingRepositoryProvider)
        .submitBookingRequest(
          draft: draft,
          customer: customer,
          originatedAsGuest: false,
        );
    ref.read(marketplaceBookingMutationIdsProvider.notifier).state = {
      ...ref.read(marketplaceBookingMutationIdsProvider),
    }..remove('__submit__');

    if (result.dataOrNull == null) {
      _handleUnauthorized(result.failureOrNull);
      _reportFailure(result.failureOrNull, reason: 'booking_submission_failed');
      return AppFailureResult(result.failureOrNull!);
    }

    final record = result.dataOrNull!;
    final current = state.valueOrNull ?? const <MarketplaceBookingRecord>[];
    state = AsyncData(_upsert(current, record));
    await ref
        .read(analyticsServiceProvider)
        .track(
          AnalyticsEvent(
            name: AnalyticsEventName.bookingRequestSubmitted,
            parameters: {'bookingId': record.id},
          ),
        );
    await ref
        .read(notificationServiceProvider)
        .handleEvent(
          NotificationEvent(
            type: NotificationEventType.bookingRequestSubmitted,
            recipientMode: AppUserMode.artist,
            referenceId: record.id,
          ),
        );

    final details = BookingConfirmationDetails(
      bookingId: record.id,
      requestedAt: record.requestedAt,
    );
    ref
        .read(bookingFlowControllerProvider.notifier)
        .setConfirmationDetails(details);
    return AppSuccess(details);
  }

  Future<AppResult<void>> applyArtistDecision(
    String bookingId,
    BookingRequestDecision decision,
  ) async {
    _setMutationInFlight(bookingId, true);
    final result = await ref
        .read(marketplaceBookingRepositoryProvider)
        .applyArtistDecision(bookingId: bookingId, decision: decision);
    _setMutationInFlight(bookingId, false);

    if (result.dataOrNull == null) {
      _handleUnauthorized(result.failureOrNull);
      _reportFailure(
        result.failureOrNull,
        reason: 'artist_booking_decision_failed',
      );
      return AppFailureResult(result.failureOrNull!);
    }

    final current = state.valueOrNull ?? const <MarketplaceBookingRecord>[];
    final updated = result.dataOrNull!;
    state = AsyncData(_upsert(current, updated));
    await ref
        .read(analyticsServiceProvider)
        .track(
          AnalyticsEvent(
            name: decision == BookingRequestDecision.accept
                ? AnalyticsEventName.artistRequestAccepted
                : AnalyticsEventName.artistRequestDeclined,
            parameters: {'bookingId': bookingId},
          ),
        );
    await ref
        .read(notificationServiceProvider)
        .handleEvent(
          NotificationEvent(
            type: decision == BookingRequestDecision.accept
                ? NotificationEventType.bookingAccepted
                : NotificationEventType.bookingDeclined,
            recipientMode: AppUserMode.customer,
            referenceId: updated.id,
          ),
        );
    return const AppSuccess(null);
  }

  Future<AppResult<void>> cancelBookingRequest(String bookingId) async {
    _setMutationInFlight(bookingId, true);
    final result = await ref
        .read(marketplaceBookingRepositoryProvider)
        .cancelBookingRequest(bookingId);
    _setMutationInFlight(bookingId, false);

    if (result.dataOrNull == null) {
      _handleUnauthorized(result.failureOrNull);
      _reportFailure(result.failureOrNull, reason: 'booking_cancel_failed');
      return AppFailureResult(result.failureOrNull!);
    }

    final current = state.valueOrNull ?? const <MarketplaceBookingRecord>[];
    state = AsyncData(_upsert(current, result.dataOrNull!));
    return const AppSuccess(null);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadBookings);
  }

  Future<List<MarketplaceBookingRecord>> _loadBookings() async {
    final restored = await ref
        .read(marketplaceBookingRepositoryProvider)
        .loadBookings();
    final records = restored.dataOrNull;
    if (records != null) {
      return records;
    }
    _handleUnauthorized(restored.failureOrNull);
    throw _MarketplaceBookingLoadException(restored.failureOrNull!);
  }

  List<MarketplaceBookingRecord> _upsert(
    List<MarketplaceBookingRecord> records,
    MarketplaceBookingRecord updated,
  ) {
    final next = [...records];
    final index = next.indexWhere((item) => item.id == updated.id);
    if (index >= 0) {
      next[index] = updated;
      return next;
    }
    return [updated, ...next];
  }

  void _setMutationInFlight(String bookingId, bool isLoading) {
    final current = {...ref.read(marketplaceBookingMutationIdsProvider)};
    if (isLoading) {
      current.add(bookingId);
    } else {
      current.remove(bookingId);
      current.remove('__submit__');
    }
    ref.read(marketplaceBookingMutationIdsProvider.notifier).state = current;
  }

  void _handleUnauthorized(AppFailure? failure) {
    if (failure?.type == AppFailureType.unauthorized) {
      ref.read(sessionControllerProvider.notifier).signOut();
    }
  }

  void _reportFailure(AppFailure? failure, {required String reason}) {
    if (failure == null) {
      return;
    }
    unawaited(
      ref
          .read(crashReportingServiceProvider)
          .recordError(
            failure.message,
            context: CrashReportingContext(
              reason: reason,
              metadata: {'type': failure.type.name},
            ),
          ),
    );
  }
}

class _MarketplaceBookingLoadException implements Exception {
  const _MarketplaceBookingLoadException(this.failure);

  final AppFailure failure;

  @override
  String toString() => failure.message;
}

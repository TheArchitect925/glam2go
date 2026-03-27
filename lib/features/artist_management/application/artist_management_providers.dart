import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/analytics/analytics_service.dart';
import '../../../core/config/app_config.dart';
import '../../../core/crash_reporting/crash_reporting_service.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/network/network_providers.dart';
import '../../../core/result/app_result.dart';
import '../../booking/application/marketplace_booking_providers.dart'
    as marketplace;
import '../../booking/domain/models/marketplace_booking_models.dart';
import '../../session/application/session_providers.dart';
import '../data/local_artist_management_storage.dart';
import '../data/mock_artist_management_data.dart';
import '../data/remote/artist_management_remote_data_source.dart';
import '../data/repositories/hybrid_artist_management_repository.dart';
import '../domain/models/artist_management_models.dart';
import '../domain/repositories/artist_management_repository.dart';

final localArtistManagementStorageProvider =
    Provider<LocalArtistManagementStorage>((ref) {
      return const LocalArtistManagementStorage();
    });

final artistManagementRepositoryProvider = Provider<ArtistManagementRepository>(
  (ref) {
    return HybridArtistManagementRepository(
      storage: ref.watch(localArtistManagementStorageProvider),
      sessionStorage: ref.watch(localSessionStorageProvider),
      remoteDataSource: ArtistManagementRemoteDataSource(
        ref.watch(appApiClientProvider),
      ),
      config: ref.watch(appConfigProvider),
    );
  },
);

final artistManagementMutationKeysProvider = StateProvider<Set<String>>((ref) {
  return <String>{};
});

final artistManagementControllerProvider =
    NotifierProvider<ArtistManagementController, ArtistManagementState>(
      ArtistManagementController.new,
    );

final artistReadinessProvider = Provider<ArtistReadinessSummary>((ref) {
  final state = ref.watch(artistManagementControllerProvider);
  final completed = <bool>[
    state.profileDraft.displayName.trim().isNotEmpty,
    state.profileDraft.bio.trim().isNotEmpty &&
        state.profileDraft.specialties.any((item) => item.isSelected),
    state.travelPolicy.primaryServiceArea.trim().isNotEmpty &&
        state.travelPolicy.includedRadiusKm > 0,
    state.packages.any((item) => item.isActive),
    state.availabilityDays.any(
      (item) => item.isAvailable && item.windows.isNotEmpty,
    ),
  ];

  final missing = <String>[
    if (!completed[0]) 'profile',
    if (!completed[1]) 'specialties',
    if (!completed[2]) 'travel',
    if (!completed[3]) 'packages',
    if (!completed[4]) 'availability',
  ];
  final completedCount = completed.where((item) => item).length;

  return ArtistReadinessSummary(
    progress: completedCount / completed.length,
    completedCount: completedCount,
    totalCount: completed.length,
    missingItems: missing,
  );
});

final artistPendingBookingsProvider =
    Provider<AsyncValue<List<ArtistBookingSummary>>>((ref) {
      return ref
          .watch(marketplace.pendingArtistRequestsProvider)
          .whenData(
            (bookings) =>
                bookings.map(_toArtistBookingSummary).toList(growable: false),
          );
    });

final artistUpcomingBookingsProvider =
    Provider<AsyncValue<List<ArtistBookingSummary>>>((ref) {
      return ref
          .watch(marketplace.acceptedArtistBookingsProvider)
          .whenData(
            (bookings) =>
                bookings.map(_toArtistBookingSummary).toList(growable: false),
          );
    });

final artistPastBookingsProvider =
    Provider<AsyncValue<List<ArtistBookingSummary>>>((ref) {
      return ref
          .watch(marketplace.pastArtistBookingsProvider)
          .whenData(
            (bookings) =>
                bookings.map(_toArtistBookingSummary).toList(growable: false),
          );
    });

final artistSelectedSpecialtiesProvider = Provider<List<String>>((ref) {
  final specialties = ref.watch(
    artistManagementControllerProvider.select(
      (state) => state.profileDraft.specialties,
    ),
  );
  return specialties
      .where((item) => item.isSelected)
      .map((item) => item.label)
      .toList(growable: false);
});

class ArtistManagementController extends Notifier<ArtistManagementState> {
  @override
  ArtistManagementState build() {
    Future.microtask(_restore);
    return mockArtistManagementState;
  }

  void setOnboardingStep(ArtistOnboardingStep step) {
    state = state.copyWith(onboardingStep: step);
    _persist();
  }

  Future<AppResult<void>> updateProfile({
    required String displayName,
    required String bio,
    required String experienceSummary,
    required String instagramHandle,
    required String tiktokHandle,
  }) async {
    final nextDraft = state.profileDraft.copyWith(
      displayName: displayName.trim(),
      bio: bio.trim(),
      experienceSummary: experienceSummary.trim(),
      instagramHandle: instagramHandle.trim(),
      tiktokHandle: tiktokHandle.trim(),
    );
    _setMutationInFlight('profile', true);
    final result = await ref
        .read(artistManagementRepositoryProvider)
        .updateProfileDraft(nextDraft);
    _setMutationInFlight('profile', false);
    if (result.dataOrNull == null) {
      _handleMutationFailure(
        result.failureOrNull,
        reason: 'artist_profile_save_failed',
      );
      return AppFailureResult(result.failureOrNull!);
    }
    state = result.dataOrNull!;
    await ref
        .read(analyticsServiceProvider)
        .track(
          const AnalyticsEvent(name: AnalyticsEventName.artistProfileSaved),
        );
    return const AppSuccess(null);
  }

  Future<void> toggleSpecialty(String label) async {
    final updated = state.profileDraft.specialties
        .map(
          (item) => item.label == label
              ? item.copyWith(isSelected: !item.isSelected)
              : item,
        )
        .toList(growable: false);
    state = state.copyWith(
      profileDraft: state.profileDraft.copyWith(specialties: updated),
    );
    await ref.read(artistManagementRepositoryProvider).saveState(state);
  }

  Future<AppResult<ArtistPortfolioItemDraft>> savePortfolioItem({
    String? itemId,
    required String title,
    required String category,
    required String caption,
  }) async {
    final trimmedTitle = title.trim();
    final trimmedCategory = category.trim();
    final trimmedCaption = caption.trim();
    if (trimmedTitle.isEmpty ||
        trimmedCategory.isEmpty ||
        trimmedCaption.isEmpty) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.validation,
          message: 'Portfolio items need a title, category, and caption.',
        ),
      );
    }

    ArtistPortfolioItemDraft? existing;
    for (final item in state.profileDraft.portfolioItems) {
      if (item.id == itemId) {
        existing = item;
        break;
      }
    }

    final nextCount = state.profileDraft.portfolioItems.length + 1;
    final item =
        existing?.copyWith(
          title: trimmedTitle,
          category: trimmedCategory,
          caption: trimmedCaption,
        ) ??
        ArtistPortfolioItemDraft(
          id: itemId ?? 'portfolio-$nextCount',
          title: trimmedTitle,
          category: trimmedCategory,
          caption: trimmedCaption,
          mediaReference: 'portfolio-placeholder-${itemId ?? nextCount}',
          startColorValue: 0xFFF3DFD7,
          endColorValue: 0xFFB8818E,
        );

    _setMutationInFlight('portfolio:${item.id}', true);
    final result = await ref
        .read(artistManagementRepositoryProvider)
        .savePortfolioItem(item);
    _setMutationInFlight('portfolio:${item.id}', false);
    if (result.dataOrNull == null) {
      _handleMutationFailure(
        result.failureOrNull,
        reason: 'artist_portfolio_save_failed',
      );
      return AppFailureResult(result.failureOrNull!);
    }
    state = result.dataOrNull!;
    await ref
        .read(analyticsServiceProvider)
        .track(
          AnalyticsEvent(
            name: AnalyticsEventName.artistPortfolioSaved,
            parameters: {'itemId': item.id, 'isNew': existing == null},
          ),
        );
    return AppSuccess(item);
  }

  Future<AppResult<void>> removePortfolioItem(String id) async {
    _setMutationInFlight('portfolio:$id', true);
    final result = await ref
        .read(artistManagementRepositoryProvider)
        .removePortfolioItem(id);
    _setMutationInFlight('portfolio:$id', false);
    if (result.dataOrNull == null) {
      _handleMutationFailure(
        result.failureOrNull,
        reason: 'artist_portfolio_remove_failed',
      );
      return AppFailureResult(result.failureOrNull!);
    }
    state = result.dataOrNull!;
    await ref
        .read(analyticsServiceProvider)
        .track(
          AnalyticsEvent(
            name: AnalyticsEventName.artistPortfolioRemoved,
            parameters: {'itemId': id},
          ),
        );
    return const AppSuccess(null);
  }

  Future<AppResult<void>> togglePackageActive(String id) async {
    ArtistServicePackageDraft? target;
    for (final item in state.packages) {
      if (item.id == id) {
        target = item;
        break;
      }
    }
    if (target == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.validation,
          message: 'Package could not be found.',
        ),
      );
    }
    return savePackage(target.copyWith(isActive: !target.isActive));
  }

  Future<AppResult<void>> savePackage(ArtistServicePackageDraft package) async {
    _setMutationInFlight(package.id, true);
    final result = await ref
        .read(artistManagementRepositoryProvider)
        .savePackage(package);
    _setMutationInFlight(package.id, false);
    if (result.dataOrNull == null) {
      _handleMutationFailure(
        result.failureOrNull,
        reason: 'artist_package_save_failed',
      );
      return AppFailureResult(result.failureOrNull!);
    }
    state = result.dataOrNull!;
    await ref
        .read(analyticsServiceProvider)
        .track(
          AnalyticsEvent(
            name: AnalyticsEventName.artistPackageSaved,
            parameters: {'packageId': package.id},
          ),
        );
    return const AppSuccess(null);
  }

  Future<AppResult<void>> toggleAvailability(String dayKey) async {
    final updated = state.availabilityDays
        .map(
          (day) => day.dayKey == dayKey
              ? day.copyWith(isAvailable: !day.isAvailable)
              : day,
        )
        .toList(growable: false);
    return _saveAvailability(updated, mutationKey: 'availability:$dayKey');
  }

  Future<AppResult<void>> saveAvailabilityWindow({
    required String dayKey,
    required ArtistTimeWindow window,
  }) async {
    final updated = state.availabilityDays
        .map((day) {
          if (day.dayKey != dayKey) {
            return day;
          }
          final windows = [...day.windows];
          final index = windows.indexWhere((item) => item.id == window.id);
          if (index >= 0) {
            windows[index] = window;
          } else {
            windows.add(window);
          }
          return day.copyWith(isAvailable: true, windows: windows);
        })
        .toList(growable: false);
    return _saveAvailability(updated, mutationKey: 'availability:$dayKey');
  }

  Future<AppResult<void>> removeAvailabilityWindow({
    required String dayKey,
    required String windowId,
  }) async {
    final updated = state.availabilityDays
        .map((day) {
          if (day.dayKey != dayKey) {
            return day;
          }
          final windows = day.windows
              .where((item) => item.id != windowId)
              .toList(growable: false);
          return day.copyWith(
            windows: windows,
            isAvailable: windows.isNotEmpty,
          );
        })
        .toList(growable: false);
    return _saveAvailability(updated, mutationKey: 'availability:$dayKey');
  }

  Future<AppResult<void>> updateTravelPolicy({
    required String primaryServiceArea,
    required int includedRadiusKm,
    required int extraTravelFee,
    required int maxTravelDistanceKm,
    required String travelNotes,
  }) async {
    final policy = state.travelPolicy.copyWith(
      primaryServiceArea: primaryServiceArea.trim(),
      includedRadiusKm: includedRadiusKm,
      extraTravelFee: extraTravelFee,
      maxTravelDistanceKm: maxTravelDistanceKm,
      travelNotes: travelNotes.trim(),
    );
    _setMutationInFlight('travel', true);
    final result = await ref
        .read(artistManagementRepositoryProvider)
        .updateTravelPolicy(policy);
    _setMutationInFlight('travel', false);
    if (result.dataOrNull == null) {
      _handleMutationFailure(
        result.failureOrNull,
        reason: 'artist_travel_policy_save_failed',
      );
      return AppFailureResult(result.failureOrNull!);
    }
    state = result.dataOrNull!;
    await ref
        .read(analyticsServiceProvider)
        .track(
          const AnalyticsEvent(
            name: AnalyticsEventName.artistTravelPolicySaved,
          ),
        );
    return const AppSuccess(null);
  }

  Future<AppResult<void>> _saveAvailability(
    List<ArtistAvailabilityDay> availabilityDays, {
    required String mutationKey,
  }) async {
    _setMutationInFlight(mutationKey, true);
    final result = await ref
        .read(artistManagementRepositoryProvider)
        .saveAvailabilityDays(availabilityDays);
    _setMutationInFlight(mutationKey, false);
    if (result.dataOrNull == null) {
      _handleMutationFailure(
        result.failureOrNull,
        reason: 'artist_availability_save_failed',
      );
      return AppFailureResult(result.failureOrNull!);
    }
    state = result.dataOrNull!;
    await ref
        .read(analyticsServiceProvider)
        .track(
          const AnalyticsEvent(
            name: AnalyticsEventName.artistAvailabilitySaved,
          ),
        );
    return const AppSuccess(null);
  }

  void setNotificationsEnabled(bool value) {
    state = state.copyWith(notificationsEnabled: value);
    _persist();
  }

  void setBusinessNotificationsEnabled(bool value) {
    state = state.copyWith(businessNotificationsEnabled: value);
    _persist();
  }

  Future<void> _restore() async {
    final restored = await ref
        .read(artistManagementRepositoryProvider)
        .loadState();
    if (restored.dataOrNull != null) {
      state = restored.dataOrNull!;
      return;
    }
    _handleUnauthorized(restored.failureOrNull);
  }

  void _persist() {
    unawaited(ref.read(artistManagementRepositoryProvider).saveState(state));
  }

  void _setMutationInFlight(String key, bool isLoading) {
    final current = {...ref.read(artistManagementMutationKeysProvider)};
    if (isLoading) {
      current.add(key);
    } else {
      current.remove(key);
    }
    ref.read(artistManagementMutationKeysProvider.notifier).state = current;
  }

  void _handleUnauthorized(AppFailure? failure) {
    if (failure?.type == AppFailureType.unauthorized) {
      ref.read(sessionControllerProvider.notifier).signOut();
    }
  }

  void _handleMutationFailure(AppFailure? failure, {required String reason}) {
    _handleUnauthorized(failure);
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

ArtistBookingSummary _toArtistBookingSummary(MarketplaceBookingRecord record) {
  return ArtistBookingSummary(
    id: record.id,
    customerName: record.customerName,
    packageTitle: record.packageTitle,
    scheduledAt: record.scheduledAt,
    timeLabel: record.timeLabel,
    areaLabel: record.location.cityArea,
    status: record.status,
    eventLabel: record.eventDetails.occasion,
    travelIncluded: record.travelFeeSummary.isIncluded,
    travelFee: record.travelFeeSummary.fee,
    isUpcoming: record.isUpcoming,
  );
}

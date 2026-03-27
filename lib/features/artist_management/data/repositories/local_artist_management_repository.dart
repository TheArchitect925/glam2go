import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/app_result.dart';
import '../../domain/models/artist_management_models.dart';
import '../../domain/repositories/artist_management_repository.dart';
import '../dtos/artist_management_state_dto.dart';
import '../local_artist_management_storage.dart';
import '../mock_artist_management_data.dart';

class LocalArtistManagementRepository implements ArtistManagementRepository {
  const LocalArtistManagementRepository(this._storage);

  final LocalArtistManagementStorage _storage;

  @override
  Future<AppResult<ArtistManagementState>> loadState() async {
    try {
      final map = await _storage.loadState();
      if (map == null) {
        return const AppSuccess(mockArtistManagementState);
      }

      return AppSuccess(ArtistManagementStateDto.fromMap(map).toDomain());
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to restore artist management state.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<ArtistManagementState>> saveState(
    ArtistManagementState state,
  ) async {
    try {
      await _storage.saveState(
        ArtistManagementStateDto.fromDomain(state).toMap(),
      );
      return AppSuccess(state);
    } catch (error) {
      return AppFailureResult(
        AppFailure(
          type: AppFailureType.storage,
          message: 'Unable to persist artist management state.',
          cause: error,
        ),
      );
    }
  }

  @override
  Future<AppResult<ArtistManagementState>> updateProfileDraft(
    ArtistProfileDraft draft,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    return saveState(state.copyWith(profileDraft: draft));
  }

  @override
  Future<AppResult<ArtistManagementState>> savePackage(
    ArtistServicePackageDraft package,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }

    final packages = [...state.packages];
    final index = packages.indexWhere((item) => item.id == package.id);
    if (index >= 0) {
      packages[index] = package;
    } else {
      packages.add(package);
    }
    return saveState(state.copyWith(packages: packages));
  }

  @override
  Future<AppResult<ArtistManagementState>> savePortfolioItem(
    ArtistPortfolioItemDraft item,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }

    final items = [...state.profileDraft.portfolioItems];
    final index = items.indexWhere((entry) => entry.id == item.id);
    if (index >= 0) {
      items[index] = item;
    } else {
      items.insert(0, item);
    }
    return saveState(
      state.copyWith(
        profileDraft: state.profileDraft.copyWith(portfolioItems: items),
      ),
    );
  }

  @override
  Future<AppResult<ArtistManagementState>> removePortfolioItem(
    String itemId,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }

    final items = state.profileDraft.portfolioItems
        .where((entry) => entry.id != itemId)
        .toList(growable: false);
    return saveState(
      state.copyWith(
        profileDraft: state.profileDraft.copyWith(portfolioItems: items),
      ),
    );
  }

  @override
  Future<AppResult<ArtistManagementState>> saveAvailabilityDays(
    List<ArtistAvailabilityDay> availabilityDays,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    return saveState(state.copyWith(availabilityDays: availabilityDays));
  }

  @override
  Future<AppResult<ArtistManagementState>> updateTravelPolicy(
    ArtistTravelPolicy travelPolicy,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    return saveState(state.copyWith(travelPolicy: travelPolicy));
  }

  @override
  Future<AppResult<ArtistManagementState>> submitApplication() async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    return saveState(
      state.copyWith(
        onboardingStatus: ArtistOnboardingStatus.applicationSubmitted,
      ),
    );
  }

  @override
  Future<AppResult<ArtistManagementState>> advanceOnboardingStatus(
    ArtistOnboardingStatus nextStatus,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    return saveState(state.copyWith(onboardingStatus: nextStatus));
  }

  @override
  Future<AppResult<ArtistManagementState>> updateVerification(
    ArtistVerification verification,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    return saveState(
      state.copyWith(
        verification: verification,
        isVerified: verification.isIdentityVerified,
      ),
    );
  }

  @override
  Future<AppResult<ArtistManagementState>> saveInternalReview(
    ArtistInternalReview review,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    final reviews = [review, ...state.internalReviews.where((r) => r.id != review.id)];
    return saveState(state.copyWith(internalReviews: reviews));
  }

  @override
  Future<AppResult<ArtistManagementState>> saveRiskEvent(
    ArtistRiskEvent event,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    final events = [event, ...state.riskEvents.where((r) => r.id != event.id)];
    return saveState(state.copyWith(riskEvents: events));
  }

  @override
  Future<AppResult<ArtistManagementState>> updateOperationalMetrics(
    ArtistOperationalMetrics metrics,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    return saveState(state.copyWith(operationalMetrics: metrics));
  }

  @override
  Future<AppResult<ArtistManagementState>> updateSoftLaunchConfig(
    ArtistSoftLaunchConfig config,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    return saveState(state.copyWith(softLaunchConfig: config));
  }

  @override
  Future<AppResult<ArtistManagementState>> updateApprovalScope(
    ArtistApprovalScope scope,
  ) async {
    final current = await loadState();
    final state = current.dataOrNull;
    if (state == null) {
      return AppFailureResult(current.failureOrNull!);
    }
    return saveState(state.copyWith(approvalScope: scope));
  }
}

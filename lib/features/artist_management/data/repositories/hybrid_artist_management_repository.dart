import '../../../../core/config/app_config.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/app_result.dart';
import '../../../session/data/local_session_storage.dart';
import '../../domain/models/artist_management_models.dart';
import '../../domain/repositories/artist_management_repository.dart';
import '../dtos/artist_management_state_dto.dart';
import '../local_artist_management_storage.dart';
import '../remote/artist_management_remote_data_source.dart';
import 'local_artist_management_repository.dart';

class HybridArtistManagementRepository implements ArtistManagementRepository {
  const HybridArtistManagementRepository({
    required LocalArtistManagementStorage storage,
    required LocalSessionStorage sessionStorage,
    required ArtistManagementRemoteDataSource remoteDataSource,
    required AppConfig config,
  }) : _storage = storage,
       _sessionStorage = sessionStorage,
       _remoteDataSource = remoteDataSource,
       _config = config;

  final LocalArtistManagementStorage _storage;
  final LocalSessionStorage _sessionStorage;
  final ArtistManagementRemoteDataSource _remoteDataSource;
  final AppConfig _config;

  LocalArtistManagementRepository get _localRepository =>
      LocalArtistManagementRepository(_storage);

  @override
  Future<AppResult<ArtistManagementState>> loadState() async {
    if (!_config.enableRemoteArtistManagement) {
      return _localRepository.loadState();
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return _localRepository.loadState();
    }

    final remote = await _remoteDataSource.loadState(authToken: authToken);
    if (remote.dataOrNull != null) {
      final state = remote.dataOrNull!.toDomain();
      await _localRepository.saveState(state);
      return AppSuccess(state);
    }

    final local = await _localRepository.loadState();
    if (local.dataOrNull != null) {
      return local;
    }
    return AppFailureResult(remote.failureOrNull!);
  }

  @override
  Future<AppResult<ArtistManagementState>> saveState(
    ArtistManagementState state,
  ) {
    return _localRepository.saveState(state);
  }

  @override
  Future<AppResult<ArtistManagementState>> updateProfileDraft(
    ArtistProfileDraft draft,
  ) async {
    if (!_config.enableRemoteArtistManagement) {
      return _localRepository.updateProfileDraft(draft);
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message: 'A signed-in artist session is required to update profile.',
        ),
      );
    }

    final remote = await _remoteDataSource.updateProfile(
      authToken: authToken,
      draft: ArtistProfileDraftDto.fromDomain(draft),
    );
    if (remote.failureOrNull != null) {
      return AppFailureResult(remote.failureOrNull!);
    }

    return _resolveAndPersistState(
      merge: (state) =>
          state.copyWith(profileDraft: remote.dataOrNull?.toDomain() ?? draft),
    );
  }

  @override
  Future<AppResult<ArtistManagementState>> savePackage(
    ArtistServicePackageDraft package,
  ) async {
    if (!_config.enableRemoteArtistManagement) {
      return _localRepository.savePackage(package);
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message: 'A signed-in artist session is required to update packages.',
        ),
      );
    }

    final current = await loadState();
    final currentState = current.dataOrNull;
    if (currentState == null) {
      return AppFailureResult(current.failureOrNull!);
    }

    final exists = currentState.packages.any((item) => item.id == package.id);
    final remote = await _remoteDataSource.savePackage(
      authToken: authToken,
      package: ArtistServicePackageDraftDto.fromDomain(package),
      isCreate: !exists,
    );
    if (remote.failureOrNull != null) {
      return AppFailureResult(remote.failureOrNull!);
    }

    return _resolveAndPersistState(
      merge: (state) {
        final updatedPackage = remote.dataOrNull?.toDomain() ?? package;
        final packages = [...state.packages];
        final index = packages.indexWhere((item) => item.id == package.id);
        if (index >= 0) {
          packages[index] = updatedPackage;
        } else {
          packages.add(updatedPackage);
        }
        return state.copyWith(packages: packages);
      },
    );
  }

  @override
  Future<AppResult<ArtistManagementState>> savePortfolioItem(
    ArtistPortfolioItemDraft item,
  ) async {
    if (!_config.enableRemoteArtistManagement) {
      return _localRepository.savePortfolioItem(item);
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message:
              'A signed-in artist session is required to update portfolio items.',
        ),
      );
    }

    final current = await loadState();
    final currentState = current.dataOrNull;
    if (currentState == null) {
      return AppFailureResult(current.failureOrNull!);
    }

    final exists = currentState.profileDraft.portfolioItems.any(
      (entry) => entry.id == item.id,
    );
    final remote = await _remoteDataSource.savePortfolioItem(
      authToken: authToken,
      item: ArtistPortfolioItemDraftDto.fromDomain(item),
      isCreate: !exists,
    );
    if (remote.failureOrNull != null) {
      return AppFailureResult(remote.failureOrNull!);
    }

    return _resolveAndPersistState(
      merge: (state) {
        final saved = remote.dataOrNull?.toDomain() ?? item;
        final items = [...state.profileDraft.portfolioItems];
        final index = items.indexWhere((entry) => entry.id == item.id);
        if (index >= 0) {
          items[index] = saved;
        } else {
          items.insert(0, saved);
        }
        return state.copyWith(
          profileDraft: state.profileDraft.copyWith(portfolioItems: items),
        );
      },
    );
  }

  @override
  Future<AppResult<ArtistManagementState>> removePortfolioItem(
    String itemId,
  ) async {
    if (!_config.enableRemoteArtistManagement) {
      return _localRepository.removePortfolioItem(itemId);
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message:
              'A signed-in artist session is required to update portfolio items.',
        ),
      );
    }

    final remote = await _remoteDataSource.removePortfolioItem(
      authToken: authToken,
      itemId: itemId,
    );
    if (remote.failureOrNull != null) {
      return AppFailureResult(remote.failureOrNull!);
    }

    return _resolveAndPersistState(
      merge: (state) => state.copyWith(
        profileDraft: state.profileDraft.copyWith(
          portfolioItems: state.profileDraft.portfolioItems
              .where((entry) => entry.id != itemId)
              .toList(growable: false),
        ),
      ),
    );
  }

  @override
  Future<AppResult<ArtistManagementState>> saveAvailabilityDays(
    List<ArtistAvailabilityDay> availabilityDays,
  ) async {
    if (!_config.enableRemoteArtistManagement) {
      return _localRepository.saveAvailabilityDays(availabilityDays);
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message:
              'A signed-in artist session is required to update availability.',
        ),
      );
    }

    final remote = await _remoteDataSource.saveAvailabilityDays(
      authToken: authToken,
      availabilityDays: availabilityDays
          .map(ArtistAvailabilityDayDto.fromDomain)
          .toList(growable: false),
    );
    if (remote.failureOrNull != null) {
      return AppFailureResult(remote.failureOrNull!);
    }

    return _resolveAndPersistState(
      merge: (state) => state.copyWith(
        availabilityDays:
            remote.dataOrNull
                ?.map((item) => item.toDomain())
                .toList(growable: false) ??
            availabilityDays,
      ),
    );
  }

  @override
  Future<AppResult<ArtistManagementState>> updateTravelPolicy(
    ArtistTravelPolicy travelPolicy,
  ) async {
    if (!_config.enableRemoteArtistManagement) {
      return _localRepository.updateTravelPolicy(travelPolicy);
    }

    final authToken = await _loadAuthToken();
    if (authToken == null) {
      return const AppFailureResult(
        AppFailure(
          type: AppFailureType.unauthorized,
          message:
              'A signed-in artist session is required to update travel policy.',
        ),
      );
    }

    final remote = await _remoteDataSource.updateTravelPolicy(
      authToken: authToken,
      travelPolicy: ArtistTravelPolicyDto.fromDomain(travelPolicy),
    );
    if (remote.failureOrNull != null) {
      return AppFailureResult(remote.failureOrNull!);
    }

    return _resolveAndPersistState(
      merge: (state) => state.copyWith(
        travelPolicy: remote.dataOrNull?.toDomain() ?? travelPolicy,
      ),
    );
  }

  @override
  Future<AppResult<ArtistManagementState>> submitApplication() {
    return _localRepository.submitApplication();
  }

  @override
  Future<AppResult<ArtistManagementState>> advanceOnboardingStatus(
    ArtistOnboardingStatus nextStatus,
  ) {
    return _localRepository.advanceOnboardingStatus(nextStatus);
  }

  @override
  Future<AppResult<ArtistManagementState>> updateVerification(
    ArtistVerification verification,
  ) {
    return _localRepository.updateVerification(verification);
  }

  @override
  Future<AppResult<ArtistManagementState>> saveInternalReview(
    ArtistInternalReview review,
  ) {
    return _localRepository.saveInternalReview(review);
  }

  @override
  Future<AppResult<ArtistManagementState>> saveRiskEvent(
    ArtistRiskEvent event,
  ) {
    return _localRepository.saveRiskEvent(event);
  }

  @override
  Future<AppResult<ArtistManagementState>> updateOperationalMetrics(
    ArtistOperationalMetrics metrics,
  ) {
    return _localRepository.updateOperationalMetrics(metrics);
  }

  @override
  Future<AppResult<ArtistManagementState>> updateSoftLaunchConfig(
    ArtistSoftLaunchConfig config,
  ) {
    return _localRepository.updateSoftLaunchConfig(config);
  }

  @override
  Future<AppResult<ArtistManagementState>> updateApprovalScope(
    ArtistApprovalScope scope,
  ) {
    return _localRepository.updateApprovalScope(scope);
  }

  Future<String?> _loadAuthToken() async {
    final session = await _sessionStorage.load();
    return session?.authToken;
  }

  Future<AppResult<ArtistManagementState>> _resolveAndPersistState({
    required ArtistManagementState Function(ArtistManagementState state) merge,
  }) async {
    final local = await _localRepository.loadState();
    final localState = local.dataOrNull;
    if (localState == null) {
      return AppFailureResult(local.failureOrNull!);
    }

    final merged = merge(localState);
    await _localRepository.saveState(merged);

    await loadState();
    return AppSuccess(merged);
  }
}

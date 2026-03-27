import '../../../../core/result/app_result.dart';
import '../models/artist_management_models.dart';

abstract class ArtistManagementRepository {
  Future<AppResult<ArtistManagementState>> loadState();
  Future<AppResult<ArtistManagementState>> saveState(
    ArtistManagementState state,
  );
  Future<AppResult<ArtistManagementState>> updateProfileDraft(
    ArtistProfileDraft draft,
  );
  Future<AppResult<ArtistManagementState>> savePackage(
    ArtistServicePackageDraft package,
  );
  Future<AppResult<ArtistManagementState>> savePortfolioItem(
    ArtistPortfolioItemDraft item,
  );
  Future<AppResult<ArtistManagementState>> removePortfolioItem(String itemId);
  Future<AppResult<ArtistManagementState>> saveAvailabilityDays(
    List<ArtistAvailabilityDay> availabilityDays,
  );
  Future<AppResult<ArtistManagementState>> updateTravelPolicy(
    ArtistTravelPolicy travelPolicy,
  );
  Future<AppResult<ArtistManagementState>> submitApplication();
  Future<AppResult<ArtistManagementState>> advanceOnboardingStatus(
    ArtistOnboardingStatus nextStatus,
  );
  Future<AppResult<ArtistManagementState>> updateVerification(
    ArtistVerification verification,
  );
  Future<AppResult<ArtistManagementState>> saveInternalReview(
    ArtistInternalReview review,
  );
  Future<AppResult<ArtistManagementState>> saveRiskEvent(ArtistRiskEvent event);
  Future<AppResult<ArtistManagementState>> updateOperationalMetrics(
    ArtistOperationalMetrics metrics,
  );
  Future<AppResult<ArtistManagementState>> updateSoftLaunchConfig(
    ArtistSoftLaunchConfig config,
  );
  Future<AppResult<ArtistManagementState>> updateApprovalScope(
    ArtistApprovalScope scope,
  );
}

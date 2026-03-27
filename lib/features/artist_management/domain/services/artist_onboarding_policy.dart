import '../models/artist_management_models.dart';

class ArtistOnboardingPolicy {
  const ArtistOnboardingPolicy({
    this.minimumPortfolioImages = 2,
    this.softLaunchCompletedJobsThreshold = 3,
    this.activeQualityScoreThreshold = 72,
    this.customQuoteCompletedJobsThreshold = 8,
    this.customQuoteQualityScoreThreshold = 82,
  });

  final int minimumPortfolioImages;
  final int softLaunchCompletedJobsThreshold;
  final int activeQualityScoreThreshold;
  final int customQuoteCompletedJobsThreshold;
  final int customQuoteQualityScoreThreshold;

  ArtistOnboardingChecklistProgress buildChecklist(
    ArtistManagementState state,
  ) {
    final profile = state.profileDraft;
    final serviceSetupStarted = state.packages.isNotEmpty;
    final availabilityReady = state.availabilityDays.any(
      (item) => item.isAvailable && item.windows.isNotEmpty,
    );

    return ArtistOnboardingChecklistProgress(
      minimumPortfolioImages: minimumPortfolioImages,
      items: [
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.legalName,
          isComplete: profile.legalName.trim().isNotEmpty,
          detail: profile.legalName,
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.displayName,
          isComplete: profile.displayName.trim().isNotEmpty,
          detail: profile.displayName,
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.email,
          isComplete: profile.email.trim().contains('@'),
          detail: profile.email,
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.phone,
          isComplete: profile.phone.trim().length >= 10,
          detail: profile.phone,
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.city,
          isComplete: profile.city.trim().isNotEmpty,
          detail: profile.city,
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.provinceOrState,
          isComplete: profile.provinceOrState.trim().isNotEmpty,
          detail: profile.provinceOrState,
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.bio,
          isComplete: profile.bio.trim().isNotEmpty,
          detail: profile.bio,
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.profileImage,
          isComplete: profile.profileImageUrl.trim().isNotEmpty,
          detail: profile.profileImageUrl,
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.specialties,
          isComplete: profile.categories.isNotEmpty,
          detail: profile.categories.join(', '),
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.yearsOfExperience,
          isComplete: profile.yearsOfExperience > 0,
          detail: '${profile.yearsOfExperience}',
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.travelRadius,
          isComplete:
              state.travelPolicy.includedRadiusKm > 0 &&
              state.travelPolicy.maxTravelDistanceKm >=
                  state.travelPolicy.includedRadiusKm,
          detail:
              '${state.travelPolicy.includedRadiusKm}/${state.travelPolicy.maxTravelDistanceKm}',
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.serviceAreaSummary,
          isComplete:
              profile.serviceAreaSummary.trim().isNotEmpty ||
              state.travelPolicy.primaryServiceArea.trim().isNotEmpty,
          detail: profile.serviceAreaSummary,
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.portfolioImages,
          isComplete:
              profile.portfolioItems.length >= minimumPortfolioImages &&
              profile.portfolioImageUrls.length >= minimumPortfolioImages,
          detail: '${profile.portfolioItems.length}',
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.packages,
          isComplete:
              serviceSetupStarted &&
              state.packages.any((item) => item.isActive && item.price > 0),
          detail: '${state.packages.length}',
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.availability,
          isComplete: availabilityReady,
          detail: '${state.availabilityDays.where((item) => item.isAvailable).length}',
        ),
        ArtistOnboardingChecklistItem(
          requirement: ArtistChecklistRequirement.verification,
          isComplete: state.verification.isIdentityVerified,
          detail: state.verification.status.name,
        ),
      ],
    );
  }

  ArtistSubmissionReadiness submissionReadiness(ArtistManagementState state) {
    final checklist = buildChecklist(state);
    final submissionRequired = checklist.items.where(
      (item) => item.requirement != ArtistChecklistRequirement.verification,
    );

    return ArtistSubmissionReadiness(
      canSubmit: submissionRequired.every((item) => item.isComplete),
      checklist: checklist,
    );
  }

  ArtistReviewScores normalizeScores({
    required int technicalSkill,
    required int styleRange,
    required int portfolioQuality,
    required int professionalPresentation,
  }) {
    final normalizedTechnical = technicalSkill.clamp(0, 5);
    final normalizedStyle = styleRange.clamp(0, 5);
    final normalizedPortfolio = portfolioQuality.clamp(0, 5);
    final normalizedPresentation = professionalPresentation.clamp(0, 5);
    final total = normalizedTechnical +
        normalizedStyle +
        normalizedPortfolio +
        normalizedPresentation;

    return ArtistReviewScores(
      technicalSkill: normalizedTechnical,
      styleRange: normalizedStyle,
      portfolioQuality: normalizedPortfolio,
      professionalPresentation: normalizedPresentation,
      totalScore: total,
    );
  }

  InternalReviewDecision reviewDecisionFor(ArtistReviewScores scores) {
    if (scores.totalScore >= 16) {
      return InternalReviewDecision.approved;
    }
    if (scores.totalScore >= 12) {
      return InternalReviewDecision.revisionRequired;
    }
    return InternalReviewDecision.rejected;
  }

  int computeQualityScore(ArtistOperationalMetrics metrics) {
    final ratingComponent = ((metrics.ratingAverage / 5) * 30).round();
    final completionComponent = (metrics.completionRate * 25).round();
    final responseComponent = (metrics.quoteResponseRate * 15).round();
    final responseSpeedComponent =
        (metrics.quoteResponseSpeedScore.clamp(0, 100) * 0.10).round();
    final cancellationPenalty = (metrics.cancellationRate * 12).round();
    final noShowPenalty = (metrics.noShowRate * 18).round();
    final complaintPenalty = (metrics.complaintRate * 15).round();
    final latenessPenalty = (metrics.latenessRate * 8).round();
    final score = ratingComponent +
        completionComponent +
        responseComponent +
        responseSpeedComponent -
        cancellationPenalty -
        noShowPenalty -
        complaintPenalty -
        latenessPenalty;

    return score.clamp(0, 100);
  }

  CustomQuoteEligibilityStatus determineCustomQuoteEligibility(
    ArtistManagementState state,
  ) {
    if (state.onboardingStatus == ArtistOnboardingStatus.suspended ||
        state.onboardingStatus == ArtistOnboardingStatus.rejected ||
        state.onboardingStatus == ArtistOnboardingStatus.deactivated) {
      return CustomQuoteEligibilityStatus.restricted;
    }

    if (state.approvalScope.customQuoteEligibleCategories.isNotEmpty) {
      return CustomQuoteEligibilityStatus.approved;
    }

    final metrics = state.operationalMetrics;
    if (metrics.completedJobsCount >= customQuoteCompletedJobsThreshold &&
        metrics.qualityScore >= customQuoteQualityScoreThreshold &&
        metrics.complaintRate <= 0.02 &&
        metrics.cancellationRate <= 0.08) {
      return CustomQuoteEligibilityStatus.softEligible;
    }

    if (state.onboardingStatus.index >=
        ArtistOnboardingStatus.serviceSetupComplete.index) {
      return CustomQuoteEligibilityStatus.pendingReview;
    }

    return CustomQuoteEligibilityStatus.ineligible;
  }

  bool canSoftLaunch(ArtistManagementState state) {
    final checklist = buildChecklist(state);
    final required = checklist.items.where(
      (item) =>
          item.requirement != ArtistChecklistRequirement.verification &&
          item.requirement != ArtistChecklistRequirement.portfolioImages,
    );
    final hasPortfolio = state.profileDraft.portfolioItems.length >=
        minimumPortfolioImages;
    final latestDecision = latestReviewDecision(state);

    return required.every((item) => item.isComplete) &&
        state.verification.isIdentityVerified &&
        hasPortfolio &&
        latestDecision == InternalReviewDecision.approved;
  }

  bool canActivate(ArtistManagementState state) {
    return canSoftLaunch(state) &&
        state.operationalMetrics.qualityScore >= activeQualityScoreThreshold &&
        state.onboardingStatus != ArtistOnboardingStatus.suspended &&
        state.onboardingStatus != ArtistOnboardingStatus.rejected &&
        state.onboardingStatus != ArtistOnboardingStatus.deactivated;
  }

  bool shouldRecommendSuspension(List<ArtistRiskEvent> events) {
    final highCount = events.where((item) => item.severity == RiskSeverity.high)
        .length;
    final criticalCount = events
        .where((item) => item.severity == RiskSeverity.critical)
        .length;
    return criticalCount > 0 || highCount >= 3;
  }

  InternalReviewDecision latestReviewDecision(ArtistManagementState state) {
    if (state.internalReviews.isEmpty) {
      return InternalReviewDecision.pending;
    }
    return state.internalReviews.first.decision;
  }

  List<ArtistOnboardingStatus> allowedTransitionsFor(
    ArtistOnboardingStatus status,
    ArtistManagementState state,
  ) {
    switch (status) {
      case ArtistOnboardingStatus.draft:
        return submissionReadiness(state).canSubmit
            ? const [ArtistOnboardingStatus.applicationSubmitted]
            : const [];
      case ArtistOnboardingStatus.applicationSubmitted:
        return const [
          ArtistOnboardingStatus.profilePendingReview,
          ArtistOnboardingStatus.rejected,
        ];
      case ArtistOnboardingStatus.profilePendingReview:
        return const [
          ArtistOnboardingStatus.verificationInProgress,
          ArtistOnboardingStatus.rejected,
        ];
      case ArtistOnboardingStatus.verificationInProgress:
        return const [
          ArtistOnboardingStatus.identityVerified,
          ArtistOnboardingStatus.verificationFailed,
          ArtistOnboardingStatus.rejected,
        ];
      case ArtistOnboardingStatus.verificationFailed:
        return const [
          ArtistOnboardingStatus.verificationInProgress,
          ArtistOnboardingStatus.rejected,
        ];
      case ArtistOnboardingStatus.identityVerified:
        return const [
          ArtistOnboardingStatus.portfolioReview,
          ArtistOnboardingStatus.serviceSetupIncomplete,
        ];
      case ArtistOnboardingStatus.portfolioReview:
        return const [
          ArtistOnboardingStatus.portfolioRevisionRequired,
          ArtistOnboardingStatus.serviceSetupIncomplete,
          ArtistOnboardingStatus.serviceSetupComplete,
          ArtistOnboardingStatus.rejected,
        ];
      case ArtistOnboardingStatus.portfolioRevisionRequired:
        return const [
          ArtistOnboardingStatus.profilePendingReview,
          ArtistOnboardingStatus.portfolioReview,
          ArtistOnboardingStatus.rejected,
        ];
      case ArtistOnboardingStatus.serviceSetupIncomplete:
        return const [
          ArtistOnboardingStatus.serviceSetupComplete,
          ArtistOnboardingStatus.rejected,
        ];
      case ArtistOnboardingStatus.serviceSetupComplete:
        return [
          if (canSoftLaunch(state)) ArtistOnboardingStatus.softLive,
          if (canActivate(state)) ArtistOnboardingStatus.active,
        ];
      case ArtistOnboardingStatus.softLive:
        return [
          if (canActivate(state)) ArtistOnboardingStatus.active,
          ArtistOnboardingStatus.suspended,
          ArtistOnboardingStatus.deactivated,
        ];
      case ArtistOnboardingStatus.active:
        return const [
          ArtistOnboardingStatus.suspended,
          ArtistOnboardingStatus.deactivated,
        ];
      case ArtistOnboardingStatus.suspended:
        return const [
          ArtistOnboardingStatus.active,
          ArtistOnboardingStatus.deactivated,
        ];
      case ArtistOnboardingStatus.deactivated:
        return const [];
      case ArtistOnboardingStatus.rejected:
        return const [];
    }
  }

  bool canTransition(
    ArtistOnboardingStatus from,
    ArtistOnboardingStatus to,
    ArtistManagementState state,
  ) {
    return allowedTransitionsFor(from, state).contains(to);
  }
}

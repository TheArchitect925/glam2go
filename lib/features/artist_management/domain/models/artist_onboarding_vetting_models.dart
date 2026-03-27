import 'package:flutter/foundation.dart';

enum ArtistOnboardingStatus {
  draft,
  applicationSubmitted,
  profilePendingReview,
  verificationInProgress,
  verificationFailed,
  identityVerified,
  portfolioReview,
  portfolioRevisionRequired,
  serviceSetupIncomplete,
  serviceSetupComplete,
  softLive,
  active,
  suspended,
  deactivated,
  rejected,
}

enum ArtistVerificationStatus { notStarted, inProgress, failed, verified }

enum InternalReviewDecision { pending, approved, revisionRequired, rejected }

enum InternalReviewStage {
  application,
  profile,
  verification,
  portfolio,
  operationalReadiness,
}

enum RiskEventType {
  customerComplaint,
  lateArrival,
  noShow,
  cancellationPattern,
  policyViolation,
  professionalismConcern,
  responsivenessConcern,
  other,
}

enum RiskSeverity { low, medium, high, critical }

enum ArtistTier { pending, softLaunch, core, premium, restricted }

enum CustomQuoteEligibilityStatus {
  ineligible,
  pendingReview,
  softEligible,
  approved,
  restricted,
}

enum ArtistChecklistRequirement {
  legalName,
  displayName,
  email,
  phone,
  city,
  provinceOrState,
  bio,
  profileImage,
  specialties,
  yearsOfExperience,
  travelRadius,
  serviceAreaSummary,
  portfolioImages,
  packages,
  availability,
  verification,
}

@immutable
class ArtistSocialLinks {
  const ArtistSocialLinks({
    this.instagram,
    this.tiktok,
    this.website,
  });

  final String? instagram;
  final String? tiktok;
  final String? website;

  ArtistSocialLinks copyWith({
    String? instagram,
    String? tiktok,
    String? website,
  }) {
    return ArtistSocialLinks(
      instagram: instagram ?? this.instagram,
      tiktok: tiktok ?? this.tiktok,
      website: website ?? this.website,
    );
  }
}

@immutable
class ArtistVerification {
  const ArtistVerification({
    required this.emailVerified,
    required this.phoneVerified,
    required this.governmentIdVerified,
    required this.selfieVerified,
    required this.businessVerified,
    required this.insuranceVerified,
    this.verificationFailureReason,
    this.lastVerificationUpdatedAt,
  });

  final bool emailVerified;
  final bool phoneVerified;
  final bool governmentIdVerified;
  final bool selfieVerified;
  final bool businessVerified;
  final bool insuranceVerified;
  final String? verificationFailureReason;
  final DateTime? lastVerificationUpdatedAt;

  ArtistVerificationStatus get status {
    if (verificationFailureReason != null &&
        verificationFailureReason!.trim().isNotEmpty &&
        !(emailVerified &&
            phoneVerified &&
            governmentIdVerified &&
            selfieVerified)) {
      return ArtistVerificationStatus.failed;
    }
    if (emailVerified &&
        phoneVerified &&
        governmentIdVerified &&
        selfieVerified) {
      return ArtistVerificationStatus.verified;
    }
    if (emailVerified ||
        phoneVerified ||
        governmentIdVerified ||
        selfieVerified ||
        businessVerified ||
        insuranceVerified) {
      return ArtistVerificationStatus.inProgress;
    }
    return ArtistVerificationStatus.notStarted;
  }

  bool get isIdentityVerified =>
      emailVerified &&
      phoneVerified &&
      governmentIdVerified &&
      selfieVerified;

  ArtistVerification copyWith({
    bool? emailVerified,
    bool? phoneVerified,
    bool? governmentIdVerified,
    bool? selfieVerified,
    bool? businessVerified,
    bool? insuranceVerified,
    String? verificationFailureReason,
    DateTime? lastVerificationUpdatedAt,
  }) {
    return ArtistVerification(
      emailVerified: emailVerified ?? this.emailVerified,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      governmentIdVerified:
          governmentIdVerified ?? this.governmentIdVerified,
      selfieVerified: selfieVerified ?? this.selfieVerified,
      businessVerified: businessVerified ?? this.businessVerified,
      insuranceVerified: insuranceVerified ?? this.insuranceVerified,
      verificationFailureReason:
          verificationFailureReason ?? this.verificationFailureReason,
      lastVerificationUpdatedAt:
          lastVerificationUpdatedAt ?? this.lastVerificationUpdatedAt,
    );
  }
}

@immutable
class ArtistReviewScores {
  const ArtistReviewScores({
    required this.technicalSkill,
    required this.styleRange,
    required this.portfolioQuality,
    required this.professionalPresentation,
    required this.totalScore,
  });

  final int technicalSkill;
  final int styleRange;
  final int portfolioQuality;
  final int professionalPresentation;
  final int totalScore;

  ArtistReviewScores copyWith({
    int? technicalSkill,
    int? styleRange,
    int? portfolioQuality,
    int? professionalPresentation,
    int? totalScore,
  }) {
    return ArtistReviewScores(
      technicalSkill: technicalSkill ?? this.technicalSkill,
      styleRange: styleRange ?? this.styleRange,
      portfolioQuality: portfolioQuality ?? this.portfolioQuality,
      professionalPresentation:
          professionalPresentation ?? this.professionalPresentation,
      totalScore: totalScore ?? this.totalScore,
    );
  }
}

@immutable
class ArtistSoftLaunchConfig {
  const ArtistSoftLaunchConfig({
    required this.isEnabled,
    required this.maxBookings,
    required this.completedBookings,
    required this.notes,
    this.restrictedRadiusKm,
  });

  final bool isEnabled;
  final int maxBookings;
  final int completedBookings;
  final String notes;
  final int? restrictedRadiusKm;

  bool get hasCapacity => completedBookings < maxBookings;

  ArtistSoftLaunchConfig copyWith({
    bool? isEnabled,
    int? maxBookings,
    int? completedBookings,
    String? notes,
    int? restrictedRadiusKm,
  }) {
    return ArtistSoftLaunchConfig(
      isEnabled: isEnabled ?? this.isEnabled,
      maxBookings: maxBookings ?? this.maxBookings,
      completedBookings: completedBookings ?? this.completedBookings,
      notes: notes ?? this.notes,
      restrictedRadiusKm: restrictedRadiusKm ?? this.restrictedRadiusKm,
    );
  }
}

@immutable
class ArtistOperationalMetrics {
  const ArtistOperationalMetrics({
    required this.ratingAverage,
    required this.ratingCount,
    required this.completedJobsCount,
    required this.completionRate,
    required this.cancellationRate,
    required this.noShowRate,
    required this.latenessRate,
    required this.complaintRate,
    required this.quoteResponseRate,
    required this.quoteResponseSpeedScore,
    required this.qualityScore,
  });

  final double ratingAverage;
  final int ratingCount;
  final int completedJobsCount;
  final double completionRate;
  final double cancellationRate;
  final double noShowRate;
  final double latenessRate;
  final double complaintRate;
  final double quoteResponseRate;
  final double quoteResponseSpeedScore;
  final int qualityScore;

  ArtistOperationalMetrics copyWith({
    double? ratingAverage,
    int? ratingCount,
    int? completedJobsCount,
    double? completionRate,
    double? cancellationRate,
    double? noShowRate,
    double? latenessRate,
    double? complaintRate,
    double? quoteResponseRate,
    double? quoteResponseSpeedScore,
    int? qualityScore,
  }) {
    return ArtistOperationalMetrics(
      ratingAverage: ratingAverage ?? this.ratingAverage,
      ratingCount: ratingCount ?? this.ratingCount,
      completedJobsCount: completedJobsCount ?? this.completedJobsCount,
      completionRate: completionRate ?? this.completionRate,
      cancellationRate: cancellationRate ?? this.cancellationRate,
      noShowRate: noShowRate ?? this.noShowRate,
      latenessRate: latenessRate ?? this.latenessRate,
      complaintRate: complaintRate ?? this.complaintRate,
      quoteResponseRate: quoteResponseRate ?? this.quoteResponseRate,
      quoteResponseSpeedScore:
          quoteResponseSpeedScore ?? this.quoteResponseSpeedScore,
      qualityScore: qualityScore ?? this.qualityScore,
    );
  }
}

@immutable
class ArtistApprovalScope {
  const ArtistApprovalScope({
    required this.approvedCategories,
    required this.rejectedCategories,
    required this.customQuoteEligibleCategories,
    required this.restrictions,
    this.approvedBy,
    this.approvedAt,
  });

  final List<String> approvedCategories;
  final List<String> rejectedCategories;
  final List<String> customQuoteEligibleCategories;
  final List<String> restrictions;
  final String? approvedBy;
  final DateTime? approvedAt;

  ArtistApprovalScope copyWith({
    List<String>? approvedCategories,
    List<String>? rejectedCategories,
    List<String>? customQuoteEligibleCategories,
    List<String>? restrictions,
    String? approvedBy,
    DateTime? approvedAt,
  }) {
    return ArtistApprovalScope(
      approvedCategories: approvedCategories ?? this.approvedCategories,
      rejectedCategories: rejectedCategories ?? this.rejectedCategories,
      customQuoteEligibleCategories:
          customQuoteEligibleCategories ?? this.customQuoteEligibleCategories,
      restrictions: restrictions ?? this.restrictions,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedAt: approvedAt ?? this.approvedAt,
    );
  }
}

@immutable
class ArtistRiskEvent {
  const ArtistRiskEvent({
    required this.id,
    required this.artistId,
    required this.bookingId,
    required this.eventType,
    required this.severity,
    required this.notes,
    required this.createdAt,
    required this.createdBy,
  });

  final String id;
  final String artistId;
  final String? bookingId;
  final RiskEventType eventType;
  final RiskSeverity severity;
  final String notes;
  final DateTime createdAt;
  final String createdBy;
}

@immutable
class ArtistInternalReview {
  const ArtistInternalReview({
    required this.id,
    required this.artistId,
    required this.reviewStage,
    required this.scores,
    required this.decision,
    required this.notes,
    required this.reviewedBy,
    required this.createdAt,
  });

  final String id;
  final String artistId;
  final InternalReviewStage reviewStage;
  final ArtistReviewScores scores;
  final InternalReviewDecision decision;
  final String notes;
  final String reviewedBy;
  final DateTime createdAt;
}

@immutable
class ArtistOnboardingChecklistItem {
  const ArtistOnboardingChecklistItem({
    required this.requirement,
    required this.isComplete,
    required this.detail,
  });

  final ArtistChecklistRequirement requirement;
  final bool isComplete;
  final String detail;
}

@immutable
class ArtistOnboardingChecklistProgress {
  const ArtistOnboardingChecklistProgress({
    required this.items,
    required this.minimumPortfolioImages,
  });

  final List<ArtistOnboardingChecklistItem> items;
  final int minimumPortfolioImages;

  int get completedCount => items.where((item) => item.isComplete).length;
  int get totalCount => items.length;
  bool get isComplete => items.every((item) => item.isComplete);

  List<ArtistChecklistRequirement> get missingRequirements => items
      .where((item) => !item.isComplete)
      .map((item) => item.requirement)
      .toList(growable: false);
}

@immutable
class ArtistSubmissionReadiness {
  const ArtistSubmissionReadiness({
    required this.canSubmit,
    required this.checklist,
  });

  final bool canSubmit;
  final ArtistOnboardingChecklistProgress checklist;
}

@immutable
class ArtistEligibilitySummary {
  const ArtistEligibilitySummary({
    required this.canSoftLaunch,
    required this.canGoActive,
    required this.customQuoteEligibilityStatus,
    required this.qualityScore,
    required this.shouldRecommendSuspension,
  });

  final bool canSoftLaunch;
  final bool canGoActive;
  final CustomQuoteEligibilityStatus customQuoteEligibilityStatus;
  final int qualityScore;
  final bool shouldRecommendSuspension;
}

import '../../domain/models/artist_management_models.dart';
import 'artist_management_state_dto.dart';

class ArtistOnboardingFirestoreCollections {
  static const artists = 'artists';
  static const artistInternalReviews = 'artist_internal_reviews';
  static const artistRiskEvents = 'artist_risk_events';
}

class ArtistDocumentDto {
  const ArtistDocumentDto({
    required this.artistId,
    required this.profile,
    required this.onboardingStatus,
    required this.verification,
    required this.softLaunchConfig,
    required this.operationalMetrics,
    required this.approvalScope,
    required this.artistTier,
    required this.customQuoteEligibilityStatus,
    required this.isVerified,
    required this.isAcceptingBookings,
    required this.isAcceptingCustomQuotes,
    required this.createdAtIso,
    required this.updatedAtIso,
  });

  factory ArtistDocumentDto.fromDomain(ArtistManagementState state) {
    return ArtistDocumentDto(
      artistId: state.artistId,
      profile: ArtistProfileDraftDto.fromDomain(state.profileDraft),
      onboardingStatus: state.onboardingStatus.name,
      verification: ArtistVerificationDto.fromDomain(state.verification),
      softLaunchConfig: ArtistSoftLaunchConfigDto.fromDomain(
        state.softLaunchConfig,
      ),
      operationalMetrics: ArtistOperationalMetricsDto.fromDomain(
        state.operationalMetrics,
      ),
      approvalScope: ArtistApprovalScopeDto.fromDomain(state.approvalScope),
      artistTier: state.artistTier.name,
      customQuoteEligibilityStatus: state.customQuoteEligibilityStatus.name,
      isVerified: state.isVerified,
      isAcceptingBookings: state.isAcceptingBookings,
      isAcceptingCustomQuotes: state.isAcceptingCustomQuotes,
      createdAtIso: state.profileDraft.createdAt.toIso8601String(),
      updatedAtIso: state.profileDraft.updatedAt.toIso8601String(),
    );
  }

  factory ArtistDocumentDto.fromMap(Map<String, Object?> map) {
    return ArtistDocumentDto(
      artistId: (map['artistId'] as String?) ?? '',
      profile: ArtistProfileDraftDto.fromMap(_mapValue(map['profile'])),
      onboardingStatus:
          (map['onboardingStatus'] as String?) ??
          ArtistOnboardingStatus.draft.name,
      verification: ArtistVerificationDto.fromMap(
        _mapValue(map['verification']),
      ),
      softLaunchConfig: ArtistSoftLaunchConfigDto.fromMap(
        _mapValue(map['softLaunchConfig']),
      ),
      operationalMetrics: ArtistOperationalMetricsDto.fromMap(
        _mapValue(map['operationalMetrics']),
      ),
      approvalScope: ArtistApprovalScopeDto.fromMap(
        _mapValue(map['approvalScope']),
      ),
      artistTier: (map['artistTier'] as String?) ?? ArtistTier.pending.name,
      customQuoteEligibilityStatus:
          (map['customQuoteEligibilityStatus'] as String?) ??
          CustomQuoteEligibilityStatus.ineligible.name,
      isVerified: (map['isVerified'] as bool?) ?? false,
      isAcceptingBookings: (map['isAcceptingBookings'] as bool?) ?? false,
      isAcceptingCustomQuotes:
          (map['isAcceptingCustomQuotes'] as bool?) ?? false,
      createdAtIso: (map['createdAtIso'] as String?) ?? '',
      updatedAtIso: (map['updatedAtIso'] as String?) ?? '',
    );
  }

  final String artistId;
  final ArtistProfileDraftDto profile;
  final String onboardingStatus;
  final ArtistVerificationDto verification;
  final ArtistSoftLaunchConfigDto softLaunchConfig;
  final ArtistOperationalMetricsDto operationalMetrics;
  final ArtistApprovalScopeDto approvalScope;
  final String artistTier;
  final String customQuoteEligibilityStatus;
  final bool isVerified;
  final bool isAcceptingBookings;
  final bool isAcceptingCustomQuotes;
  final String createdAtIso;
  final String updatedAtIso;

  Map<String, Object?> toMap() => {
    'artistId': artistId,
    'profile': profile.toMap(),
    'onboardingStatus': onboardingStatus,
    'verification': verification.toMap(),
    'softLaunchConfig': softLaunchConfig.toMap(),
    'operationalMetrics': operationalMetrics.toMap(),
    'approvalScope': approvalScope.toMap(),
    'artistTier': artistTier,
    'customQuoteEligibilityStatus': customQuoteEligibilityStatus,
    'isVerified': isVerified,
    'isAcceptingBookings': isAcceptingBookings,
    'isAcceptingCustomQuotes': isAcceptingCustomQuotes,
    'createdAtIso': createdAtIso,
    'updatedAtIso': updatedAtIso,
  };
}

class ArtistInternalReviewDocumentDto {
  const ArtistInternalReviewDocumentDto({
    required this.reviewId,
    required this.review,
  });

  factory ArtistInternalReviewDocumentDto.fromDomain(
    ArtistInternalReview review,
  ) {
    return ArtistInternalReviewDocumentDto(
      reviewId: review.id,
      review: ArtistInternalReviewDto.fromDomain(review),
    );
  }

  factory ArtistInternalReviewDocumentDto.fromMap(Map<String, Object?> map) {
    return ArtistInternalReviewDocumentDto(
      reviewId: (map['reviewId'] as String?) ?? '',
      review: ArtistInternalReviewDto.fromMap(_mapValue(map['review'])),
    );
  }

  final String reviewId;
  final ArtistInternalReviewDto review;

  Map<String, Object?> toMap() => {
    'reviewId': reviewId,
    'review': review.toMap(),
  };
}

class ArtistRiskEventDocumentDto {
  const ArtistRiskEventDocumentDto({
    required this.eventId,
    required this.event,
  });

  factory ArtistRiskEventDocumentDto.fromDomain(ArtistRiskEvent event) {
    return ArtistRiskEventDocumentDto(
      eventId: event.id,
      event: ArtistRiskEventDto.fromDomain(event),
    );
  }

  factory ArtistRiskEventDocumentDto.fromMap(Map<String, Object?> map) {
    return ArtistRiskEventDocumentDto(
      eventId: (map['eventId'] as String?) ?? '',
      event: ArtistRiskEventDto.fromMap(_mapValue(map['event'])),
    );
  }

  final String eventId;
  final ArtistRiskEventDto event;

  Map<String, Object?> toMap() => {
    'eventId': eventId,
    'event': event.toMap(),
  };
}

Map<String, Object?> _mapValue(Object? value) {
  if (value is Map<Object?, Object?>) {
    return value.cast<String, Object?>();
  }
  return const {};
}

import 'package:flutter/foundation.dart';

import '../../../booking/domain/models/marketplace_booking_models.dart';
export 'artist_onboarding_vetting_models.dart';

enum ArtistOnboardingStep {
  welcome,
  profile,
  travel,
  packages,
  availability,
  summary,
}

@immutable
class ArtistSpecialtyTag {
  const ArtistSpecialtyTag({required this.label, this.isSelected = false});

  final String label;
  final bool isSelected;

  ArtistSpecialtyTag copyWith({String? label, bool? isSelected}) {
    return ArtistSpecialtyTag(
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

@immutable
class ArtistPortfolioItemDraft {
  const ArtistPortfolioItemDraft({
    required this.id,
    required this.title,
    required this.category,
    required this.caption,
    this.mediaUrl,
    this.mediaReference,
    required this.startColorValue,
    required this.endColorValue,
  });

  final String id;
  final String title;
  final String category;
  final String caption;
  final String? mediaUrl;
  final String? mediaReference;
  final int startColorValue;
  final int endColorValue;

  ArtistPortfolioItemDraft copyWith({
    String? id,
    String? title,
    String? category,
    String? caption,
    String? mediaUrl,
    String? mediaReference,
    int? startColorValue,
    int? endColorValue,
  }) {
    return ArtistPortfolioItemDraft(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      caption: caption ?? this.caption,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaReference: mediaReference ?? this.mediaReference,
      startColorValue: startColorValue ?? this.startColorValue,
      endColorValue: endColorValue ?? this.endColorValue,
    );
  }
}

@immutable
class ArtistServicePackageDraft {
  const ArtistServicePackageDraft({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.includes,
    required this.suitableOccasions,
    required this.isActive,
  });

  final String id;
  final String title;
  final String description;
  final int price;
  final int durationMinutes;
  final List<String> includes;
  final List<String> suitableOccasions;
  final bool isActive;

  ArtistServicePackageDraft copyWith({
    String? id,
    String? title,
    String? description,
    int? price,
    int? durationMinutes,
    List<String>? includes,
    List<String>? suitableOccasions,
    bool? isActive,
  }) {
    return ArtistServicePackageDraft(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      includes: includes ?? this.includes,
      suitableOccasions: suitableOccasions ?? this.suitableOccasions,
      isActive: isActive ?? this.isActive,
    );
  }
}

@immutable
class ArtistTimeWindow {
  const ArtistTimeWindow({
    required this.id,
    required this.startLabel,
    required this.endLabel,
  });

  final String id;
  final String startLabel;
  final String endLabel;

  String get summary => '$startLabel - $endLabel';
}

@immutable
class ArtistAvailabilityDay {
  const ArtistAvailabilityDay({
    required this.dayKey,
    required this.dayLabel,
    required this.isAvailable,
    required this.windows,
  });

  final String dayKey;
  final String dayLabel;
  final bool isAvailable;
  final List<ArtistTimeWindow> windows;

  ArtistAvailabilityDay copyWith({
    String? dayKey,
    String? dayLabel,
    bool? isAvailable,
    List<ArtistTimeWindow>? windows,
  }) {
    return ArtistAvailabilityDay(
      dayKey: dayKey ?? this.dayKey,
      dayLabel: dayLabel ?? this.dayLabel,
      isAvailable: isAvailable ?? this.isAvailable,
      windows: windows ?? this.windows,
    );
  }
}

@immutable
class ArtistTravelPolicy {
  const ArtistTravelPolicy({
    required this.primaryServiceArea,
    required this.includedRadiusKm,
    required this.extraTravelFee,
    required this.maxTravelDistanceKm,
    required this.travelNotes,
  });

  final String primaryServiceArea;
  final int includedRadiusKm;
  final int extraTravelFee;
  final int maxTravelDistanceKm;
  final String travelNotes;

  ArtistTravelPolicy copyWith({
    String? primaryServiceArea,
    int? includedRadiusKm,
    int? extraTravelFee,
    int? maxTravelDistanceKm,
    String? travelNotes,
  }) {
    return ArtistTravelPolicy(
      primaryServiceArea: primaryServiceArea ?? this.primaryServiceArea,
      includedRadiusKm: includedRadiusKm ?? this.includedRadiusKm,
      extraTravelFee: extraTravelFee ?? this.extraTravelFee,
      maxTravelDistanceKm: maxTravelDistanceKm ?? this.maxTravelDistanceKm,
      travelNotes: travelNotes ?? this.travelNotes,
    );
  }
}

@immutable
class ArtistSocialLinkSummary {
  const ArtistSocialLinkSummary({
    required this.instagramHandle,
    required this.tiktokHandle,
    this.websiteUrl,
  });

  final String instagramHandle;
  final String tiktokHandle;
  final String? websiteUrl;

  ArtistSocialLinkSummary copyWith({
    String? instagramHandle,
    String? tiktokHandle,
    String? websiteUrl,
  }) {
    return ArtistSocialLinkSummary(
      instagramHandle: instagramHandle ?? this.instagramHandle,
      tiktokHandle: tiktokHandle ?? this.tiktokHandle,
      websiteUrl: websiteUrl ?? this.websiteUrl,
    );
  }
}

@immutable
class ArtistProfileDraft {
  const ArtistProfileDraft({
    required this.legalName,
    required this.displayName,
    required this.email,
    required this.phone,
    required this.city,
    required this.provinceOrState,
    required this.serviceAreaSummary,
    required this.bio,
    required this.profileImageUrl,
    required this.experienceSummary,
    required this.socialLinks,
    required this.specialties,
    required this.portfolioItems,
    required this.yearsOfExperience,
    required this.createdAt,
    required this.updatedAt,
  });

  final String legalName;
  final String displayName;
  final String email;
  final String phone;
  final String city;
  final String provinceOrState;
  final String serviceAreaSummary;
  final String bio;
  final String profileImageUrl;
  final String experienceSummary;
  final ArtistSocialLinkSummary socialLinks;
  final List<ArtistSpecialtyTag> specialties;
  final List<ArtistPortfolioItemDraft> portfolioItems;
  final int yearsOfExperience;
  final DateTime createdAt;
  final DateTime updatedAt;

  List<String> get categories => specialties
      .where((item) => item.isSelected)
      .map((item) => item.label)
      .toList(growable: false);

  List<String> get portfolioImageUrls => portfolioItems
      .map((item) => item.mediaUrl ?? item.mediaReference ?? '')
      .where((item) => item.trim().isNotEmpty)
      .toList(growable: false);

  String get instagramHandle => socialLinks.instagramHandle;
  String get tiktokHandle => socialLinks.tiktokHandle;

  ArtistProfileDraft copyWith({
    String? legalName,
    String? displayName,
    String? email,
    String? phone,
    String? city,
    String? provinceOrState,
    String? serviceAreaSummary,
    String? bio,
    String? profileImageUrl,
    String? experienceSummary,
    ArtistSocialLinkSummary? socialLinks,
    List<ArtistSpecialtyTag>? specialties,
    List<ArtistPortfolioItemDraft>? portfolioItems,
    int? yearsOfExperience,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ArtistProfileDraft(
      legalName: legalName ?? this.legalName,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      provinceOrState: provinceOrState ?? this.provinceOrState,
      serviceAreaSummary: serviceAreaSummary ?? this.serviceAreaSummary,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      experienceSummary: experienceSummary ?? this.experienceSummary,
      socialLinks: socialLinks ?? this.socialLinks,
      specialties: specialties ?? this.specialties,
      portfolioItems: portfolioItems ?? this.portfolioItems,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

@immutable
class ArtistBookingSummary {
  const ArtistBookingSummary({
    required this.id,
    required this.customerName,
    required this.packageTitle,
    required this.scheduledAt,
    required this.timeLabel,
    required this.areaLabel,
    required this.status,
    required this.eventLabel,
    required this.travelIncluded,
    required this.travelFee,
    required this.isUpcoming,
  });

  final String id;
  final String customerName;
  final String packageTitle;
  final DateTime scheduledAt;
  final String timeLabel;
  final String areaLabel;
  final BookingLifecycleStatus status;
  final String eventLabel;
  final bool travelIncluded;
  final int travelFee;
  final bool isUpcoming;
}

@immutable
class ArtistReadinessSummary {
  const ArtistReadinessSummary({
    required this.progress,
    required this.completedCount,
    required this.totalCount,
    required this.missingItems,
  });

  final double progress;
  final int completedCount;
  final int totalCount;
  final List<ArtistChecklistRequirement> missingItems;
}

@immutable
class ArtistManagementState {
  const ArtistManagementState({
    required this.publicArtistId,
    required this.onboardingStep,
    required this.profileDraft,
    required this.travelPolicy,
    required this.packages,
    required this.availabilityDays,
    required this.bookings,
    required this.onboardingStatus,
    required this.verification,
    required this.softLaunchConfig,
    required this.operationalMetrics,
    required this.approvalScope,
    required this.riskEvents,
    required this.internalReviews,
    required this.artistTier,
    required this.customQuoteEligibilityStatus,
    required this.isVerified,
    required this.isAcceptingBookings,
    required this.isAcceptingCustomQuotes,
    required this.notificationsEnabled,
    required this.businessNotificationsEnabled,
  });

  final String publicArtistId;
  final ArtistOnboardingStep onboardingStep;
  final ArtistProfileDraft profileDraft;
  final ArtistTravelPolicy travelPolicy;
  final List<ArtistServicePackageDraft> packages;
  final List<ArtistAvailabilityDay> availabilityDays;
  final List<ArtistBookingSummary> bookings;
  final ArtistOnboardingStatus onboardingStatus;
  final ArtistVerification verification;
  final ArtistSoftLaunchConfig softLaunchConfig;
  final ArtistOperationalMetrics operationalMetrics;
  final ArtistApprovalScope approvalScope;
  final List<ArtistRiskEvent> riskEvents;
  final List<ArtistInternalReview> internalReviews;
  final ArtistTier artistTier;
  final CustomQuoteEligibilityStatus customQuoteEligibilityStatus;
  final bool isVerified;
  final bool isAcceptingBookings;
  final bool isAcceptingCustomQuotes;
  final bool notificationsEnabled;
  final bool businessNotificationsEnabled;

  String get artistId => publicArtistId;
  int get travelRadiusKm => travelPolicy.includedRadiusKm;
  int get maxTravelRadiusKm => travelPolicy.maxTravelDistanceKm;

  ArtistManagementState copyWith({
    String? publicArtistId,
    ArtistOnboardingStep? onboardingStep,
    ArtistProfileDraft? profileDraft,
    ArtistTravelPolicy? travelPolicy,
    List<ArtistServicePackageDraft>? packages,
    List<ArtistAvailabilityDay>? availabilityDays,
    List<ArtistBookingSummary>? bookings,
    ArtistOnboardingStatus? onboardingStatus,
    ArtistVerification? verification,
    ArtistSoftLaunchConfig? softLaunchConfig,
    ArtistOperationalMetrics? operationalMetrics,
    ArtistApprovalScope? approvalScope,
    List<ArtistRiskEvent>? riskEvents,
    List<ArtistInternalReview>? internalReviews,
    ArtistTier? artistTier,
    CustomQuoteEligibilityStatus? customQuoteEligibilityStatus,
    bool? isVerified,
    bool? isAcceptingBookings,
    bool? isAcceptingCustomQuotes,
    bool? notificationsEnabled,
    bool? businessNotificationsEnabled,
  }) {
    return ArtistManagementState(
      publicArtistId: publicArtistId ?? this.publicArtistId,
      onboardingStep: onboardingStep ?? this.onboardingStep,
      profileDraft: profileDraft ?? this.profileDraft,
      travelPolicy: travelPolicy ?? this.travelPolicy,
      packages: packages ?? this.packages,
      availabilityDays: availabilityDays ?? this.availabilityDays,
      bookings: bookings ?? this.bookings,
      onboardingStatus: onboardingStatus ?? this.onboardingStatus,
      verification: verification ?? this.verification,
      softLaunchConfig: softLaunchConfig ?? this.softLaunchConfig,
      operationalMetrics: operationalMetrics ?? this.operationalMetrics,
      approvalScope: approvalScope ?? this.approvalScope,
      riskEvents: riskEvents ?? this.riskEvents,
      internalReviews: internalReviews ?? this.internalReviews,
      artistTier: artistTier ?? this.artistTier,
      customQuoteEligibilityStatus:
          customQuoteEligibilityStatus ?? this.customQuoteEligibilityStatus,
      isVerified: isVerified ?? this.isVerified,
      isAcceptingBookings: isAcceptingBookings ?? this.isAcceptingBookings,
      isAcceptingCustomQuotes:
          isAcceptingCustomQuotes ?? this.isAcceptingCustomQuotes,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      businessNotificationsEnabled:
          businessNotificationsEnabled ?? this.businessNotificationsEnabled,
    );
  }
}

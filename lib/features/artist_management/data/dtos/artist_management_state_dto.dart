import '../../domain/models/artist_management_models.dart';

class ArtistManagementStateDto {
  const ArtistManagementStateDto({
    required this.publicArtistId,
    required this.onboardingStep,
    required this.onboardingStatus,
    required this.profileDraft,
    required this.travelPolicy,
    required this.packages,
    required this.availabilityDays,
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

  factory ArtistManagementStateDto.fromDomain(ArtistManagementState state) {
    return ArtistManagementStateDto(
      publicArtistId: state.publicArtistId,
      onboardingStep: state.onboardingStep.name,
      onboardingStatus: state.onboardingStatus.name,
      profileDraft: ArtistProfileDraftDto.fromDomain(state.profileDraft),
      travelPolicy: ArtistTravelPolicyDto.fromDomain(state.travelPolicy),
      packages: state.packages
          .map(ArtistServicePackageDraftDto.fromDomain)
          .toList(growable: false),
      availabilityDays: state.availabilityDays
          .map(ArtistAvailabilityDayDto.fromDomain)
          .toList(growable: false),
      verification: ArtistVerificationDto.fromDomain(state.verification),
      softLaunchConfig: ArtistSoftLaunchConfigDto.fromDomain(
        state.softLaunchConfig,
      ),
      operationalMetrics: ArtistOperationalMetricsDto.fromDomain(
        state.operationalMetrics,
      ),
      approvalScope: ArtistApprovalScopeDto.fromDomain(state.approvalScope),
      riskEvents: state.riskEvents
          .map(ArtistRiskEventDto.fromDomain)
          .toList(growable: false),
      internalReviews: state.internalReviews
          .map(ArtistInternalReviewDto.fromDomain)
          .toList(growable: false),
      artistTier: state.artistTier.name,
      customQuoteEligibilityStatus: state.customQuoteEligibilityStatus.name,
      isVerified: state.isVerified,
      isAcceptingBookings: state.isAcceptingBookings,
      isAcceptingCustomQuotes: state.isAcceptingCustomQuotes,
      notificationsEnabled: state.notificationsEnabled,
      businessNotificationsEnabled: state.businessNotificationsEnabled,
    );
  }

  factory ArtistManagementStateDto.fromMap(Map<String, Object?> map) {
    return ArtistManagementStateDto(
      publicArtistId: (map['publicArtistId'] as String?) ?? '',
      onboardingStep:
          (map['onboardingStep'] as String?) ??
          ArtistOnboardingStep.welcome.name,
      onboardingStatus:
          (map['onboardingStatus'] as String?) ??
          ArtistOnboardingStatus.draft.name,
      profileDraft: ArtistProfileDraftDto.fromMap(
        _mapValue(map['profileDraft']),
      ),
      travelPolicy: ArtistTravelPolicyDto.fromMap(_mapValue(map['travelPolicy'])),
      packages: _listValue(map['packages'])
          .map(ArtistServicePackageDraftDto.fromMap)
          .toList(growable: false),
      availabilityDays: _listValue(map['availabilityDays'])
          .map(ArtistAvailabilityDayDto.fromMap)
          .toList(growable: false),
      verification: ArtistVerificationDto.fromMap(_mapValue(map['verification'])),
      softLaunchConfig: ArtistSoftLaunchConfigDto.fromMap(
        _mapValue(map['softLaunchConfig']),
      ),
      operationalMetrics: ArtistOperationalMetricsDto.fromMap(
        _mapValue(map['operationalMetrics']),
      ),
      approvalScope: ArtistApprovalScopeDto.fromMap(
        _mapValue(map['approvalScope']),
      ),
      riskEvents: _listValue(map['riskEvents'])
          .map(ArtistRiskEventDto.fromMap)
          .toList(growable: false),
      internalReviews: _listValue(map['internalReviews'])
          .map(ArtistInternalReviewDto.fromMap)
          .toList(growable: false),
      artistTier: (map['artistTier'] as String?) ?? ArtistTier.pending.name,
      customQuoteEligibilityStatus:
          (map['customQuoteEligibilityStatus'] as String?) ??
          CustomQuoteEligibilityStatus.ineligible.name,
      isVerified: (map['isVerified'] as bool?) ?? false,
      isAcceptingBookings: (map['isAcceptingBookings'] as bool?) ?? false,
      isAcceptingCustomQuotes:
          (map['isAcceptingCustomQuotes'] as bool?) ?? false,
      notificationsEnabled: (map['notificationsEnabled'] as bool?) ?? true,
      businessNotificationsEnabled:
          (map['businessNotificationsEnabled'] as bool?) ?? true,
    );
  }

  final String publicArtistId;
  final String onboardingStep;
  final String onboardingStatus;
  final ArtistProfileDraftDto profileDraft;
  final ArtistTravelPolicyDto travelPolicy;
  final List<ArtistServicePackageDraftDto> packages;
  final List<ArtistAvailabilityDayDto> availabilityDays;
  final ArtistVerificationDto verification;
  final ArtistSoftLaunchConfigDto softLaunchConfig;
  final ArtistOperationalMetricsDto operationalMetrics;
  final ArtistApprovalScopeDto approvalScope;
  final List<ArtistRiskEventDto> riskEvents;
  final List<ArtistInternalReviewDto> internalReviews;
  final String artistTier;
  final String customQuoteEligibilityStatus;
  final bool isVerified;
  final bool isAcceptingBookings;
  final bool isAcceptingCustomQuotes;
  final bool notificationsEnabled;
  final bool businessNotificationsEnabled;

  Map<String, Object?> toMap() => {
    'publicArtistId': publicArtistId,
    'onboardingStep': onboardingStep,
    'onboardingStatus': onboardingStatus,
    'profileDraft': profileDraft.toMap(),
    'travelPolicy': travelPolicy.toMap(),
    'packages': packages.map((item) => item.toMap()).toList(growable: false),
    'availabilityDays': availabilityDays
        .map((item) => item.toMap())
        .toList(growable: false),
    'verification': verification.toMap(),
    'softLaunchConfig': softLaunchConfig.toMap(),
    'operationalMetrics': operationalMetrics.toMap(),
    'approvalScope': approvalScope.toMap(),
    'riskEvents': riskEvents.map((item) => item.toMap()).toList(growable: false),
    'internalReviews': internalReviews
        .map((item) => item.toMap())
        .toList(growable: false),
    'artistTier': artistTier,
    'customQuoteEligibilityStatus': customQuoteEligibilityStatus,
    'isVerified': isVerified,
    'isAcceptingBookings': isAcceptingBookings,
    'isAcceptingCustomQuotes': isAcceptingCustomQuotes,
    'notificationsEnabled': notificationsEnabled,
    'businessNotificationsEnabled': businessNotificationsEnabled,
  };

  ArtistManagementState toDomain() {
    return ArtistManagementState(
      publicArtistId: publicArtistId,
      onboardingStep: ArtistOnboardingStep.values.byName(onboardingStep),
      onboardingStatus: ArtistOnboardingStatus.values.byName(onboardingStatus),
      profileDraft: profileDraft.toDomain(),
      travelPolicy: travelPolicy.toDomain(),
      packages: packages.map((item) => item.toDomain()).toList(growable: false),
      availabilityDays: availabilityDays
          .map((item) => item.toDomain())
          .toList(growable: false),
      bookings: const [],
      verification: verification.toDomain(),
      softLaunchConfig: softLaunchConfig.toDomain(),
      operationalMetrics: operationalMetrics.toDomain(),
      approvalScope: approvalScope.toDomain(),
      riskEvents: riskEvents.map((item) => item.toDomain()).toList(growable: false),
      internalReviews: internalReviews
          .map((item) => item.toDomain())
          .toList(growable: false),
      artistTier: ArtistTier.values.byName(artistTier),
      customQuoteEligibilityStatus: CustomQuoteEligibilityStatus.values.byName(
        customQuoteEligibilityStatus,
      ),
      isVerified: isVerified,
      isAcceptingBookings: isAcceptingBookings,
      isAcceptingCustomQuotes: isAcceptingCustomQuotes,
      notificationsEnabled: notificationsEnabled,
      businessNotificationsEnabled: businessNotificationsEnabled,
    );
  }
}

class ArtistProfileDraftDto {
  const ArtistProfileDraftDto({
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
    required this.createdAtIso,
    required this.updatedAtIso,
  });

  factory ArtistProfileDraftDto.fromDomain(ArtistProfileDraft draft) {
    return ArtistProfileDraftDto(
      legalName: draft.legalName,
      displayName: draft.displayName,
      email: draft.email,
      phone: draft.phone,
      city: draft.city,
      provinceOrState: draft.provinceOrState,
      serviceAreaSummary: draft.serviceAreaSummary,
      bio: draft.bio,
      profileImageUrl: draft.profileImageUrl,
      experienceSummary: draft.experienceSummary,
      socialLinks: ArtistSocialLinkSummaryDto.fromDomain(draft.socialLinks),
      specialties: draft.specialties
          .map(ArtistSpecialtyTagDto.fromDomain)
          .toList(growable: false),
      portfolioItems: draft.portfolioItems
          .map(ArtistPortfolioItemDraftDto.fromDomain)
          .toList(growable: false),
      yearsOfExperience: draft.yearsOfExperience,
      createdAtIso: draft.createdAt.toIso8601String(),
      updatedAtIso: draft.updatedAt.toIso8601String(),
    );
  }

  factory ArtistProfileDraftDto.fromMap(Map<String, Object?> map) {
    return ArtistProfileDraftDto(
      legalName: (map['legalName'] as String?) ?? '',
      displayName: (map['displayName'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      phone: (map['phone'] as String?) ?? '',
      city: (map['city'] as String?) ?? '',
      provinceOrState: (map['provinceOrState'] as String?) ?? '',
      serviceAreaSummary: (map['serviceAreaSummary'] as String?) ?? '',
      bio: (map['bio'] as String?) ?? '',
      profileImageUrl: (map['profileImageUrl'] as String?) ?? '',
      experienceSummary: (map['experienceSummary'] as String?) ?? '',
      socialLinks: ArtistSocialLinkSummaryDto.fromMap(
        _mapValue(map['socialLinks']),
      ),
      specialties: _listValue(map['specialties'])
          .map(ArtistSpecialtyTagDto.fromMap)
          .toList(growable: false),
      portfolioItems: _listValue(map['portfolioItems'])
          .map(ArtistPortfolioItemDraftDto.fromMap)
          .toList(growable: false),
      yearsOfExperience: (map['yearsOfExperience'] as int?) ?? 0,
      createdAtIso: (map['createdAtIso'] as String?) ??
          DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      updatedAtIso: (map['updatedAtIso'] as String?) ??
          DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
    );
  }

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
  final ArtistSocialLinkSummaryDto socialLinks;
  final List<ArtistSpecialtyTagDto> specialties;
  final List<ArtistPortfolioItemDraftDto> portfolioItems;
  final int yearsOfExperience;
  final String createdAtIso;
  final String updatedAtIso;

  Map<String, Object?> toMap() => {
    'legalName': legalName,
    'displayName': displayName,
    'email': email,
    'phone': phone,
    'city': city,
    'provinceOrState': provinceOrState,
    'serviceAreaSummary': serviceAreaSummary,
    'bio': bio,
    'profileImageUrl': profileImageUrl,
    'experienceSummary': experienceSummary,
    'socialLinks': socialLinks.toMap(),
    'specialties': specialties
        .map((item) => item.toMap())
        .toList(growable: false),
    'portfolioItems': portfolioItems
        .map((item) => item.toMap())
        .toList(growable: false),
    'yearsOfExperience': yearsOfExperience,
    'createdAtIso': createdAtIso,
    'updatedAtIso': updatedAtIso,
  };

  ArtistProfileDraft toDomain() {
    return ArtistProfileDraft(
      legalName: legalName,
      displayName: displayName,
      email: email,
      phone: phone,
      city: city,
      provinceOrState: provinceOrState,
      serviceAreaSummary: serviceAreaSummary,
      bio: bio,
      profileImageUrl: profileImageUrl,
      experienceSummary: experienceSummary,
      socialLinks: socialLinks.toDomain(),
      specialties: specialties
          .map((item) => item.toDomain())
          .toList(growable: false),
      portfolioItems: portfolioItems
          .map((item) => item.toDomain())
          .toList(growable: false),
      yearsOfExperience: yearsOfExperience,
      createdAt: DateTime.parse(createdAtIso),
      updatedAt: DateTime.parse(updatedAtIso),
    );
  }
}

class ArtistSocialLinkSummaryDto {
  const ArtistSocialLinkSummaryDto({
    required this.instagramHandle,
    required this.tiktokHandle,
    required this.websiteUrl,
  });

  factory ArtistSocialLinkSummaryDto.fromDomain(
    ArtistSocialLinkSummary value,
  ) {
    return ArtistSocialLinkSummaryDto(
      instagramHandle: value.instagramHandle,
      tiktokHandle: value.tiktokHandle,
      websiteUrl: value.websiteUrl,
    );
  }

  factory ArtistSocialLinkSummaryDto.fromMap(Map<String, Object?> map) {
    return ArtistSocialLinkSummaryDto(
      instagramHandle: (map['instagramHandle'] as String?) ?? '',
      tiktokHandle: (map['tiktokHandle'] as String?) ?? '',
      websiteUrl: map['websiteUrl'] as String?,
    );
  }

  final String instagramHandle;
  final String tiktokHandle;
  final String? websiteUrl;

  Map<String, Object?> toMap() => {
    'instagramHandle': instagramHandle,
    'tiktokHandle': tiktokHandle,
    'websiteUrl': websiteUrl,
  };

  ArtistSocialLinkSummary toDomain() => ArtistSocialLinkSummary(
    instagramHandle: instagramHandle,
    tiktokHandle: tiktokHandle,
    websiteUrl: websiteUrl,
  );
}

class ArtistSpecialtyTagDto {
  const ArtistSpecialtyTagDto({required this.label, required this.isSelected});

  factory ArtistSpecialtyTagDto.fromDomain(ArtistSpecialtyTag tag) {
    return ArtistSpecialtyTagDto(label: tag.label, isSelected: tag.isSelected);
  }

  factory ArtistSpecialtyTagDto.fromMap(Map<String, Object?> map) {
    return ArtistSpecialtyTagDto(
      label: (map['label'] as String?) ?? '',
      isSelected: (map['isSelected'] as bool?) ?? false,
    );
  }

  final String label;
  final bool isSelected;

  Map<String, Object?> toMap() => {'label': label, 'isSelected': isSelected};

  ArtistSpecialtyTag toDomain() =>
      ArtistSpecialtyTag(label: label, isSelected: isSelected);
}

class ArtistPortfolioItemDraftDto {
  const ArtistPortfolioItemDraftDto({
    required this.id,
    required this.title,
    required this.category,
    required this.caption,
    required this.mediaUrl,
    required this.mediaReference,
    required this.startColorValue,
    required this.endColorValue,
  });

  factory ArtistPortfolioItemDraftDto.fromDomain(
    ArtistPortfolioItemDraft item,
  ) {
    return ArtistPortfolioItemDraftDto(
      id: item.id,
      title: item.title,
      category: item.category,
      caption: item.caption,
      mediaUrl: item.mediaUrl,
      mediaReference: item.mediaReference,
      startColorValue: item.startColorValue,
      endColorValue: item.endColorValue,
    );
  }

  factory ArtistPortfolioItemDraftDto.fromMap(Map<String, Object?> map) {
    return ArtistPortfolioItemDraftDto(
      id: (map['id'] as String?) ?? '',
      title: (map['title'] as String?) ?? '',
      category: (map['category'] as String?) ?? '',
      caption: (map['caption'] as String?) ?? '',
      mediaUrl: map['mediaUrl'] as String?,
      mediaReference: map['mediaReference'] as String?,
      startColorValue: (map['startColorValue'] as int?) ?? 0,
      endColorValue: (map['endColorValue'] as int?) ?? 0,
    );
  }

  final String id;
  final String title;
  final String category;
  final String caption;
  final String? mediaUrl;
  final String? mediaReference;
  final int startColorValue;
  final int endColorValue;

  Map<String, Object?> toMap() => {
    'id': id,
    'title': title,
    'category': category,
    'caption': caption,
    'mediaUrl': mediaUrl,
    'mediaReference': mediaReference,
    'startColorValue': startColorValue,
    'endColorValue': endColorValue,
  };

  ArtistPortfolioItemDraft toDomain() => ArtistPortfolioItemDraft(
    id: id,
    title: title,
    category: category,
    caption: caption,
    mediaUrl: mediaUrl,
    mediaReference: mediaReference,
    startColorValue: startColorValue,
    endColorValue: endColorValue,
  );
}

class ArtistServicePackageDraftDto {
  const ArtistServicePackageDraftDto({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.includes,
    required this.suitableOccasions,
    required this.isActive,
  });

  factory ArtistServicePackageDraftDto.fromDomain(
    ArtistServicePackageDraft item,
  ) {
    return ArtistServicePackageDraftDto(
      id: item.id,
      title: item.title,
      description: item.description,
      price: item.price,
      durationMinutes: item.durationMinutes,
      includes: item.includes,
      suitableOccasions: item.suitableOccasions,
      isActive: item.isActive,
    );
  }

  factory ArtistServicePackageDraftDto.fromMap(Map<String, Object?> map) {
    return ArtistServicePackageDraftDto(
      id: (map['id'] as String?) ?? '',
      title: (map['title'] as String?) ?? '',
      description: (map['description'] as String?) ?? '',
      price: (map['price'] as int?) ?? 0,
      durationMinutes: (map['durationMinutes'] as int?) ?? 0,
      includes: ((map['includes'] as List<Object?>?) ?? const <Object?>[])
          .whereType<String>()
          .toList(growable: false),
      suitableOccasions:
          ((map['suitableOccasions'] as List<Object?>?) ?? const <Object?>[])
              .whereType<String>()
              .toList(growable: false),
      isActive: (map['isActive'] as bool?) ?? false,
    );
  }

  final String id;
  final String title;
  final String description;
  final int price;
  final int durationMinutes;
  final List<String> includes;
  final List<String> suitableOccasions;
  final bool isActive;

  Map<String, Object?> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'price': price,
    'durationMinutes': durationMinutes,
    'includes': includes,
    'suitableOccasions': suitableOccasions,
    'isActive': isActive,
  };

  ArtistServicePackageDraft toDomain() => ArtistServicePackageDraft(
    id: id,
    title: title,
    description: description,
    price: price,
    durationMinutes: durationMinutes,
    includes: includes,
    suitableOccasions: suitableOccasions,
    isActive: isActive,
  );
}

class ArtistAvailabilityDayDto {
  const ArtistAvailabilityDayDto({
    required this.dayKey,
    required this.dayLabel,
    required this.isAvailable,
    required this.windows,
  });

  factory ArtistAvailabilityDayDto.fromDomain(ArtistAvailabilityDay day) {
    return ArtistAvailabilityDayDto(
      dayKey: day.dayKey,
      dayLabel: day.dayLabel,
      isAvailable: day.isAvailable,
      windows: day.windows
          .map(ArtistTimeWindowDto.fromDomain)
          .toList(growable: false),
    );
  }

  factory ArtistAvailabilityDayDto.fromMap(Map<String, Object?> map) {
    return ArtistAvailabilityDayDto(
      dayKey: (map['dayKey'] as String?) ?? '',
      dayLabel: (map['dayLabel'] as String?) ?? '',
      isAvailable: (map['isAvailable'] as bool?) ?? false,
      windows: _listValue(map['windows'])
          .map(ArtistTimeWindowDto.fromMap)
          .toList(growable: false),
    );
  }

  final String dayKey;
  final String dayLabel;
  final bool isAvailable;
  final List<ArtistTimeWindowDto> windows;

  Map<String, Object?> toMap() => {
    'dayKey': dayKey,
    'dayLabel': dayLabel,
    'isAvailable': isAvailable,
    'windows': windows.map((item) => item.toMap()).toList(growable: false),
  };

  ArtistAvailabilityDay toDomain() => ArtistAvailabilityDay(
    dayKey: dayKey,
    dayLabel: dayLabel,
    isAvailable: isAvailable,
    windows: windows.map((item) => item.toDomain()).toList(growable: false),
  );
}

class ArtistTimeWindowDto {
  const ArtistTimeWindowDto({
    required this.id,
    required this.startLabel,
    required this.endLabel,
  });

  factory ArtistTimeWindowDto.fromDomain(ArtistTimeWindow window) {
    return ArtistTimeWindowDto(
      id: window.id,
      startLabel: window.startLabel,
      endLabel: window.endLabel,
    );
  }

  factory ArtistTimeWindowDto.fromMap(Map<String, Object?> map) {
    return ArtistTimeWindowDto(
      id: (map['id'] as String?) ?? '',
      startLabel: (map['startLabel'] as String?) ?? '',
      endLabel: (map['endLabel'] as String?) ?? '',
    );
  }

  final String id;
  final String startLabel;
  final String endLabel;

  Map<String, Object?> toMap() => {
    'id': id,
    'startLabel': startLabel,
    'endLabel': endLabel,
  };

  ArtistTimeWindow toDomain() =>
      ArtistTimeWindow(id: id, startLabel: startLabel, endLabel: endLabel);
}

class ArtistTravelPolicyDto {
  const ArtistTravelPolicyDto({
    required this.primaryServiceArea,
    required this.includedRadiusKm,
    required this.extraTravelFee,
    required this.maxTravelDistanceKm,
    required this.travelNotes,
  });

  factory ArtistTravelPolicyDto.fromDomain(ArtistTravelPolicy policy) {
    return ArtistTravelPolicyDto(
      primaryServiceArea: policy.primaryServiceArea,
      includedRadiusKm: policy.includedRadiusKm,
      extraTravelFee: policy.extraTravelFee,
      maxTravelDistanceKm: policy.maxTravelDistanceKm,
      travelNotes: policy.travelNotes,
    );
  }

  factory ArtistTravelPolicyDto.fromMap(Map<String, Object?> map) {
    return ArtistTravelPolicyDto(
      primaryServiceArea: (map['primaryServiceArea'] as String?) ?? '',
      includedRadiusKm: (map['includedRadiusKm'] as int?) ?? 0,
      extraTravelFee: (map['extraTravelFee'] as int?) ?? 0,
      maxTravelDistanceKm: (map['maxTravelDistanceKm'] as int?) ?? 0,
      travelNotes: (map['travelNotes'] as String?) ?? '',
    );
  }

  final String primaryServiceArea;
  final int includedRadiusKm;
  final int extraTravelFee;
  final int maxTravelDistanceKm;
  final String travelNotes;

  Map<String, Object?> toMap() => {
    'primaryServiceArea': primaryServiceArea,
    'includedRadiusKm': includedRadiusKm,
    'extraTravelFee': extraTravelFee,
    'maxTravelDistanceKm': maxTravelDistanceKm,
    'travelNotes': travelNotes,
  };

  ArtistTravelPolicy toDomain() => ArtistTravelPolicy(
    primaryServiceArea: primaryServiceArea,
    includedRadiusKm: includedRadiusKm,
    extraTravelFee: extraTravelFee,
    maxTravelDistanceKm: maxTravelDistanceKm,
    travelNotes: travelNotes,
  );
}

class ArtistVerificationDto {
  const ArtistVerificationDto({
    required this.emailVerified,
    required this.phoneVerified,
    required this.governmentIdVerified,
    required this.selfieVerified,
    required this.businessVerified,
    required this.insuranceVerified,
    required this.verificationFailureReason,
    required this.lastVerificationUpdatedAtIso,
  });

  factory ArtistVerificationDto.fromDomain(ArtistVerification verification) {
    return ArtistVerificationDto(
      emailVerified: verification.emailVerified,
      phoneVerified: verification.phoneVerified,
      governmentIdVerified: verification.governmentIdVerified,
      selfieVerified: verification.selfieVerified,
      businessVerified: verification.businessVerified,
      insuranceVerified: verification.insuranceVerified,
      verificationFailureReason: verification.verificationFailureReason,
      lastVerificationUpdatedAtIso:
          verification.lastVerificationUpdatedAt?.toIso8601String(),
    );
  }

  factory ArtistVerificationDto.fromMap(Map<String, Object?> map) {
    return ArtistVerificationDto(
      emailVerified: (map['emailVerified'] as bool?) ?? false,
      phoneVerified: (map['phoneVerified'] as bool?) ?? false,
      governmentIdVerified: (map['governmentIdVerified'] as bool?) ?? false,
      selfieVerified: (map['selfieVerified'] as bool?) ?? false,
      businessVerified: (map['businessVerified'] as bool?) ?? false,
      insuranceVerified: (map['insuranceVerified'] as bool?) ?? false,
      verificationFailureReason: map['verificationFailureReason'] as String?,
      lastVerificationUpdatedAtIso:
          map['lastVerificationUpdatedAtIso'] as String?,
    );
  }

  final bool emailVerified;
  final bool phoneVerified;
  final bool governmentIdVerified;
  final bool selfieVerified;
  final bool businessVerified;
  final bool insuranceVerified;
  final String? verificationFailureReason;
  final String? lastVerificationUpdatedAtIso;

  Map<String, Object?> toMap() => {
    'emailVerified': emailVerified,
    'phoneVerified': phoneVerified,
    'governmentIdVerified': governmentIdVerified,
    'selfieVerified': selfieVerified,
    'businessVerified': businessVerified,
    'insuranceVerified': insuranceVerified,
    'verificationFailureReason': verificationFailureReason,
    'lastVerificationUpdatedAtIso': lastVerificationUpdatedAtIso,
  };

  ArtistVerification toDomain() => ArtistVerification(
    emailVerified: emailVerified,
    phoneVerified: phoneVerified,
    governmentIdVerified: governmentIdVerified,
    selfieVerified: selfieVerified,
    businessVerified: businessVerified,
    insuranceVerified: insuranceVerified,
    verificationFailureReason: verificationFailureReason,
    lastVerificationUpdatedAt: lastVerificationUpdatedAtIso == null
        ? null
        : DateTime.parse(lastVerificationUpdatedAtIso!),
  );
}

class ArtistReviewScoresDto {
  const ArtistReviewScoresDto({
    required this.technicalSkill,
    required this.styleRange,
    required this.portfolioQuality,
    required this.professionalPresentation,
    required this.totalScore,
  });

  factory ArtistReviewScoresDto.fromDomain(ArtistReviewScores scores) {
    return ArtistReviewScoresDto(
      technicalSkill: scores.technicalSkill,
      styleRange: scores.styleRange,
      portfolioQuality: scores.portfolioQuality,
      professionalPresentation: scores.professionalPresentation,
      totalScore: scores.totalScore,
    );
  }

  factory ArtistReviewScoresDto.fromMap(Map<String, Object?> map) {
    return ArtistReviewScoresDto(
      technicalSkill: (map['technicalSkill'] as int?) ?? 0,
      styleRange: (map['styleRange'] as int?) ?? 0,
      portfolioQuality: (map['portfolioQuality'] as int?) ?? 0,
      professionalPresentation:
          (map['professionalPresentation'] as int?) ?? 0,
      totalScore: (map['totalScore'] as int?) ?? 0,
    );
  }

  final int technicalSkill;
  final int styleRange;
  final int portfolioQuality;
  final int professionalPresentation;
  final int totalScore;

  Map<String, Object?> toMap() => {
    'technicalSkill': technicalSkill,
    'styleRange': styleRange,
    'portfolioQuality': portfolioQuality,
    'professionalPresentation': professionalPresentation,
    'totalScore': totalScore,
  };

  ArtistReviewScores toDomain() => ArtistReviewScores(
    technicalSkill: technicalSkill,
    styleRange: styleRange,
    portfolioQuality: portfolioQuality,
    professionalPresentation: professionalPresentation,
    totalScore: totalScore,
  );
}

class ArtistSoftLaunchConfigDto {
  const ArtistSoftLaunchConfigDto({
    required this.isEnabled,
    required this.maxBookings,
    required this.completedBookings,
    required this.notes,
    required this.restrictedRadiusKm,
  });

  factory ArtistSoftLaunchConfigDto.fromDomain(ArtistSoftLaunchConfig config) {
    return ArtistSoftLaunchConfigDto(
      isEnabled: config.isEnabled,
      maxBookings: config.maxBookings,
      completedBookings: config.completedBookings,
      notes: config.notes,
      restrictedRadiusKm: config.restrictedRadiusKm,
    );
  }

  factory ArtistSoftLaunchConfigDto.fromMap(Map<String, Object?> map) {
    return ArtistSoftLaunchConfigDto(
      isEnabled: (map['isEnabled'] as bool?) ?? false,
      maxBookings: (map['maxBookings'] as int?) ?? 0,
      completedBookings: (map['completedBookings'] as int?) ?? 0,
      notes: (map['notes'] as String?) ?? '',
      restrictedRadiusKm: map['restrictedRadiusKm'] as int?,
    );
  }

  final bool isEnabled;
  final int maxBookings;
  final int completedBookings;
  final String notes;
  final int? restrictedRadiusKm;

  Map<String, Object?> toMap() => {
    'isEnabled': isEnabled,
    'maxBookings': maxBookings,
    'completedBookings': completedBookings,
    'notes': notes,
    'restrictedRadiusKm': restrictedRadiusKm,
  };

  ArtistSoftLaunchConfig toDomain() => ArtistSoftLaunchConfig(
    isEnabled: isEnabled,
    maxBookings: maxBookings,
    completedBookings: completedBookings,
    notes: notes,
    restrictedRadiusKm: restrictedRadiusKm,
  );
}

class ArtistOperationalMetricsDto {
  const ArtistOperationalMetricsDto({
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

  factory ArtistOperationalMetricsDto.fromDomain(
    ArtistOperationalMetrics metrics,
  ) {
    return ArtistOperationalMetricsDto(
      ratingAverage: metrics.ratingAverage,
      ratingCount: metrics.ratingCount,
      completedJobsCount: metrics.completedJobsCount,
      completionRate: metrics.completionRate,
      cancellationRate: metrics.cancellationRate,
      noShowRate: metrics.noShowRate,
      latenessRate: metrics.latenessRate,
      complaintRate: metrics.complaintRate,
      quoteResponseRate: metrics.quoteResponseRate,
      quoteResponseSpeedScore: metrics.quoteResponseSpeedScore,
      qualityScore: metrics.qualityScore,
    );
  }

  factory ArtistOperationalMetricsDto.fromMap(Map<String, Object?> map) {
    return ArtistOperationalMetricsDto(
      ratingAverage: (map['ratingAverage'] as num?)?.toDouble() ?? 0,
      ratingCount: (map['ratingCount'] as int?) ?? 0,
      completedJobsCount: (map['completedJobsCount'] as int?) ?? 0,
      completionRate: (map['completionRate'] as num?)?.toDouble() ?? 0,
      cancellationRate: (map['cancellationRate'] as num?)?.toDouble() ?? 0,
      noShowRate: (map['noShowRate'] as num?)?.toDouble() ?? 0,
      latenessRate: (map['latenessRate'] as num?)?.toDouble() ?? 0,
      complaintRate: (map['complaintRate'] as num?)?.toDouble() ?? 0,
      quoteResponseRate: (map['quoteResponseRate'] as num?)?.toDouble() ?? 0,
      quoteResponseSpeedScore:
          (map['quoteResponseSpeedScore'] as num?)?.toDouble() ?? 0,
      qualityScore: (map['qualityScore'] as int?) ?? 0,
    );
  }

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

  Map<String, Object?> toMap() => {
    'ratingAverage': ratingAverage,
    'ratingCount': ratingCount,
    'completedJobsCount': completedJobsCount,
    'completionRate': completionRate,
    'cancellationRate': cancellationRate,
    'noShowRate': noShowRate,
    'latenessRate': latenessRate,
    'complaintRate': complaintRate,
    'quoteResponseRate': quoteResponseRate,
    'quoteResponseSpeedScore': quoteResponseSpeedScore,
    'qualityScore': qualityScore,
  };

  ArtistOperationalMetrics toDomain() => ArtistOperationalMetrics(
    ratingAverage: ratingAverage,
    ratingCount: ratingCount,
    completedJobsCount: completedJobsCount,
    completionRate: completionRate,
    cancellationRate: cancellationRate,
    noShowRate: noShowRate,
    latenessRate: latenessRate,
    complaintRate: complaintRate,
    quoteResponseRate: quoteResponseRate,
    quoteResponseSpeedScore: quoteResponseSpeedScore,
    qualityScore: qualityScore,
  );
}

class ArtistApprovalScopeDto {
  const ArtistApprovalScopeDto({
    required this.approvedCategories,
    required this.rejectedCategories,
    required this.customQuoteEligibleCategories,
    required this.restrictions,
    required this.approvedBy,
    required this.approvedAtIso,
  });

  factory ArtistApprovalScopeDto.fromDomain(ArtistApprovalScope scope) {
    return ArtistApprovalScopeDto(
      approvedCategories: scope.approvedCategories,
      rejectedCategories: scope.rejectedCategories,
      customQuoteEligibleCategories: scope.customQuoteEligibleCategories,
      restrictions: scope.restrictions,
      approvedBy: scope.approvedBy,
      approvedAtIso: scope.approvedAt?.toIso8601String(),
    );
  }

  factory ArtistApprovalScopeDto.fromMap(Map<String, Object?> map) {
    return ArtistApprovalScopeDto(
      approvedCategories:
          ((map['approvedCategories'] as List<Object?>?) ?? const <Object?>[])
              .whereType<String>()
              .toList(growable: false),
      rejectedCategories:
          ((map['rejectedCategories'] as List<Object?>?) ?? const <Object?>[])
              .whereType<String>()
              .toList(growable: false),
      customQuoteEligibleCategories:
          ((map['customQuoteEligibleCategories'] as List<Object?>?) ??
                  const <Object?>[])
              .whereType<String>()
              .toList(growable: false),
      restrictions:
          ((map['restrictions'] as List<Object?>?) ?? const <Object?>[])
              .whereType<String>()
              .toList(growable: false),
      approvedBy: map['approvedBy'] as String?,
      approvedAtIso: map['approvedAtIso'] as String?,
    );
  }

  final List<String> approvedCategories;
  final List<String> rejectedCategories;
  final List<String> customQuoteEligibleCategories;
  final List<String> restrictions;
  final String? approvedBy;
  final String? approvedAtIso;

  Map<String, Object?> toMap() => {
    'approvedCategories': approvedCategories,
    'rejectedCategories': rejectedCategories,
    'customQuoteEligibleCategories': customQuoteEligibleCategories,
    'restrictions': restrictions,
    'approvedBy': approvedBy,
    'approvedAtIso': approvedAtIso,
  };

  ArtistApprovalScope toDomain() => ArtistApprovalScope(
    approvedCategories: approvedCategories,
    rejectedCategories: rejectedCategories,
    customQuoteEligibleCategories: customQuoteEligibleCategories,
    restrictions: restrictions,
    approvedBy: approvedBy,
    approvedAt: approvedAtIso == null ? null : DateTime.parse(approvedAtIso!),
  );
}

class ArtistRiskEventDto {
  const ArtistRiskEventDto({
    required this.id,
    required this.artistId,
    required this.bookingId,
    required this.eventType,
    required this.severity,
    required this.notes,
    required this.createdAtIso,
    required this.createdBy,
  });

  factory ArtistRiskEventDto.fromDomain(ArtistRiskEvent event) {
    return ArtistRiskEventDto(
      id: event.id,
      artistId: event.artistId,
      bookingId: event.bookingId,
      eventType: event.eventType.name,
      severity: event.severity.name,
      notes: event.notes,
      createdAtIso: event.createdAt.toIso8601String(),
      createdBy: event.createdBy,
    );
  }

  factory ArtistRiskEventDto.fromMap(Map<String, Object?> map) {
    return ArtistRiskEventDto(
      id: (map['id'] as String?) ?? '',
      artistId: (map['artistId'] as String?) ?? '',
      bookingId: map['bookingId'] as String?,
      eventType: (map['eventType'] as String?) ?? RiskEventType.other.name,
      severity: (map['severity'] as String?) ?? RiskSeverity.low.name,
      notes: (map['notes'] as String?) ?? '',
      createdAtIso: (map['createdAtIso'] as String?) ??
          DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      createdBy: (map['createdBy'] as String?) ?? '',
    );
  }

  final String id;
  final String artistId;
  final String? bookingId;
  final String eventType;
  final String severity;
  final String notes;
  final String createdAtIso;
  final String createdBy;

  Map<String, Object?> toMap() => {
    'id': id,
    'artistId': artistId,
    'bookingId': bookingId,
    'eventType': eventType,
    'severity': severity,
    'notes': notes,
    'createdAtIso': createdAtIso,
    'createdBy': createdBy,
  };

  ArtistRiskEvent toDomain() => ArtistRiskEvent(
    id: id,
    artistId: artistId,
    bookingId: bookingId,
    eventType: RiskEventType.values.byName(eventType),
    severity: RiskSeverity.values.byName(severity),
    notes: notes,
    createdAt: DateTime.parse(createdAtIso),
    createdBy: createdBy,
  );
}

class ArtistInternalReviewDto {
  const ArtistInternalReviewDto({
    required this.id,
    required this.artistId,
    required this.reviewStage,
    required this.scores,
    required this.decision,
    required this.notes,
    required this.reviewedBy,
    required this.createdAtIso,
  });

  factory ArtistInternalReviewDto.fromDomain(ArtistInternalReview review) {
    return ArtistInternalReviewDto(
      id: review.id,
      artistId: review.artistId,
      reviewStage: review.reviewStage.name,
      scores: ArtistReviewScoresDto.fromDomain(review.scores),
      decision: review.decision.name,
      notes: review.notes,
      reviewedBy: review.reviewedBy,
      createdAtIso: review.createdAt.toIso8601String(),
    );
  }

  factory ArtistInternalReviewDto.fromMap(Map<String, Object?> map) {
    return ArtistInternalReviewDto(
      id: (map['id'] as String?) ?? '',
      artistId: (map['artistId'] as String?) ?? '',
      reviewStage:
          (map['reviewStage'] as String?) ?? InternalReviewStage.application.name,
      scores: ArtistReviewScoresDto.fromMap(_mapValue(map['scores'])),
      decision:
          (map['decision'] as String?) ?? InternalReviewDecision.pending.name,
      notes: (map['notes'] as String?) ?? '',
      reviewedBy: (map['reviewedBy'] as String?) ?? '',
      createdAtIso: (map['createdAtIso'] as String?) ??
          DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
    );
  }

  final String id;
  final String artistId;
  final String reviewStage;
  final ArtistReviewScoresDto scores;
  final String decision;
  final String notes;
  final String reviewedBy;
  final String createdAtIso;

  Map<String, Object?> toMap() => {
    'id': id,
    'artistId': artistId,
    'reviewStage': reviewStage,
    'scores': scores.toMap(),
    'decision': decision,
    'notes': notes,
    'reviewedBy': reviewedBy,
    'createdAtIso': createdAtIso,
  };

  ArtistInternalReview toDomain() => ArtistInternalReview(
    id: id,
    artistId: artistId,
    reviewStage: InternalReviewStage.values.byName(reviewStage),
    scores: scores.toDomain(),
    decision: InternalReviewDecision.values.byName(decision),
    notes: notes,
    reviewedBy: reviewedBy,
    createdAt: DateTime.parse(createdAtIso),
  );
}

Map<String, Object?> _mapValue(Object? value) {
  if (value is Map<Object?, Object?>) {
    return value.cast<String, Object?>();
  }
  return const {};
}

Iterable<Map<String, Object?>> _listValue(Object? value) sync* {
  final list = (value as List<Object?>?) ?? const <Object?>[];
  for (final item in list.whereType<Map>()) {
    yield item.cast<String, Object?>();
  }
}

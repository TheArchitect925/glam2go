import '../domain/models/artist_management_models.dart';

const _specialties = [
  ArtistSpecialtyTag(label: 'Bridal', isSelected: true),
  ArtistSpecialtyTag(label: 'Soft Glam', isSelected: true),
  ArtistSpecialtyTag(label: 'Nikkah', isSelected: true),
  ArtistSpecialtyTag(label: 'Party Glam'),
  ArtistSpecialtyTag(label: 'Photoshoot'),
  ArtistSpecialtyTag(label: 'Formal Event'),
];

final mockArtistManagementState = ArtistManagementState(
  publicArtistId: 'aaliyah-noor',
  onboardingStep: ArtistOnboardingStep.summary,
  onboardingStatus: ArtistOnboardingStatus.active,
  profileDraft: ArtistProfileDraft(
    legalName: 'Aaliyah Noor',
    displayName: 'Noor Artistry',
    email: 'artist@glam2go.example',
    phone: '4165550198',
    city: 'Toronto',
    provinceOrState: 'Ontario',
    serviceAreaSummary: 'Downtown Toronto and select GTA bookings',
    bio:
        'On-location makeup artist focused on bridal mornings, soft glam, and polished event makeup that wears beautifully on camera.',
    profileImageUrl: 'artist-profile-noor',
    experienceSummary:
        '6 years of bridal and formal-event experience across Toronto and the GTA.',
    socialLinks: const ArtistSocialLinkSummary(
      instagramHandle: '@noorartistry',
      tiktokHandle: '@noorglam',
      websiteUrl: 'https://noorartistry.example',
    ),
    specialties: _specialties,
    portfolioItems: const [
      ArtistPortfolioItemDraft(
        id: 'portfolio-1',
        title: 'Bridal skin finish',
        category: 'Bridal',
        caption: 'Soft radiant skin with controlled glow for long event days.',
        mediaReference: 'portfolio-bridal-skin-finish',
        startColorValue: 0xFFF4DDD7,
        endColorValue: 0xFFC58E92,
      ),
      ArtistPortfolioItemDraft(
        id: 'portfolio-2',
        title: 'Nikkah soft glam',
        category: 'Nikkah',
        caption:
            'Daylight-friendly glam with rose-toned eyes and seamless skin.',
        mediaReference: 'portfolio-nikkah-soft-glam',
        startColorValue: 0xFFF0DDD0,
        endColorValue: 0xFFB98584,
      ),
    ],
    yearsOfExperience: 6,
    createdAt: DateTime(2026, 1, 14, 9, 0),
    updatedAt: DateTime(2026, 3, 25, 18, 30),
  ),
  travelPolicy: const ArtistTravelPolicy(
    primaryServiceArea: 'Downtown Toronto',
    includedRadiusKm: 18,
    extraTravelFee: 25,
    maxTravelDistanceKm: 45,
    travelNotes:
        'Early-morning travel across the GTA is available when booking timelines are confirmed in advance.',
  ),
  packages: const [
    ArtistServicePackageDraft(
      id: 'artist-bridal',
      title: 'Signature Bridal',
      description:
          'Full bridal application with skin prep, lashes, and long-wear finishing.',
      price: 320,
      durationMinutes: 120,
      includes: [
        'Skin prep and complexion design',
        'Lashes and touch-up kit',
        'Timeline coordination',
      ],
      suitableOccasions: ['Bridal', 'Formal Event'],
      isActive: true,
    ),
    ArtistServicePackageDraft(
      id: 'artist-soft-glam',
      title: 'Soft Glam Event',
      description:
          'Refined glam for receptions, family events, and polished portraits.',
      price: 190,
      durationMinutes: 85,
      includes: [
        'Soft sculpted eyes',
        'Natural skin finish',
        'Lash application',
      ],
      suitableOccasions: ['Soft Glam', 'Party Glam'],
      isActive: true,
    ),
  ],
  availabilityDays: const [
    ArtistAvailabilityDay(
      dayKey: 'mon',
      dayLabel: 'Monday',
      isAvailable: true,
      windows: [
        ArtistTimeWindow(
          id: 'mon-1',
          startLabel: '9:00 AM',
          endLabel: '2:00 PM',
        ),
      ],
    ),
    ArtistAvailabilityDay(
      dayKey: 'tue',
      dayLabel: 'Tuesday',
      isAvailable: true,
      windows: [
        ArtistTimeWindow(
          id: 'tue-1',
          startLabel: '10:00 AM',
          endLabel: '4:00 PM',
        ),
      ],
    ),
    ArtistAvailabilityDay(
      dayKey: 'wed',
      dayLabel: 'Wednesday',
      isAvailable: false,
      windows: [],
    ),
    ArtistAvailabilityDay(
      dayKey: 'thu',
      dayLabel: 'Thursday',
      isAvailable: true,
      windows: [
        ArtistTimeWindow(
          id: 'thu-1',
          startLabel: '11:00 AM',
          endLabel: '6:00 PM',
        ),
      ],
    ),
    ArtistAvailabilityDay(
      dayKey: 'fri',
      dayLabel: 'Friday',
      isAvailable: true,
      windows: [
        ArtistTimeWindow(
          id: 'fri-1',
          startLabel: '7:00 AM',
          endLabel: '1:00 PM',
        ),
      ],
    ),
    ArtistAvailabilityDay(
      dayKey: 'sat',
      dayLabel: 'Saturday',
      isAvailable: true,
      windows: [
        ArtistTimeWindow(
          id: 'sat-1',
          startLabel: '6:00 AM',
          endLabel: '3:00 PM',
        ),
      ],
    ),
    ArtistAvailabilityDay(
      dayKey: 'sun',
      dayLabel: 'Sunday',
      isAvailable: false,
      windows: [],
    ),
  ],
  bookings: const [],
  verification: ArtistVerification(
    emailVerified: true,
    phoneVerified: true,
    governmentIdVerified: true,
    selfieVerified: true,
    businessVerified: true,
    insuranceVerified: false,
    lastVerificationUpdatedAt: DateTime(2026, 3, 10, 10, 15),
  ),
  softLaunchConfig: const ArtistSoftLaunchConfig(
    isEnabled: false,
    maxBookings: 5,
    completedBookings: 5,
    notes: 'Soft launch completed successfully.',
  ),
  operationalMetrics: const ArtistOperationalMetrics(
    ratingAverage: 4.9,
    ratingCount: 21,
    completedJobsCount: 18,
    completionRate: 0.97,
    cancellationRate: 0.03,
    noShowRate: 0.0,
    latenessRate: 0.02,
    complaintRate: 0.01,
    quoteResponseRate: 0.95,
    quoteResponseSpeedScore: 88,
    qualityScore: 91,
  ),
  approvalScope: ArtistApprovalScope(
    approvedCategories: const ['Bridal', 'Soft Glam', 'Nikkah'],
    rejectedCategories: const [],
    customQuoteEligibleCategories: const ['Bridal', 'Nikkah'],
    restrictions: const ['Soft launch monitoring complete'],
    approvedBy: 'admin_ops_01',
    approvedAt: DateTime(2026, 3, 12, 14, 0),
  ),
  riskEvents: const [],
  internalReviews: const [
    ArtistInternalReview(
      id: 'review-1',
      artistId: 'aaliyah-noor',
      reviewStage: InternalReviewStage.portfolio,
      scores: ArtistReviewScores(
        technicalSkill: 5,
        styleRange: 4,
        portfolioQuality: 4,
        professionalPresentation: 4,
        totalScore: 17,
      ),
      decision: InternalReviewDecision.approved,
      notes: 'Strong bridal finish and good event range.',
      reviewedBy: 'admin_ops_01',
      createdAt: DateTime(2026, 3, 12, 12, 30),
    ),
  ],
  artistTier: ArtistTier.core,
  customQuoteEligibilityStatus: CustomQuoteEligibilityStatus.approved,
  isVerified: true,
  isAcceptingBookings: true,
  isAcceptingCustomQuotes: true,
  notificationsEnabled: true,
  businessNotificationsEnabled: true,
);

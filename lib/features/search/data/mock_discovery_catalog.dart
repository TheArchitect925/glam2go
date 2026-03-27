import '../domain/models/discovery_models.dart';

const DiscoveryCatalog mockDiscoveryCatalog = DiscoveryCatalog(
  occasions: [
    'Bridal',
    'Nikkah',
    'Party Glam',
    'Soft Glam',
    'Photoshoot',
    'Formal Event',
    'Graduation',
    'Henna / Mehndi',
  ],
  featuredArtistIds: ['aaliyah-noor', 'zoya-studio', 'emilia-hart'],
  popularPackageIds: ['bridal-signature', 'nikkah-soft-luxe', 'editorial-glow'],
  profiles: [
    ArtistProfile(
      summary: ArtistSummary(
        id: 'aaliyah-noor',
        name: 'Aaliyah Noor',
        locationLabel: 'Downtown Toronto',
        reviewSummary: ReviewSummary(
          rating: 4.9,
          reviewCount: 128,
          highlight: 'Known for calm bridal mornings and polished soft glam.',
        ),
        specialties: ['Bridal', 'Soft Glam', 'Nikkah'],
        startingPrice: 180,
        availabilityHint: 'Available this Friday and Sunday',
        travelSummary: '18 km included, travel from \$25 beyond radius',
        heroStartColorValue: 0xFFEBD1D7,
        heroEndColorValue: 0xFFB46A81,
        heroLabel: 'Signature bridal glow',
      ),
      bio:
          'Aaliyah creates refined, luminous makeup for weddings and formal celebrations. Her work leans skin-first, long-wear, and camera-ready without feeling heavy.',
      socialProof:
          'Frequently booked for bridal parties across Toronto, North York, and Mississauga.',
      trustSignals: [
        'On-location specialist',
        'Early start appointments available',
        'Skin-prep focused',
      ],
      availabilityPreview: AvailabilityPreview(
        headline: 'Good availability next 7 days',
        nextDates: ['Fri 12 Apr', 'Sun 14 Apr', 'Tue 16 Apr'],
        note: 'Final start times are confirmed in the booking flow.',
      ),
      travelPolicy: TravelPolicySummary(
        includedRadiusKm: 18,
        extraFeeFrom: 25,
        maxTravelDistanceKm: 45,
        summary:
            'Travel within central Toronto is included. Extended travel is available for events across the GTA.',
      ),
      portfolioItems: [
        PortfolioItem(
          id: 'a1',
          title: 'Modern bridal skin',
          styleLabel: 'Radiant finish',
          startColorValue: 0xFFF8E7E0,
          endColorValue: 0xFFD89BA2,
        ),
        PortfolioItem(
          id: 'a2',
          title: 'Soft nikkah glam',
          styleLabel: 'Rose gold eyes',
          startColorValue: 0xFFF0DCCF,
          endColorValue: 0xFFC69488,
        ),
        PortfolioItem(
          id: 'a3',
          title: 'Reception detail',
          styleLabel: 'Long-wear glam',
          startColorValue: 0xFFF4D9DE,
          endColorValue: 0xFFB35C76,
        ),
      ],
      packages: [
        ArtistPackage(
          id: 'bridal-signature',
          title: 'Signature Bridal',
          description:
              'A full bridal application with skin prep, lashes, and long-wear finishing for ceremony-to-reception coverage.',
          price: 320,
          durationMinutes: 120,
          includes: [
            'Skin prep and complexion design',
            'Lashes and touch-up kit',
            'Timeline coordination for bridal mornings',
          ],
          suitableFor: ['Bridal', 'Formal Event'],
          isFeatured: true,
        ),
        ArtistPackage(
          id: 'nikkah-soft-luxe',
          title: 'Nikkah Soft Luxe',
          description:
              'Elegant soft glam built for close-up photography and daylight ceremonies.',
          price: 280,
          durationMinutes: 100,
          includes: [
            'Soft sculpted eyes',
            'Natural skin finish',
            'Optional dupatta-friendly setting',
          ],
          suitableFor: ['Nikkah', 'Soft Glam'],
        ),
      ],
    ),
    ArtistProfile(
      summary: ArtistSummary(
        id: 'zoya-studio',
        name: 'Zoya Studio',
        locationLabel: 'Mississauga',
        reviewSummary: ReviewSummary(
          rating: 4.8,
          reviewCount: 94,
          highlight:
              'Reliable for glam squads, pre-event timelines, and group bookings.',
        ),
        specialties: ['Party Glam', 'Henna / Mehndi', 'Formal Event'],
        startingPrice: 140,
        availabilityHint: 'Limited Saturday spots',
        travelSummary: '20 km included, evening travel from \$30',
        heroStartColorValue: 0xFFF4D6CD,
        heroEndColorValue: 0xFF9B5664,
        heroLabel: 'Event-ready glam',
      ),
      bio:
          'Zoya balances statement glam with clean skin and strong photo payoff. Best suited for festive events, family celebrations, and glam that needs to last through the night.',
      socialProof:
          'Popular for mehndi parties and group event bookings in Peel Region.',
      trustSignals: [
        'Group booking friendly',
        'Long-wear evening looks',
        'Lash customization included',
      ],
      availabilityPreview: AvailabilityPreview(
        headline: 'Busy this week, but weekday evening slots remain',
        nextDates: ['Thu 11 Apr', 'Mon 15 Apr', 'Wed 17 Apr'],
        note: 'Weekend availability moves quickly for event season.',
      ),
      travelPolicy: TravelPolicySummary(
        includedRadiusKm: 20,
        extraFeeFrom: 30,
        maxTravelDistanceKm: 50,
        summary:
            'Mississauga and nearby service areas are covered first. Downtown and east-end requests may add a distance fee.',
      ),
      portfolioItems: [
        PortfolioItem(
          id: 'z1',
          title: 'Henna night glam',
          styleLabel: 'Statement liner',
          startColorValue: 0xFFF0D2B9,
          endColorValue: 0xFFBC6C5D,
        ),
        PortfolioItem(
          id: 'z2',
          title: 'Party glam skin',
          styleLabel: 'Full glam',
          startColorValue: 0xFFF4E0D8,
          endColorValue: 0xFFC17680,
        ),
        PortfolioItem(
          id: 'z3',
          title: 'Reception glow',
          styleLabel: 'Warm bronze',
          startColorValue: 0xFFE8C8C4,
          endColorValue: 0xFF91556F,
        ),
      ],
      packages: [
        ArtistPackage(
          id: 'party-glam-pro',
          title: 'Party Glam Pro',
          description:
              'Defined eyes, full complexion, lashes, and event-proof wear for evening occasions.',
          price: 190,
          durationMinutes: 85,
          includes: [
            'Lashes',
            'Event-proof setting finish',
            'Choice of soft or statement eye look',
          ],
          suitableFor: ['Party Glam', 'Formal Event'],
        ),
        ArtistPackage(
          id: 'mehndi-glam',
          title: 'Mehndi Glam',
          description:
              'Festive glam tuned for color, photography, and long celebrations.',
          price: 210,
          durationMinutes: 90,
          includes: [
            'Color-balanced complexion',
            'Defined eyes',
            'Touch-up essentials',
          ],
          suitableFor: ['Henna / Mehndi', 'Party Glam'],
        ),
      ],
    ),
    ArtistProfile(
      summary: ArtistSummary(
        id: 'emilia-hart',
        name: 'Emilia Hart',
        locationLabel: 'Scarborough',
        reviewSummary: ReviewSummary(
          rating: 4.9,
          reviewCount: 76,
          highlight:
              'Editorial finish with a clean, modern approach to glam and skin.',
        ),
        specialties: ['Photoshoot', 'Soft Glam', 'Graduation'],
        startingPrice: 160,
        availabilityHint: 'Open this week',
        travelSummary: '15 km included, travel from \$20 for downtown shoots',
        heroStartColorValue: 0xFFF4E6E2,
        heroEndColorValue: 0xFF8B6577,
        heroLabel: 'Editorial soft focus',
      ),
      bio:
          'Emilia is known for editorial softness, precise skin work, and polished finishes that translate beautifully on camera. Ideal for shoots, graduations, and understated event glam.',
      socialProof:
          'Often recommended for graduation portraits and studio sessions.',
      trustSignals: [
        'Editorial skin finish',
        'Natural-light friendly makeup',
        'Quick studio turnaround',
      ],
      availabilityPreview: AvailabilityPreview(
        headline: 'Strong weekday availability',
        nextDates: ['Wed 10 Apr', 'Thu 11 Apr', 'Sat 13 Apr'],
        note: 'Morning studio appointments are easiest to secure.',
      ),
      travelPolicy: TravelPolicySummary(
        includedRadiusKm: 15,
        extraFeeFrom: 20,
        maxTravelDistanceKm: 35,
        summary:
            'Scarborough bookings are prioritized, with flexible travel for shoots and campus events nearby.',
      ),
      portfolioItems: [
        PortfolioItem(
          id: 'e1',
          title: 'Studio complexion',
          styleLabel: 'Editorial skin',
          startColorValue: 0xFFF8EDE8,
          endColorValue: 0xFFC7A1A6,
        ),
        PortfolioItem(
          id: 'e2',
          title: 'Graduation glow',
          styleLabel: 'Fresh finish',
          startColorValue: 0xFFF2D6CB,
          endColorValue: 0xFF9B7C83,
        ),
        PortfolioItem(
          id: 'e3',
          title: 'Soft shoot glam',
          styleLabel: 'Camera-ready',
          startColorValue: 0xFFEBDAD8,
          endColorValue: 0xFF8E6972,
        ),
      ],
      packages: [
        ArtistPackage(
          id: 'editorial-glow',
          title: 'Editorial Glow',
          description:
              'Camera-ready skin, softly structured eyes, and polished detail for studio or location shoots.',
          price: 220,
          durationMinutes: 95,
          includes: [
            'High-definition skin prep',
            'Refined eye detailing',
            'Touch-up guidance for camera work',
          ],
          suitableFor: ['Photoshoot', 'Soft Glam'],
          isFeatured: true,
        ),
        ArtistPackage(
          id: 'grad-polish',
          title: 'Graduation Polish',
          description:
              'Balanced glam for portraits, ceremonies, and family photos with a fresh, modern finish.',
          price: 170,
          durationMinutes: 75,
          includes: [
            'Skin-focused base',
            'Natural lash enhancement',
            'Photo-friendly finish',
          ],
          suitableFor: ['Graduation', 'Soft Glam'],
        ),
      ],
    ),
    ArtistProfile(
      summary: ArtistSummary(
        id: 'sara-khalid',
        name: 'Sara Khalid',
        locationLabel: 'North York',
        reviewSummary: ReviewSummary(
          rating: 4.7,
          reviewCount: 61,
          highlight:
              'A dependable choice for classic event glam and soft formal looks.',
        ),
        specialties: ['Formal Event', 'Soft Glam', 'Bridal'],
        startingPrice: 150,
        availabilityHint: 'Best availability midweek',
        travelSummary: '16 km included, travel from \$25 outside North York',
        heroStartColorValue: 0xFFF7E4D9,
        heroEndColorValue: 0xFFAD6C6A,
        heroLabel: 'Classic event polish',
      ),
      bio:
          'Sara delivers classic glam with soft structure and flattering tones. Her approach works well for formal events, family functions, and clients who want elevated but approachable makeup.',
      socialProof:
          'Often rebooked for engagement events and family celebrations.',
      trustSignals: [
        'Soft-structure glam',
        'Comfortable for mature skin',
        'Reliable event timing',
      ],
      availabilityPreview: AvailabilityPreview(
        headline: 'Midweek bookings are easiest to secure',
        nextDates: ['Tue 09 Apr', 'Thu 11 Apr', 'Tue 16 Apr'],
        note: 'Weekend holds are released closer to the appointment date.',
      ),
      travelPolicy: TravelPolicySummary(
        includedRadiusKm: 16,
        extraFeeFrom: 25,
        maxTravelDistanceKm: 40,
        summary:
            'North York and nearby neighborhoods are included, with extra travel available for larger event bookings.',
      ),
      portfolioItems: [
        PortfolioItem(
          id: 's1',
          title: 'Formal evening glam',
          styleLabel: 'Classic glam',
          startColorValue: 0xFFF5DED6,
          endColorValue: 0xFFC08083,
        ),
        PortfolioItem(
          id: 's2',
          title: 'Soft bridal detail',
          styleLabel: 'Refined shimmer',
          startColorValue: 0xFFF1E0D8,
          endColorValue: 0xFFB46A74,
        ),
        PortfolioItem(
          id: 's3',
          title: 'Polished event skin',
          styleLabel: 'Comfort wear',
          startColorValue: 0xFFEFD6CE,
          endColorValue: 0xFF9C6570,
        ),
      ],
      packages: [
        ArtistPackage(
          id: 'formal-elegance',
          title: 'Formal Elegance',
          description:
              'A polished full-face application built for event photography, family gatherings, and long evenings.',
          price: 180,
          durationMinutes: 80,
          includes: [
            'Defined complexion',
            'Soft contour and highlight',
            'Lashes on request',
          ],
          suitableFor: ['Formal Event', 'Soft Glam'],
        ),
      ],
    ),
  ],
);

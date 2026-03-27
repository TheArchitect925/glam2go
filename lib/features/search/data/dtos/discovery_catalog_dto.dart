import '../../domain/models/discovery_models.dart';

class DiscoveryCatalogDto {
  const DiscoveryCatalogDto({
    required this.occasions,
    required this.profiles,
    required this.featuredArtistIds,
    required this.popularPackageIds,
  });

  factory DiscoveryCatalogDto.fromMap(Map<String, Object?> map) {
    return DiscoveryCatalogDto(
      occasions: (map['occasions'] as List<Object?>).whereType<String>().toList(
        growable: false,
      ),
      profiles: (map['profiles'] as List<Object?>)
          .whereType<Map<Object?, Object?>>()
          .map((item) => ArtistProfileDto.fromMap(item.cast<String, Object?>()))
          .toList(growable: false),
      featuredArtistIds: (map['featuredArtistIds'] as List<Object?>)
          .whereType<String>()
          .toList(growable: false),
      popularPackageIds: (map['popularPackageIds'] as List<Object?>)
          .whereType<String>()
          .toList(growable: false),
    );
  }

  final List<String> occasions;
  final List<ArtistProfileDto> profiles;
  final List<String> featuredArtistIds;
  final List<String> popularPackageIds;

  DiscoveryCatalog toDomain() {
    return DiscoveryCatalog(
      occasions: occasions,
      profiles: profiles.map((item) => item.toDomain()).toList(growable: false),
      featuredArtistIds: featuredArtistIds,
      popularPackageIds: popularPackageIds,
    );
  }
}

class ArtistProfileDto {
  const ArtistProfileDto({
    required this.summary,
    required this.bio,
    required this.portfolioItems,
    required this.packages,
    required this.availabilityPreview,
    required this.travelPolicy,
    required this.trustSignals,
    required this.socialProof,
  });

  factory ArtistProfileDto.fromMap(Map<String, Object?> map) {
    return ArtistProfileDto(
      summary: ArtistSummaryDto.fromMap(
        (map['summary'] as Map<Object?, Object?>).cast<String, Object?>(),
      ),
      bio: map['bio'] as String,
      portfolioItems: (map['portfolioItems'] as List<Object?>)
          .whereType<Map<Object?, Object?>>()
          .map((item) => PortfolioItemDto.fromMap(item.cast<String, Object?>()))
          .toList(growable: false),
      packages: (map['packages'] as List<Object?>)
          .whereType<Map<Object?, Object?>>()
          .map((item) => ArtistPackageDto.fromMap(item.cast<String, Object?>()))
          .toList(growable: false),
      availabilityPreview: AvailabilityPreviewDto.fromMap(
        (map['availabilityPreview'] as Map<Object?, Object?>)
            .cast<String, Object?>(),
      ),
      travelPolicy: TravelPolicySummaryDto.fromMap(
        (map['travelPolicy'] as Map<Object?, Object?>).cast<String, Object?>(),
      ),
      trustSignals: (map['trustSignals'] as List<Object?>)
          .whereType<String>()
          .toList(growable: false),
      socialProof: map['socialProof'] as String,
    );
  }

  final ArtistSummaryDto summary;
  final String bio;
  final List<PortfolioItemDto> portfolioItems;
  final List<ArtistPackageDto> packages;
  final AvailabilityPreviewDto availabilityPreview;
  final TravelPolicySummaryDto travelPolicy;
  final List<String> trustSignals;
  final String socialProof;

  ArtistProfile toDomain() {
    return ArtistProfile(
      summary: summary.toDomain(),
      bio: bio,
      portfolioItems: portfolioItems
          .map((item) => item.toDomain())
          .toList(growable: false),
      packages: packages.map((item) => item.toDomain()).toList(growable: false),
      availabilityPreview: availabilityPreview.toDomain(),
      travelPolicy: travelPolicy.toDomain(),
      trustSignals: trustSignals,
      socialProof: socialProof,
    );
  }
}

class ArtistSummaryDto {
  const ArtistSummaryDto({
    required this.id,
    required this.name,
    required this.locationLabel,
    required this.reviewSummary,
    required this.specialties,
    required this.startingPrice,
    required this.availabilityHint,
    required this.travelSummary,
    required this.heroStartColorValue,
    required this.heroEndColorValue,
    required this.heroLabel,
  });

  factory ArtistSummaryDto.fromMap(Map<String, Object?> map) {
    return ArtistSummaryDto(
      id: map['id'] as String,
      name: map['name'] as String,
      locationLabel: map['locationLabel'] as String,
      reviewSummary: ReviewSummaryDto.fromMap(
        (map['reviewSummary'] as Map<Object?, Object?>).cast<String, Object?>(),
      ),
      specialties: (map['specialties'] as List<Object?>)
          .whereType<String>()
          .toList(growable: false),
      startingPrice: map['startingPrice'] as int,
      availabilityHint: map['availabilityHint'] as String,
      travelSummary: map['travelSummary'] as String,
      heroStartColorValue: map['heroStartColorValue'] as int,
      heroEndColorValue: map['heroEndColorValue'] as int,
      heroLabel: map['heroLabel'] as String,
    );
  }

  final String id;
  final String name;
  final String locationLabel;
  final ReviewSummaryDto reviewSummary;
  final List<String> specialties;
  final int startingPrice;
  final String availabilityHint;
  final String travelSummary;
  final int heroStartColorValue;
  final int heroEndColorValue;
  final String heroLabel;

  ArtistSummary toDomain() {
    return ArtistSummary(
      id: id,
      name: name,
      locationLabel: locationLabel,
      reviewSummary: reviewSummary.toDomain(),
      specialties: specialties,
      startingPrice: startingPrice,
      availabilityHint: availabilityHint,
      travelSummary: travelSummary,
      heroStartColorValue: heroStartColorValue,
      heroEndColorValue: heroEndColorValue,
      heroLabel: heroLabel,
    );
  }
}

class ReviewSummaryDto {
  const ReviewSummaryDto({
    required this.rating,
    required this.reviewCount,
    required this.highlight,
  });

  factory ReviewSummaryDto.fromMap(Map<String, Object?> map) {
    return ReviewSummaryDto(
      rating: (map['rating'] as num).toDouble(),
      reviewCount: map['reviewCount'] as int,
      highlight: map['highlight'] as String,
    );
  }

  final double rating;
  final int reviewCount;
  final String highlight;

  ReviewSummary toDomain() {
    return ReviewSummary(
      rating: rating,
      reviewCount: reviewCount,
      highlight: highlight,
    );
  }
}

class TravelPolicySummaryDto {
  const TravelPolicySummaryDto({
    required this.includedRadiusKm,
    required this.extraFeeFrom,
    required this.maxTravelDistanceKm,
    required this.summary,
  });

  factory TravelPolicySummaryDto.fromMap(Map<String, Object?> map) {
    return TravelPolicySummaryDto(
      includedRadiusKm: map['includedRadiusKm'] as int,
      extraFeeFrom: map['extraFeeFrom'] as int,
      maxTravelDistanceKm: map['maxTravelDistanceKm'] as int,
      summary: map['summary'] as String,
    );
  }

  final int includedRadiusKm;
  final int extraFeeFrom;
  final int maxTravelDistanceKm;
  final String summary;

  TravelPolicySummary toDomain() {
    return TravelPolicySummary(
      includedRadiusKm: includedRadiusKm,
      extraFeeFrom: extraFeeFrom,
      maxTravelDistanceKm: maxTravelDistanceKm,
      summary: summary,
    );
  }
}

class AvailabilityPreviewDto {
  const AvailabilityPreviewDto({
    required this.headline,
    required this.nextDates,
    required this.note,
  });

  factory AvailabilityPreviewDto.fromMap(Map<String, Object?> map) {
    return AvailabilityPreviewDto(
      headline: map['headline'] as String,
      nextDates: (map['nextDates'] as List<Object?>).whereType<String>().toList(
        growable: false,
      ),
      note: map['note'] as String,
    );
  }

  final String headline;
  final List<String> nextDates;
  final String note;

  AvailabilityPreview toDomain() {
    return AvailabilityPreview(
      headline: headline,
      nextDates: nextDates,
      note: note,
    );
  }
}

class PortfolioItemDto {
  const PortfolioItemDto({
    required this.id,
    required this.title,
    required this.styleLabel,
    required this.startColorValue,
    required this.endColorValue,
  });

  factory PortfolioItemDto.fromMap(Map<String, Object?> map) {
    return PortfolioItemDto(
      id: map['id'] as String,
      title: map['title'] as String,
      styleLabel: map['styleLabel'] as String,
      startColorValue: map['startColorValue'] as int,
      endColorValue: map['endColorValue'] as int,
    );
  }

  final String id;
  final String title;
  final String styleLabel;
  final int startColorValue;
  final int endColorValue;

  PortfolioItem toDomain() {
    return PortfolioItem(
      id: id,
      title: title,
      styleLabel: styleLabel,
      startColorValue: startColorValue,
      endColorValue: endColorValue,
    );
  }
}

class ArtistPackageDto {
  const ArtistPackageDto({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.includes,
    required this.suitableFor,
    required this.isFeatured,
  });

  factory ArtistPackageDto.fromMap(Map<String, Object?> map) {
    return ArtistPackageDto(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      durationMinutes: map['durationMinutes'] as int,
      includes: (map['includes'] as List<Object?>).whereType<String>().toList(
        growable: false,
      ),
      suitableFor: (map['suitableFor'] as List<Object?>)
          .whereType<String>()
          .toList(growable: false),
      isFeatured: map['isFeatured'] as bool? ?? false,
    );
  }

  final String id;
  final String title;
  final String description;
  final int price;
  final int durationMinutes;
  final List<String> includes;
  final List<String> suitableFor;
  final bool isFeatured;

  ArtistPackage toDomain() {
    return ArtistPackage(
      id: id,
      title: title,
      description: description,
      price: price,
      durationMinutes: durationMinutes,
      includes: includes,
      suitableFor: suitableFor,
      isFeatured: isFeatured,
    );
  }
}

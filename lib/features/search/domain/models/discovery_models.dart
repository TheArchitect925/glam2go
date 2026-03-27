import 'package:flutter/material.dart';

@immutable
class ReviewSummary {
  const ReviewSummary({
    required this.rating,
    required this.reviewCount,
    required this.highlight,
  });

  final double rating;
  final int reviewCount;
  final String highlight;
}

@immutable
class TravelPolicySummary {
  const TravelPolicySummary({
    required this.includedRadiusKm,
    required this.extraFeeFrom,
    required this.maxTravelDistanceKm,
    required this.summary,
  });

  final int includedRadiusKm;
  final int extraFeeFrom;
  final int maxTravelDistanceKm;
  final String summary;
}

@immutable
class AvailabilityPreview {
  const AvailabilityPreview({
    required this.headline,
    required this.nextDates,
    required this.note,
  });

  final String headline;
  final List<String> nextDates;
  final String note;
}

@immutable
class PortfolioItem {
  const PortfolioItem({
    required this.id,
    required this.title,
    required this.styleLabel,
    required this.startColorValue,
    required this.endColorValue,
  });

  final String id;
  final String title;
  final String styleLabel;
  final int startColorValue;
  final int endColorValue;

  Color get startColor => Color(startColorValue);
  Color get endColor => Color(endColorValue);
}

@immutable
class ArtistPackage {
  const ArtistPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.includes,
    required this.suitableFor,
    this.isFeatured = false,
  });

  final String id;
  final String title;
  final String description;
  final int price;
  final int durationMinutes;
  final List<String> includes;
  final List<String> suitableFor;
  final bool isFeatured;
}

@immutable
class ArtistSummary {
  const ArtistSummary({
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

  final String id;
  final String name;
  final String locationLabel;
  final ReviewSummary reviewSummary;
  final List<String> specialties;
  final int startingPrice;
  final String availabilityHint;
  final String travelSummary;
  final int heroStartColorValue;
  final int heroEndColorValue;
  final String heroLabel;

  Color get heroStartColor => Color(heroStartColorValue);
  Color get heroEndColor => Color(heroEndColorValue);
}

@immutable
class ArtistProfile {
  const ArtistProfile({
    required this.summary,
    required this.bio,
    required this.portfolioItems,
    required this.packages,
    required this.availabilityPreview,
    required this.travelPolicy,
    required this.trustSignals,
    required this.socialProof,
  });

  final ArtistSummary summary;
  final String bio;
  final List<PortfolioItem> portfolioItems;
  final List<ArtistPackage> packages;
  final AvailabilityPreview availabilityPreview;
  final TravelPolicySummary travelPolicy;
  final List<String> trustSignals;
  final String socialProof;
}

@immutable
class DiscoveryCatalog {
  const DiscoveryCatalog({
    required this.occasions,
    required this.profiles,
    required this.featuredArtistIds,
    required this.popularPackageIds,
  });

  final List<String> occasions;
  final List<ArtistProfile> profiles;
  final List<String> featuredArtistIds;
  final List<String> popularPackageIds;

  List<ArtistSummary> get artistSummaries =>
      profiles.map((profile) => profile.summary).toList(growable: false);

  ArtistProfile? profileById(String artistId) {
    for (final profile in profiles) {
      if (profile.summary.id == artistId) {
        return profile;
      }
    }

    return null;
  }

  List<ArtistSummary> get featuredArtists {
    return artistSummaries
        .where((artist) => featuredArtistIds.contains(artist.id))
        .toList(growable: false);
  }

  List<ArtistPackage> get popularPackages {
    return profiles
        .expand((profile) => profile.packages)
        .where((artistPackage) => popularPackageIds.contains(artistPackage.id))
        .toList(growable: false);
  }
}

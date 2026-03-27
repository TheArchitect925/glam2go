import 'package:flutter/foundation.dart';

import '../../../search/domain/models/discovery_models.dart';

enum BookingFlowStep {
  service,
  details,
  date,
  time,
  location,
  review,
  confirmation,
}

@immutable
class SelectedServicePackage {
  const SelectedServicePackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.includes,
  });

  factory SelectedServicePackage.fromArtistPackage(
    ArtistPackage artistPackage,
  ) {
    return SelectedServicePackage(
      id: artistPackage.id,
      title: artistPackage.title,
      description: artistPackage.description,
      price: artistPackage.price,
      durationMinutes: artistPackage.durationMinutes,
      includes: artistPackage.includes,
    );
  }

  final String id;
  final String title;
  final String description;
  final int price;
  final int durationMinutes;
  final List<String> includes;
}

@immutable
class BookingEventDetails {
  const BookingEventDetails({
    required this.occasion,
    required this.partySize,
    required this.notes,
  });

  final String occasion;
  final int partySize;
  final String notes;

  BookingEventDetails copyWith({
    String? occasion,
    int? partySize,
    String? notes,
  }) {
    return BookingEventDetails(
      occasion: occasion ?? this.occasion,
      partySize: partySize ?? this.partySize,
      notes: notes ?? this.notes,
    );
  }
}

@immutable
class BookingDateSelection {
  const BookingDateSelection({required this.date, required this.label});

  final DateTime date;
  final String label;
}

@immutable
class BookingTimeSelection {
  const BookingTimeSelection({required this.label, required this.time24h});

  final String label;
  final String time24h;
}

@immutable
class BookingLocation {
  const BookingLocation({
    required this.addressLine1,
    required this.unitDetails,
    required this.cityArea,
    required this.accessNotes,
  });

  final String addressLine1;
  final String unitDetails;
  final String cityArea;
  final String accessNotes;

  String get shortLabel {
    if (addressLine1.isEmpty && cityArea.isEmpty) {
      return '';
    }

    if (cityArea.isEmpty) {
      return addressLine1;
    }

    if (addressLine1.isEmpty) {
      return cityArea;
    }

    return '$addressLine1, $cityArea';
  }
}

@immutable
class TravelFeeSummary {
  const TravelFeeSummary({
    required this.isIncluded,
    required this.locationKnown,
    required this.fee,
  });

  final bool isIncluded;
  final bool locationKnown;
  final int fee;
}

@immutable
class BookingPriceSummary {
  const BookingPriceSummary({
    required this.subtotal,
    required this.travelFee,
    required this.total,
  });

  final int subtotal;
  final int travelFee;
  final int total;
}

@immutable
class BookingConfirmationDetails {
  const BookingConfirmationDetails({
    required this.bookingId,
    required this.requestedAt,
  });

  final String bookingId;
  final DateTime requestedAt;
}

@immutable
class BookingDraft {
  const BookingDraft({
    required this.step,
    this.artistId,
    this.artistName,
    this.artistLocationLabel,
    this.artistTravelPolicy,
    this.availablePackages = const <ArtistPackage>[],
    this.selectedPackage,
    this.eventDetails,
    this.dateSelection,
    this.timeSelection,
    this.location,
    this.travelFeeSummary,
    this.priceSummary,
    this.confirmationDetails,
  });

  factory BookingDraft.initial() {
    return const BookingDraft(
      step: BookingFlowStep.service,
      priceSummary: BookingPriceSummary(subtotal: 0, travelFee: 0, total: 0),
      travelFeeSummary: TravelFeeSummary(
        isIncluded: true,
        locationKnown: false,
        fee: 0,
      ),
    );
  }

  final BookingFlowStep step;
  final String? artistId;
  final String? artistName;
  final String? artistLocationLabel;
  final TravelPolicySummary? artistTravelPolicy;
  final List<ArtistPackage> availablePackages;
  final SelectedServicePackage? selectedPackage;
  final BookingEventDetails? eventDetails;
  final BookingDateSelection? dateSelection;
  final BookingTimeSelection? timeSelection;
  final BookingLocation? location;
  final TravelFeeSummary? travelFeeSummary;
  final BookingPriceSummary? priceSummary;
  final BookingConfirmationDetails? confirmationDetails;

  bool get canContinueFromService => selectedPackage != null;
  bool get canContinueFromDetails =>
      eventDetails != null && eventDetails!.occasion.isNotEmpty;
  bool get canContinueFromDate => dateSelection != null;
  bool get canContinueFromTime => timeSelection != null;
  bool get canContinueFromLocation =>
      location != null &&
      location!.addressLine1.isNotEmpty &&
      location!.cityArea.isNotEmpty;
  bool get canReview =>
      canContinueFromService &&
      canContinueFromDetails &&
      canContinueFromDate &&
      canContinueFromTime &&
      canContinueFromLocation;

  BookingDraft copyWith({
    BookingFlowStep? step,
    String? artistId,
    String? artistName,
    String? artistLocationLabel,
    TravelPolicySummary? artistTravelPolicy,
    List<ArtistPackage>? availablePackages,
    SelectedServicePackage? selectedPackage,
    bool clearSelectedPackage = false,
    BookingEventDetails? eventDetails,
    bool clearEventDetails = false,
    BookingDateSelection? dateSelection,
    bool clearDateSelection = false,
    BookingTimeSelection? timeSelection,
    bool clearTimeSelection = false,
    BookingLocation? location,
    bool clearLocation = false,
    TravelFeeSummary? travelFeeSummary,
    BookingPriceSummary? priceSummary,
    BookingConfirmationDetails? confirmationDetails,
    bool clearConfirmationDetails = false,
  }) {
    return BookingDraft(
      step: step ?? this.step,
      artistId: artistId ?? this.artistId,
      artistName: artistName ?? this.artistName,
      artistLocationLabel: artistLocationLabel ?? this.artistLocationLabel,
      artistTravelPolicy: artistTravelPolicy ?? this.artistTravelPolicy,
      availablePackages: availablePackages ?? this.availablePackages,
      selectedPackage: clearSelectedPackage
          ? null
          : selectedPackage ?? this.selectedPackage,
      eventDetails: clearEventDetails
          ? null
          : eventDetails ?? this.eventDetails,
      dateSelection: clearDateSelection
          ? null
          : dateSelection ?? this.dateSelection,
      timeSelection: clearTimeSelection
          ? null
          : timeSelection ?? this.timeSelection,
      location: clearLocation ? null : location ?? this.location,
      travelFeeSummary: travelFeeSummary ?? this.travelFeeSummary,
      priceSummary: priceSummary ?? this.priceSummary,
      confirmationDetails: clearConfirmationDetails
          ? null
          : confirmationDetails ?? this.confirmationDetails,
    );
  }
}

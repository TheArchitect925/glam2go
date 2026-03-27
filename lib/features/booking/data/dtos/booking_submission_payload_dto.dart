import '../../../session/domain/models/session_models.dart';
import '../../domain/models/booking_models.dart';

class BookingSubmissionPayloadDto {
  const BookingSubmissionPayloadDto({
    required this.customerId,
    required this.artistId,
    required this.packageId,
    required this.eventDetails,
    required this.date,
    required this.time,
    required this.location,
    required this.travelFeeSummary,
    required this.priceSummary,
    required this.originatedAsGuest,
  });

  factory BookingSubmissionPayloadDto.fromDomain({
    required BookingDraft draft,
    required SessionUserSummary customer,
    required bool originatedAsGuest,
  }) {
    return BookingSubmissionPayloadDto(
      customerId: customer.userId,
      artistId: draft.artistId!,
      packageId: draft.selectedPackage!.id,
      eventDetails: BookingEventDetailsPayloadDto.fromDomain(
        draft.eventDetails!,
      ),
      date: draft.dateSelection!.date.toIso8601String(),
      time: draft.timeSelection!.time24h,
      location: BookingLocationPayloadDto.fromDomain(draft.location!),
      travelFeeSummary: TravelFeeSummaryPayloadDto.fromDomain(
        draft.travelFeeSummary!,
      ),
      priceSummary: BookingPriceSummaryPayloadDto.fromDomain(
        draft.priceSummary!,
      ),
      originatedAsGuest: originatedAsGuest,
    );
  }

  final String customerId;
  final String artistId;
  final String packageId;
  final BookingEventDetailsPayloadDto eventDetails;
  final String date;
  final String time;
  final BookingLocationPayloadDto location;
  final TravelFeeSummaryPayloadDto travelFeeSummary;
  final BookingPriceSummaryPayloadDto priceSummary;
  final bool originatedAsGuest;

  Map<String, Object?> toMap() {
    return {
      'customerId': customerId,
      'artistId': artistId,
      'packageId': packageId,
      'eventDetails': eventDetails.toMap(),
      'date': date,
      'time': time,
      'location': location.toMap(),
      'travelFeeSummary': travelFeeSummary.toMap(),
      'priceSummary': priceSummary.toMap(),
      'originatedAsGuest': originatedAsGuest,
    };
  }
}

class BookingEventDetailsPayloadDto {
  const BookingEventDetailsPayloadDto({
    required this.occasion,
    required this.partySize,
    required this.notes,
  });

  factory BookingEventDetailsPayloadDto.fromDomain(
    BookingEventDetails details,
  ) {
    return BookingEventDetailsPayloadDto(
      occasion: details.occasion,
      partySize: details.partySize,
      notes: details.notes,
    );
  }

  final String occasion;
  final int partySize;
  final String notes;

  Map<String, Object?> toMap() => {
    'occasion': occasion,
    'partySize': partySize,
    'notes': notes,
  };
}

class BookingLocationPayloadDto {
  const BookingLocationPayloadDto({
    required this.addressLine1,
    required this.unitDetails,
    required this.cityArea,
    required this.accessNotes,
  });

  factory BookingLocationPayloadDto.fromDomain(BookingLocation location) {
    return BookingLocationPayloadDto(
      addressLine1: location.addressLine1,
      unitDetails: location.unitDetails,
      cityArea: location.cityArea,
      accessNotes: location.accessNotes,
    );
  }

  final String addressLine1;
  final String unitDetails;
  final String cityArea;
  final String accessNotes;

  Map<String, Object?> toMap() => {
    'addressLine1': addressLine1,
    'unitDetails': unitDetails,
    'cityArea': cityArea,
    'accessNotes': accessNotes,
  };
}

class TravelFeeSummaryPayloadDto {
  const TravelFeeSummaryPayloadDto({
    required this.isIncluded,
    required this.locationKnown,
    required this.fee,
  });

  factory TravelFeeSummaryPayloadDto.fromDomain(TravelFeeSummary summary) {
    return TravelFeeSummaryPayloadDto(
      isIncluded: summary.isIncluded,
      locationKnown: summary.locationKnown,
      fee: summary.fee,
    );
  }

  final bool isIncluded;
  final bool locationKnown;
  final int fee;

  Map<String, Object?> toMap() => {
    'isIncluded': isIncluded,
    'locationKnown': locationKnown,
    'fee': fee,
  };
}

class BookingPriceSummaryPayloadDto {
  const BookingPriceSummaryPayloadDto({
    required this.subtotal,
    required this.travelFee,
    required this.total,
  });

  factory BookingPriceSummaryPayloadDto.fromDomain(
    BookingPriceSummary summary,
  ) {
    return BookingPriceSummaryPayloadDto(
      subtotal: summary.subtotal,
      travelFee: summary.travelFee,
      total: summary.total,
    );
  }

  final int subtotal;
  final int travelFee;
  final int total;

  Map<String, Object?> toMap() => {
    'subtotal': subtotal,
    'travelFee': travelFee,
    'total': total,
  };
}

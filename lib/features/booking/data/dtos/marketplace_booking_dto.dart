import '../../domain/models/booking_models.dart';
import '../../domain/models/marketplace_booking_models.dart';

class MarketplaceBookingDto {
  const MarketplaceBookingDto({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.artistId,
    required this.artistName,
    required this.packageId,
    required this.packageTitle,
    required this.status,
    required this.scheduledAtIso,
    required this.timeLabel,
    required this.location,
    required this.eventDetails,
    required this.travelFeeSummary,
    required this.priceSummary,
    required this.timeline,
    required this.requestedAtIso,
    required this.isUpcoming,
    required this.originatedAsGuest,
    required this.policySummary,
    required this.nextStepNote,
  });

  factory MarketplaceBookingDto.fromDomain(MarketplaceBookingRecord record) {
    return MarketplaceBookingDto(
      id: record.id,
      customerId: record.customerId,
      customerName: record.customerName,
      artistId: record.artistId,
      artistName: record.artistName,
      packageId: record.packageId,
      packageTitle: record.packageTitle,
      status: record.status.name,
      scheduledAtIso: record.scheduledAt.toIso8601String(),
      timeLabel: record.timeLabel,
      location: BookingLocationDto.fromDomain(record.location),
      eventDetails: BookingEventDetailsDto.fromDomain(record.eventDetails),
      travelFeeSummary: TravelFeeSummaryDto.fromDomain(record.travelFeeSummary),
      priceSummary: BookingPriceSummaryDto.fromDomain(record.priceSummary),
      timeline: record.timeline
          .map(BookingStatusTimelineEntryDto.fromDomain)
          .toList(growable: false),
      requestedAtIso: record.requestedAt.toIso8601String(),
      isUpcoming: record.isUpcoming,
      originatedAsGuest: record.originatedAsGuest,
      policySummary: record.policySummary,
      nextStepNote: record.nextStepNote,
    );
  }

  factory MarketplaceBookingDto.fromMap(Map<String, Object?> map) {
    return MarketplaceBookingDto(
      id: map['id'] as String,
      customerId: map['customerId'] as String,
      customerName: map['customerName'] as String,
      artistId: map['artistId'] as String,
      artistName: map['artistName'] as String,
      packageId: map['packageId'] as String,
      packageTitle: map['packageTitle'] as String,
      status: map['status'] as String,
      scheduledAtIso: map['scheduledAtIso'] as String,
      timeLabel: map['timeLabel'] as String,
      location: BookingLocationDto.fromMap(
        (map['location'] as Map<Object?, Object?>).cast<String, Object?>(),
      ),
      eventDetails: BookingEventDetailsDto.fromMap(
        (map['eventDetails'] as Map<Object?, Object?>).cast<String, Object?>(),
      ),
      travelFeeSummary: TravelFeeSummaryDto.fromMap(
        (map['travelFeeSummary'] as Map<Object?, Object?>)
            .cast<String, Object?>(),
      ),
      priceSummary: BookingPriceSummaryDto.fromMap(
        (map['priceSummary'] as Map<Object?, Object?>).cast<String, Object?>(),
      ),
      timeline: (map['timeline'] as List<Object?>)
          .whereType<Map>()
          .map(
            (item) => BookingStatusTimelineEntryDto.fromMap(
              item.cast<String, Object?>(),
            ),
          )
          .toList(growable: false),
      requestedAtIso: map['requestedAtIso'] as String,
      isUpcoming: map['isUpcoming'] as bool,
      originatedAsGuest: map['originatedAsGuest'] as bool,
      policySummary: map['policySummary'] as String,
      nextStepNote: map['nextStepNote'] as String,
    );
  }

  final String id;
  final String customerId;
  final String customerName;
  final String artistId;
  final String artistName;
  final String packageId;
  final String packageTitle;
  final String status;
  final String scheduledAtIso;
  final String timeLabel;
  final BookingLocationDto location;
  final BookingEventDetailsDto eventDetails;
  final TravelFeeSummaryDto travelFeeSummary;
  final BookingPriceSummaryDto priceSummary;
  final List<BookingStatusTimelineEntryDto> timeline;
  final String requestedAtIso;
  final bool isUpcoming;
  final bool originatedAsGuest;
  final String policySummary;
  final String nextStepNote;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'artistId': artistId,
      'artistName': artistName,
      'packageId': packageId,
      'packageTitle': packageTitle,
      'status': status,
      'scheduledAtIso': scheduledAtIso,
      'timeLabel': timeLabel,
      'location': location.toMap(),
      'eventDetails': eventDetails.toMap(),
      'travelFeeSummary': travelFeeSummary.toMap(),
      'priceSummary': priceSummary.toMap(),
      'timeline': timeline.map((item) => item.toMap()).toList(growable: false),
      'requestedAtIso': requestedAtIso,
      'isUpcoming': isUpcoming,
      'originatedAsGuest': originatedAsGuest,
      'policySummary': policySummary,
      'nextStepNote': nextStepNote,
    };
  }

  MarketplaceBookingRecord toDomain() {
    return MarketplaceBookingRecord(
      id: id,
      customerId: customerId,
      customerName: customerName,
      artistId: artistId,
      artistName: artistName,
      packageId: packageId,
      packageTitle: packageTitle,
      status: BookingLifecycleStatus.values.byName(status),
      scheduledAt: DateTime.parse(scheduledAtIso),
      timeLabel: timeLabel,
      location: location.toDomain(),
      eventDetails: eventDetails.toDomain(),
      travelFeeSummary: travelFeeSummary.toDomain(),
      priceSummary: priceSummary.toDomain(),
      timeline: timeline.map((item) => item.toDomain()).toList(growable: false),
      requestedAt: DateTime.parse(requestedAtIso),
      isUpcoming: isUpcoming,
      originatedAsGuest: originatedAsGuest,
      policySummary: policySummary,
      nextStepNote: nextStepNote,
    );
  }
}

class BookingLocationDto {
  const BookingLocationDto({
    required this.addressLine1,
    required this.unitDetails,
    required this.cityArea,
    required this.accessNotes,
  });

  factory BookingLocationDto.fromDomain(BookingLocation location) {
    return BookingLocationDto(
      addressLine1: location.addressLine1,
      unitDetails: location.unitDetails,
      cityArea: location.cityArea,
      accessNotes: location.accessNotes,
    );
  }

  factory BookingLocationDto.fromMap(Map<String, Object?> map) {
    return BookingLocationDto(
      addressLine1: map['addressLine1'] as String,
      unitDetails: map['unitDetails'] as String,
      cityArea: map['cityArea'] as String,
      accessNotes: map['accessNotes'] as String,
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

  BookingLocation toDomain() => BookingLocation(
    addressLine1: addressLine1,
    unitDetails: unitDetails,
    cityArea: cityArea,
    accessNotes: accessNotes,
  );
}

class BookingEventDetailsDto {
  const BookingEventDetailsDto({
    required this.occasion,
    required this.partySize,
    required this.notes,
  });

  factory BookingEventDetailsDto.fromDomain(BookingEventDetails details) {
    return BookingEventDetailsDto(
      occasion: details.occasion,
      partySize: details.partySize,
      notes: details.notes,
    );
  }

  factory BookingEventDetailsDto.fromMap(Map<String, Object?> map) {
    return BookingEventDetailsDto(
      occasion: map['occasion'] as String,
      partySize: map['partySize'] as int,
      notes: map['notes'] as String,
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

  BookingEventDetails toDomain() => BookingEventDetails(
    occasion: occasion,
    partySize: partySize,
    notes: notes,
  );
}

class TravelFeeSummaryDto {
  const TravelFeeSummaryDto({
    required this.isIncluded,
    required this.locationKnown,
    required this.fee,
  });

  factory TravelFeeSummaryDto.fromDomain(TravelFeeSummary summary) {
    return TravelFeeSummaryDto(
      isIncluded: summary.isIncluded,
      locationKnown: summary.locationKnown,
      fee: summary.fee,
    );
  }

  factory TravelFeeSummaryDto.fromMap(Map<String, Object?> map) {
    return TravelFeeSummaryDto(
      isIncluded: map['isIncluded'] as bool,
      locationKnown: map['locationKnown'] as bool,
      fee: map['fee'] as int,
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

  TravelFeeSummary toDomain() => TravelFeeSummary(
    isIncluded: isIncluded,
    locationKnown: locationKnown,
    fee: fee,
  );
}

class BookingPriceSummaryDto {
  const BookingPriceSummaryDto({
    required this.subtotal,
    required this.travelFee,
    required this.total,
  });

  factory BookingPriceSummaryDto.fromDomain(BookingPriceSummary summary) {
    return BookingPriceSummaryDto(
      subtotal: summary.subtotal,
      travelFee: summary.travelFee,
      total: summary.total,
    );
  }

  factory BookingPriceSummaryDto.fromMap(Map<String, Object?> map) {
    return BookingPriceSummaryDto(
      subtotal: map['subtotal'] as int,
      travelFee: map['travelFee'] as int,
      total: map['total'] as int,
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

  BookingPriceSummary toDomain() => BookingPriceSummary(
    subtotal: subtotal,
    travelFee: travelFee,
    total: total,
  );
}

class BookingStatusTimelineEntryDto {
  const BookingStatusTimelineEntryDto({
    required this.status,
    required this.occurredAtIso,
    required this.note,
  });

  factory BookingStatusTimelineEntryDto.fromDomain(
    BookingStatusTimelineEntry entry,
  ) {
    return BookingStatusTimelineEntryDto(
      status: entry.status.name,
      occurredAtIso: entry.occurredAt.toIso8601String(),
      note: entry.note,
    );
  }

  factory BookingStatusTimelineEntryDto.fromMap(Map<String, Object?> map) {
    return BookingStatusTimelineEntryDto(
      status: map['status'] as String,
      occurredAtIso: map['occurredAtIso'] as String,
      note: map['note'] as String,
    );
  }

  final String status;
  final String occurredAtIso;
  final String note;

  Map<String, Object?> toMap() => {
    'status': status,
    'occurredAtIso': occurredAtIso,
    'note': note,
  };

  BookingStatusTimelineEntry toDomain() => BookingStatusTimelineEntry(
    status: BookingLifecycleStatus.values.byName(status),
    occurredAt: DateTime.parse(occurredAtIso),
    note: note,
  );
}

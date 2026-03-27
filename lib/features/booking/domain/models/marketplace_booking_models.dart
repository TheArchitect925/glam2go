import 'package:flutter/foundation.dart';

import 'booking_models.dart';

enum BookingLifecycleStatus {
  pendingArtistResponse,
  accepted,
  declined,
  cancelled,
  completed,
}

enum BookingRequestDecision { accept, decline }

@immutable
class BookingStatusTimelineEntry {
  const BookingStatusTimelineEntry({
    required this.status,
    required this.occurredAt,
    required this.note,
  });

  final BookingLifecycleStatus status;
  final DateTime occurredAt;
  final String note;
}

@immutable
class MarketplaceBookingRecord {
  const MarketplaceBookingRecord({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.artistId,
    required this.artistName,
    required this.packageId,
    required this.packageTitle,
    required this.status,
    required this.scheduledAt,
    required this.timeLabel,
    required this.location,
    required this.eventDetails,
    required this.travelFeeSummary,
    required this.priceSummary,
    required this.timeline,
    required this.requestedAt,
    required this.isUpcoming,
    required this.originatedAsGuest,
    required this.policySummary,
    required this.nextStepNote,
  });

  final String id;
  final String customerId;
  final String customerName;
  final String artistId;
  final String artistName;
  final String packageId;
  final String packageTitle;
  final BookingLifecycleStatus status;
  final DateTime scheduledAt;
  final String timeLabel;
  final BookingLocation location;
  final BookingEventDetails eventDetails;
  final TravelFeeSummary travelFeeSummary;
  final BookingPriceSummary priceSummary;
  final List<BookingStatusTimelineEntry> timeline;
  final DateTime requestedAt;
  final bool isUpcoming;
  final bool originatedAsGuest;
  final String policySummary;
  final String nextStepNote;

  MarketplaceBookingRecord copyWith({
    BookingLifecycleStatus? status,
    List<BookingStatusTimelineEntry>? timeline,
    String? nextStepNote,
    String? policySummary,
    bool? isUpcoming,
  }) {
    return MarketplaceBookingRecord(
      id: id,
      customerId: customerId,
      customerName: customerName,
      artistId: artistId,
      artistName: artistName,
      packageId: packageId,
      packageTitle: packageTitle,
      status: status ?? this.status,
      scheduledAt: scheduledAt,
      timeLabel: timeLabel,
      location: location,
      eventDetails: eventDetails,
      travelFeeSummary: travelFeeSummary,
      priceSummary: priceSummary,
      timeline: timeline ?? this.timeline,
      requestedAt: requestedAt,
      isUpcoming: isUpcoming ?? this.isUpcoming,
      originatedAsGuest: originatedAsGuest,
      policySummary: policySummary ?? this.policySummary,
      nextStepNote: nextStepNote ?? this.nextStepNote,
    );
  }
}

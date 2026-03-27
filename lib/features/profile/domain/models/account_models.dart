import 'package:flutter/foundation.dart';

import '../../../booking/domain/models/booking_models.dart';
import '../../../booking/domain/models/marketplace_booking_models.dart';

@immutable
class CustomerBookingDetails {
  const CustomerBookingDetails({
    required this.id,
    required this.artistId,
    required this.artistName,
    required this.packageTitle,
    required this.status,
    required this.scheduledAt,
    required this.timeLabel,
    required this.isUpcoming,
    required this.location,
    required this.eventDetails,
    required this.travelFeeSummary,
    required this.priceSummary,
    required this.nextStepNote,
    required this.policySummary,
    required this.timeline,
  });

  final String id;
  final String artistId;
  final String artistName;
  final String packageTitle;
  final BookingLifecycleStatus status;
  final DateTime scheduledAt;
  final String timeLabel;
  final bool isUpcoming;
  final BookingLocation location;
  final BookingEventDetails eventDetails;
  final TravelFeeSummary travelFeeSummary;
  final BookingPriceSummary priceSummary;
  final String nextStepNote;
  final String policySummary;
  final List<BookingStatusTimelineEntry> timeline;
}

@immutable
class SavedAddress {
  const SavedAddress({
    required this.id,
    required this.label,
    required this.addressLine1,
    required this.unitDetails,
    required this.cityArea,
    required this.accessNotes,
    required this.isDefault,
  });

  final String id;
  final String label;
  final String addressLine1;
  final String unitDetails;
  final String cityArea;
  final String accessNotes;
  final bool isDefault;

  String get shortLabel => '$addressLine1, $cityArea';

  SavedAddress copyWith({
    String? id,
    String? label,
    String? addressLine1,
    String? unitDetails,
    String? cityArea,
    String? accessNotes,
    bool? isDefault,
  }) {
    return SavedAddress(
      id: id ?? this.id,
      label: label ?? this.label,
      addressLine1: addressLine1 ?? this.addressLine1,
      unitDetails: unitDetails ?? this.unitDetails,
      cityArea: cityArea ?? this.cityArea,
      accessNotes: accessNotes ?? this.accessNotes,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

@immutable
class NotificationPreferences {
  const NotificationPreferences({
    required this.bookingUpdates,
    required this.artistResponses,
    required this.reminders,
    required this.promotions,
  });

  final bool bookingUpdates;
  final bool artistResponses;
  final bool reminders;
  final bool promotions;

  NotificationPreferences copyWith({
    bool? bookingUpdates,
    bool? artistResponses,
    bool? reminders,
    bool? promotions,
  }) {
    return NotificationPreferences(
      bookingUpdates: bookingUpdates ?? this.bookingUpdates,
      artistResponses: artistResponses ?? this.artistResponses,
      reminders: reminders ?? this.reminders,
      promotions: promotions ?? this.promotions,
    );
  }
}

@immutable
class UserPreferences {
  const UserPreferences({
    required this.preferredArea,
    required this.preferredOccasions,
    required this.communicationPreference,
    required this.notificationPreferences,
  });

  final String preferredArea;
  final List<String> preferredOccasions;
  final String communicationPreference;
  final NotificationPreferences notificationPreferences;

  UserPreferences copyWith({
    String? preferredArea,
    List<String>? preferredOccasions,
    String? communicationPreference,
    NotificationPreferences? notificationPreferences,
  }) {
    return UserPreferences(
      preferredArea: preferredArea ?? this.preferredArea,
      preferredOccasions: preferredOccasions ?? this.preferredOccasions,
      communicationPreference:
          communicationPreference ?? this.communicationPreference,
      notificationPreferences:
          notificationPreferences ?? this.notificationPreferences,
    );
  }
}

@immutable
class CustomerProfile {
  const CustomerProfile({
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.memberSinceLabel,
  });

  final String displayName;
  final String email;
  final String phoneNumber;
  final String memberSinceLabel;

  CustomerProfile copyWith({
    String? displayName,
    String? email,
    String? phoneNumber,
    String? memberSinceLabel,
  }) {
    return CustomerProfile(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      memberSinceLabel: memberSinceLabel ?? this.memberSinceLabel,
    );
  }
}

@immutable
class PolicySummaryItem {
  const PolicySummaryItem({
    required this.id,
    required this.title,
    required this.summary,
  });

  final String id;
  final String title;
  final String summary;
}

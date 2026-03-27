import '../../domain/models/account_models.dart';

class CustomerProfileDto {
  const CustomerProfileDto({
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.memberSinceLabel,
  });

  factory CustomerProfileDto.fromDomain(CustomerProfile profile) {
    return CustomerProfileDto(
      displayName: profile.displayName,
      email: profile.email,
      phoneNumber: profile.phoneNumber,
      memberSinceLabel: profile.memberSinceLabel,
    );
  }

  factory CustomerProfileDto.fromMap(Map<String, Object?> map) {
    return CustomerProfileDto(
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      memberSinceLabel: map['memberSinceLabel'] as String,
    );
  }

  final String displayName;
  final String email;
  final String phoneNumber;
  final String memberSinceLabel;

  Map<String, Object?> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'memberSinceLabel': memberSinceLabel,
    };
  }

  CustomerProfile toDomain() {
    return CustomerProfile(
      displayName: displayName,
      email: email,
      phoneNumber: phoneNumber,
      memberSinceLabel: memberSinceLabel,
    );
  }
}

class UserPreferencesDto {
  const UserPreferencesDto({
    required this.preferredArea,
    required this.preferredOccasions,
    required this.communicationPreference,
    required this.notificationPreferences,
  });

  factory UserPreferencesDto.fromDomain(UserPreferences preferences) {
    return UserPreferencesDto(
      preferredArea: preferences.preferredArea,
      preferredOccasions: preferences.preferredOccasions,
      communicationPreference: preferences.communicationPreference,
      notificationPreferences: NotificationPreferencesDto.fromDomain(
        preferences.notificationPreferences,
      ),
    );
  }

  factory UserPreferencesDto.fromMap(Map<String, Object?> map) {
    return UserPreferencesDto(
      preferredArea: map['preferredArea'] as String,
      preferredOccasions: (map['preferredOccasions'] as List<Object?>)
          .whereType<String>()
          .toList(growable: false),
      communicationPreference: map['communicationPreference'] as String,
      notificationPreferences: NotificationPreferencesDto.fromMap(
        (map['notificationPreferences'] as Map<Object?, Object?>)
            .cast<String, Object?>(),
      ),
    );
  }

  final String preferredArea;
  final List<String> preferredOccasions;
  final String communicationPreference;
  final NotificationPreferencesDto notificationPreferences;

  Map<String, Object?> toMap() {
    return {
      'preferredArea': preferredArea,
      'preferredOccasions': preferredOccasions,
      'communicationPreference': communicationPreference,
      'notificationPreferences': notificationPreferences.toMap(),
    };
  }

  UserPreferences toDomain() {
    return UserPreferences(
      preferredArea: preferredArea,
      preferredOccasions: preferredOccasions,
      communicationPreference: communicationPreference,
      notificationPreferences: notificationPreferences.toDomain(),
    );
  }
}

class NotificationPreferencesDto {
  const NotificationPreferencesDto({
    required this.bookingUpdates,
    required this.artistResponses,
    required this.reminders,
    required this.promotions,
  });

  factory NotificationPreferencesDto.fromDomain(
    NotificationPreferences preferences,
  ) {
    return NotificationPreferencesDto(
      bookingUpdates: preferences.bookingUpdates,
      artistResponses: preferences.artistResponses,
      reminders: preferences.reminders,
      promotions: preferences.promotions,
    );
  }

  factory NotificationPreferencesDto.fromMap(Map<String, Object?> map) {
    return NotificationPreferencesDto(
      bookingUpdates: map['bookingUpdates'] as bool,
      artistResponses: map['artistResponses'] as bool,
      reminders: map['reminders'] as bool,
      promotions: map['promotions'] as bool,
    );
  }

  final bool bookingUpdates;
  final bool artistResponses;
  final bool reminders;
  final bool promotions;

  Map<String, Object?> toMap() {
    return {
      'bookingUpdates': bookingUpdates,
      'artistResponses': artistResponses,
      'reminders': reminders,
      'promotions': promotions,
    };
  }

  NotificationPreferences toDomain() {
    return NotificationPreferences(
      bookingUpdates: bookingUpdates,
      artistResponses: artistResponses,
      reminders: reminders,
      promotions: promotions,
    );
  }
}

class SavedAddressDto {
  const SavedAddressDto({
    required this.id,
    required this.label,
    required this.addressLine1,
    required this.unitDetails,
    required this.cityArea,
    required this.accessNotes,
    required this.isDefault,
  });

  factory SavedAddressDto.fromDomain(SavedAddress address) {
    return SavedAddressDto(
      id: address.id,
      label: address.label,
      addressLine1: address.addressLine1,
      unitDetails: address.unitDetails,
      cityArea: address.cityArea,
      accessNotes: address.accessNotes,
      isDefault: address.isDefault,
    );
  }

  factory SavedAddressDto.fromMap(Map<String, Object?> map) {
    return SavedAddressDto(
      id: map['id'] as String,
      label: map['label'] as String,
      addressLine1: map['addressLine1'] as String,
      unitDetails: map['unitDetails'] as String,
      cityArea: map['cityArea'] as String,
      accessNotes: map['accessNotes'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }

  final String id;
  final String label;
  final String addressLine1;
  final String unitDetails;
  final String cityArea;
  final String accessNotes;
  final bool isDefault;

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'label': label,
      'addressLine1': addressLine1,
      'unitDetails': unitDetails,
      'cityArea': cityArea,
      'accessNotes': accessNotes,
      'isDefault': isDefault,
    };
  }

  SavedAddress toDomain() {
    return SavedAddress(
      id: id,
      label: label,
      addressLine1: addressLine1,
      unitDetails: unitDetails,
      cityArea: cityArea,
      accessNotes: accessNotes,
      isDefault: isDefault,
    );
  }
}

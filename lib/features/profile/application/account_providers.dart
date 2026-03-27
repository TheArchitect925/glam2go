import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatters.dart';
import '../../booking/application/marketplace_booking_providers.dart';
import '../../booking/domain/models/booking_models.dart';
import '../../booking/domain/models/marketplace_booking_models.dart';
import '../../search/application/discovery_providers.dart';
import '../../search/domain/models/discovery_models.dart';
import '../data/local_account_storage.dart';
import '../data/mock_account_data.dart';
import '../data/repositories/local_account_repository.dart';
import '../domain/models/account_models.dart';
import '../domain/repositories/account_repository.dart';

final localAccountStorageProvider = Provider<LocalAccountStorage>((ref) {
  return const LocalAccountStorage();
});

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return LocalAccountRepository(ref.watch(localAccountStorageProvider));
});

final customerProfileProvider =
    NotifierProvider<CustomerProfileController, CustomerProfile>(
      CustomerProfileController.new,
    );

final userPreferencesProvider =
    NotifierProvider<UserPreferencesController, UserPreferences>(
      UserPreferencesController.new,
    );

final favoriteArtistIdsProvider =
    NotifierProvider<FavoriteArtistsController, Set<String>>(
      FavoriteArtistsController.new,
    );

final savedAddressesProvider =
    NotifierProvider<SavedAddressesController, List<SavedAddress>>(
      SavedAddressesController.new,
    );

final policySummaryItemsProvider = Provider<List<PolicySummaryItem>>((ref) {
  return ref.watch(accountRepositoryProvider).getPolicySummaryItems();
});

final favoriteArtistsProvider = Provider<List<ArtistSummary>>((ref) {
  final favoriteIds = ref.watch(favoriteArtistIdsProvider);
  final artists = ref.watch(allArtistSummariesProvider).valueOrNull ?? const [];

  return artists
      .where((artist) => favoriteIds.contains(artist.id))
      .toList(growable: false);
});

final bookingsProvider = Provider<AsyncValue<List<CustomerBookingDetails>>>((
  ref,
) {
  return ref
      .watch(currentCustomerMarketplaceBookingsProvider)
      .whenData(
        (records) =>
            records.map(_toCustomerBookingDetails).toList(growable: false),
      );
});

final upcomingBookingsProvider =
    Provider<AsyncValue<List<CustomerBookingDetails>>>((ref) {
      return ref.watch(bookingsProvider).whenData((bookings) {
        final upcoming = bookings
            .where((booking) => booking.isUpcoming)
            .toList();
        upcoming.sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
        return upcoming;
      });
    });

final pastBookingsProvider = Provider<AsyncValue<List<CustomerBookingDetails>>>(
  (ref) {
    return ref.watch(bookingsProvider).whenData((bookings) {
      final past = bookings.where((booking) => !booking.isUpcoming).toList();
      past.sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
      return past;
    });
  },
);

final customerBookingByIdProvider =
    Provider.family<AsyncValue<CustomerBookingDetails?>, String>((
      ref,
      bookingId,
    ) {
      return ref.watch(bookingsProvider).whenData((bookings) {
        for (final booking in bookings) {
          if (booking.id == bookingId) {
            return booking;
          }
        }
        return null;
      });
    });

final defaultSavedAddressProvider = Provider<SavedAddress?>((ref) {
  final addresses = ref.watch(savedAddressesProvider);
  for (final address in addresses) {
    if (address.isDefault) {
      return address;
    }
  }

  return addresses.isEmpty ? null : addresses.first;
});

class CustomerProfileController extends Notifier<CustomerProfile> {
  @override
  CustomerProfile build() {
    Future.microtask(_restore);
    return mockCustomerProfile;
  }

  void updateProfile({
    required String displayName,
    required String email,
    required String phoneNumber,
  }) {
    state = state.copyWith(
      displayName: displayName.trim(),
      email: email.trim(),
      phoneNumber: phoneNumber.trim(),
    );
    _persist();
  }

  void applyAuthProfile({required String displayName, required String email}) {
    state = state.copyWith(
      displayName: displayName.trim(),
      email: email.trim(),
    );
    _persist();
  }

  Future<void> _restore() async {
    final restored = await ref.read(accountRepositoryProvider).loadProfile();
    if (restored.dataOrNull != null) {
      state = restored.dataOrNull ?? state;
    }
  }

  void _persist() {
    unawaited(ref.read(accountRepositoryProvider).saveProfile(state));
  }
}

class UserPreferencesController extends Notifier<UserPreferences> {
  @override
  UserPreferences build() {
    Future.microtask(_restore);
    return mockUserPreferences;
  }

  void setBookingUpdates(bool value) {
    state = state.copyWith(
      notificationPreferences: state.notificationPreferences.copyWith(
        bookingUpdates: value,
      ),
    );
    _persist();
  }

  void setArtistResponses(bool value) {
    state = state.copyWith(
      notificationPreferences: state.notificationPreferences.copyWith(
        artistResponses: value,
      ),
    );
    _persist();
  }

  void setReminders(bool value) {
    state = state.copyWith(
      notificationPreferences: state.notificationPreferences.copyWith(
        reminders: value,
      ),
    );
    _persist();
  }

  void setPromotions(bool value) {
    state = state.copyWith(
      notificationPreferences: state.notificationPreferences.copyWith(
        promotions: value,
      ),
    );
    _persist();
  }

  Future<void> _restore() async {
    final restored = await ref
        .read(accountRepositoryProvider)
        .loadPreferences();
    if (restored.dataOrNull != null) {
      state = restored.dataOrNull!;
    }
  }

  void _persist() {
    unawaited(ref.read(accountRepositoryProvider).savePreferences(state));
  }
}

class FavoriteArtistsController extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    Future.microtask(_restore);
    return {...mockFavoriteArtistIds};
  }

  void toggle(String artistId) {
    final updated = {...state};
    if (updated.contains(artistId)) {
      updated.remove(artistId);
    } else {
      updated.add(artistId);
    }
    state = updated;
    _persist();
  }

  Future<void> _restore() async {
    final restored = await ref
        .read(accountRepositoryProvider)
        .loadFavoriteArtistIds();
    if (restored.dataOrNull != null) {
      state = restored.dataOrNull!;
    }
  }

  void _persist() {
    unawaited(ref.read(accountRepositoryProvider).saveFavoriteArtistIds(state));
  }
}

class SavedAddressesController extends Notifier<List<SavedAddress>> {
  @override
  List<SavedAddress> build() {
    Future.microtask(_restore);
    return mockSavedAddresses;
  }

  void setDefault(String addressId) {
    state = [
      for (final address in state)
        address.copyWith(isDefault: address.id == addressId),
    ];
    _persist();
  }

  Future<void> _restore() async {
    final restored = await ref
        .read(accountRepositoryProvider)
        .loadSavedAddresses();
    if (restored.dataOrNull != null) {
      state = restored.dataOrNull!;
    }
  }

  void _persist() {
    unawaited(ref.read(accountRepositoryProvider).saveSavedAddresses(state));
  }
}

String formatBookingSchedule(CustomerBookingDetails booking) {
  return '${formatLongDate(booking.scheduledAt)} • ${booking.timeLabel}';
}

BookingLocation toBookingLocation(SavedAddress address) {
  return BookingLocation(
    addressLine1: address.addressLine1,
    unitDetails: address.unitDetails,
    cityArea: address.cityArea,
    accessNotes: address.accessNotes,
  );
}

CustomerBookingDetails _toCustomerBookingDetails(
  MarketplaceBookingRecord record,
) {
  return CustomerBookingDetails(
    id: record.id,
    artistId: record.artistId,
    artistName: record.artistName,
    packageTitle: record.packageTitle,
    status: record.status,
    scheduledAt: record.scheduledAt,
    timeLabel: record.timeLabel,
    isUpcoming:
        record.isUpcoming &&
        record.status != BookingLifecycleStatus.completed &&
        record.status != BookingLifecycleStatus.cancelled,
    location: record.location,
    eventDetails: record.eventDetails,
    travelFeeSummary: record.travelFeeSummary,
    priceSummary: record.priceSummary,
    nextStepNote: record.nextStepNote,
    policySummary: record.policySummary,
    timeline: record.timeline,
  );
}

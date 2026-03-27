import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalMarketplaceBookingStorage {
  const LocalMarketplaceBookingStorage();

  static const _bookingsKey = 'glam2go.marketplace_bookings.v1';

  Future<List<Map<String, Object?>>?> loadBookings() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_bookingsKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      return null;
    }

    return decoded
        .whereType<Map>()
        .map((item) => item.cast<String, Object?>())
        .toList(growable: false);
  }

  Future<void> saveBookings(List<Map<String, Object?>> records) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_bookingsKey, jsonEncode(records));
  }
}

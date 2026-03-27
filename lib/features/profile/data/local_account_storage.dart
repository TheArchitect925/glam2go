import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'dtos/account_storage_dto.dart';

class LocalAccountStorage {
  const LocalAccountStorage();

  static const _profileKey = 'glam2go.customer_profile.v1';
  static const _preferencesKey = 'glam2go.customer_preferences.v1';
  static const _favoriteIdsKey = 'glam2go.favorite_artist_ids.v1';
  static const _savedAddressesKey = 'glam2go.saved_addresses.v1';

  Future<CustomerProfileDto?> loadProfile() async {
    final map = await _loadJsonMap(_profileKey);
    if (map == null) {
      return null;
    }

    return CustomerProfileDto.fromMap(map);
  }

  Future<void> saveProfile(CustomerProfileDto profile) async {
    await _saveJsonMap(_profileKey, profile.toMap());
  }

  Future<UserPreferencesDto?> loadPreferences() async {
    final map = await _loadJsonMap(_preferencesKey);
    if (map == null) {
      return null;
    }

    return UserPreferencesDto.fromMap(map);
  }

  Future<void> savePreferences(UserPreferencesDto preferences) async {
    await _saveJsonMap(_preferencesKey, preferences.toMap());
  }

  Future<Set<String>?> loadFavoriteArtistIds() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(_favoriteIdsKey)?.toSet();
  }

  Future<void> saveFavoriteArtistIds(Set<String> values) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(_favoriteIdsKey, values.toList());
  }

  Future<List<SavedAddressDto>?> loadSavedAddresses() async {
    final map = await _loadJsonMap(_savedAddressesKey);
    final items = map?['items'];
    if (items is! List) {
      return null;
    }

    return items
        .whereType<Map>()
        .map((item) => SavedAddressDto.fromMap(item.cast<String, Object?>()))
        .toList(growable: false);
  }

  Future<void> saveSavedAddresses(List<SavedAddressDto> addresses) async {
    await _saveJsonMap(_savedAddressesKey, {
      'items': [for (final address in addresses) address.toMap()],
    });
  }

  Future<Map<String, dynamic>?> _loadJsonMap(String key) async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(key);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(raw);
    return decoded is Map<String, dynamic> ? decoded : null;
  }

  Future<void> _saveJsonMap(String key, Map<String, Object?> map) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, jsonEncode(map));
  }
}

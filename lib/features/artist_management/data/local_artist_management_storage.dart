import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalArtistManagementStorage {
  const LocalArtistManagementStorage();

  static const _stateKey = 'glam2go.artist_management_state.v1';

  Future<Map<String, Object?>?> loadState() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_stateKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    return decoded;
  }

  Future<void> saveState(Map<String, Object?> state) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_stateKey, jsonEncode(state));
  }
}

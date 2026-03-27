import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'dtos/session_storage_dto.dart';

class LocalSessionStorage {
  const LocalSessionStorage();

  static const _sessionKey = 'glam2go.session_state.v1';

  Future<SessionStorageDto?> load() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_sessionKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    return SessionStorageDto.fromMap(decoded);
  }

  Future<void> save(SessionStorageDto state) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_sessionKey, jsonEncode(state.toMap()));
  }

  Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_sessionKey);
  }
}

import 'package:flutter/foundation.dart';

enum AppFailureType {
  storage,
  network,
  serialization,
  validation,
  unauthorized,
  unknown,
}

@immutable
class AppFailure {
  const AppFailure({required this.type, required this.message, this.cause});

  final AppFailureType type;
  final String message;
  final Object? cause;

  AppFailure copyWith({AppFailureType? type, String? message, Object? cause}) {
    return AppFailure(
      type: type ?? this.type,
      message: message ?? this.message,
      cause: cause ?? this.cause,
    );
  }
}

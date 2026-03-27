import '../errors/app_failure.dart';

sealed class AppResult<T> {
  const AppResult();

  bool get isSuccess => this is AppSuccess<T>;
  bool get isFailure => this is AppFailureResult<T>;

  T? get dataOrNull => switch (this) {
    AppSuccess<T>(data: final value) => value,
    _ => null,
  };

  AppFailure? get failureOrNull => switch (this) {
    AppFailureResult<T>(failure: final failure) => failure,
    _ => null,
  };
}

class AppSuccess<T> extends AppResult<T> {
  const AppSuccess(this.data);

  final T data;
}

class AppFailureResult<T> extends AppResult<T> {
  const AppFailureResult(this.failure);

  final AppFailure failure;
}

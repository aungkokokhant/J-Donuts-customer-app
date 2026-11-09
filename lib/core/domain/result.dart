sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);

  final AppFailure error;
}

sealed class AppFailure {
  const AppFailure();
}

final class LocalDataFailure extends AppFailure {
  const LocalDataFailure(this.cause, this.stackTrace);

  final Object cause;
  final StackTrace stackTrace;
}

sealed class Result<T> {
  const Result();

  factory Result.success(T data) => Success(data);
  factory Result.failure(String error) => Failure(error);
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String error;

  const Failure(this.error);
}

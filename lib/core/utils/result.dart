class Result<T> {
  final T? data;
  final String? message;
  final bool isSuccess;

  Result._(this.data, this.message, this.isSuccess);

  static Result<T> success<T>(T data) {
    return Result._(data, null, true);
  }

  static Result<T> error<T>(String message) {
    return Result._(null, message, false);
  }
}
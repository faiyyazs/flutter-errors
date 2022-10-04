class NoNetworkException implements Exception {
  /// Description of the cause.
  final String? message;

  NoNetworkException(this.message);

  @override
  String toString() {
    String result = "NoNetworkException";
    if (message != null) result = "$result: $message";
    return result;
  }
}

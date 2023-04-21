class CustomTableException implements Exception {
  final String? message;

  CustomTableException(this.message);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "CustomTableException";
    return "CustomTableException: $message";
  }
}

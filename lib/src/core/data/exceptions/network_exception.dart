class NetworkException implements Exception {
  final String message;
  final int statusCode;

  NetworkException({
    this.message = '',
    this.statusCode = 500,
  });

  @override
  String toString() => 'NetworkException: $message, $statusCode';
}

enum NetworkExceptionStatus {
  serverError(500),
  notFound(404),
  revisionError(400),
  unauthorized(401);

  final int statusCode;

  const NetworkExceptionStatus(this.statusCode);

  static NetworkExceptionStatus getStatusFromCode(int statusCode) {
    return NetworkExceptionStatus.values.firstWhere(
      (status) => status.statusCode == statusCode,
      orElse: () => NetworkExceptionStatus.serverError,
    );
  }
}

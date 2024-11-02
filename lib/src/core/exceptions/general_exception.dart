class GeneralException implements Exception {
  final String message;
  final int? statusCode;

  const GeneralException([
    String? message,
    this.statusCode,
  ]) : message = message ?? 'errorOccurred';

  factory GeneralException.fromException(dynamic l) =>
      l is GeneralException ? l : const GeneralException();

  factory GeneralException.fromExceptionWthCode(dynamic l, int code) =>
      l is GeneralException ? l : GeneralException(null, code);

  @override
  String toString() {
    return 'GeneralException{message: $message, statusCode: $statusCode}';
  }
}

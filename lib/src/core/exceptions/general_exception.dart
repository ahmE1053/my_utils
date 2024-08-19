class GeneralException implements Exception {
  final String message;

  const GeneralException([
    String? message,
  ]) : message = message ?? 'errorOccurred';

  factory GeneralException.fromException(dynamic l) =>
      l is GeneralException ? l : const GeneralException();

  @override
  String toString() {
    return 'GeneralException{message: $message}';
  }

}

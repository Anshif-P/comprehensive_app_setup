class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class InternetException extends AppException {
  InternetException() : super('No internet connection');
}

class RequestTimeOutException extends AppException {
  RequestTimeOutException() : super('Request time out');
}

class BadRequestException extends AppException {
  BadRequestException() : super('somthing went wrong');
}

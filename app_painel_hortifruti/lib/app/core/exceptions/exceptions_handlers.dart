import 'package:dio/dio.dart';

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() {
    return 'Connection has timed out, please try again.';
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() {
    return 'Invalid request.';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() {
    return 'Access denied.';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() {
    return 'The requested information could not be found.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() {
    return 'Conflict occurred.';
  }
}

class UnprocessableEntity extends DioException {
  UnprocessableEntity(RequestOptions requestOptions, Response? response)
      : super(requestOptions: requestOptions);

  @override
  String toString() {
    if (response != null) {
      return response!.data['errors'].first['message'];
    } else {
      return 'Validation failed.';
    }
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() {
    return 'Internal server error has occurred.';
  }
}

class ConnectionException extends DioException {
  ConnectionException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() {
    return 'Connection error has occurred, please check internet and try again.';
  }
}

class UnknownErrorException extends DioException {
  UnknownErrorException(RequestOptions requestOptions)
      : super(requestOptions: requestOptions);

  @override
  String toString() {
    return 'Unknown exception has occurred.';
  }
}

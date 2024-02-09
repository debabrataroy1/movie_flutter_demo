import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioError.response?.statusCode ?? 400);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String? message;

  String _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
      case 403:
        return "Unauthorized request";
      case 404:
        return "Not found";
      case 409:
        return "Error due to a conflict";
      case 408:
        return "Connection request timeout";
      case 500:
        return 'Internal server error';
      case 503:
        return "Service unavailable";
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message ?? '';
}

class DioCustomError implements DioException {
  DioCustomError(this.message, DioException error) {
    requestOptions = error.requestOptions;
    type = error.type;
    this.error = error.error;
    response = error.response;
  }

  setMessage(String message) {
    this.message = message;
  }

  @override
  String message = '';

  @override
  String toString() => message;

  @override
  Object? error;

  @override
  late RequestOptions requestOptions;

  @override
  Response? response;

  @override
  late DioExceptionType type;

  @override
  DioException copyWith(
      {RequestOptions? requestOptions,
      Response? response,
      DioExceptionType? type,
      Object? error,
      StackTrace? stackTrace,
      String? message}) {
    throw UnimplementedError();
  }

  @override
  StackTrace get stackTrace => throw UnimplementedError();
}

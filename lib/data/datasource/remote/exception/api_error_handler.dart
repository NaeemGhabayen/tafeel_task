import 'package:dio/dio.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioExceptionType.unknown:
              errorDescription =
                  "Connection to API server failed due to internet connection";
              break;
            case DioExceptionType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 400:
                case 404:
                  errorDescription = error.response!.data['error'] ??
                      error.response!.data['errors'];
                  break;
                case 500:
                case 503:
                  errorDescription = error.response!.statusMessage;
                  break;
                case 401:
                  errorDescription = 'unauthorized';
                  break;
                case 403:
                  errorDescription = 'block user';
                  break;
                default:
                  errorDescription = error.response!.data['error'] ??
                      error.response!.data['errors'];
              }
              break;
            case DioExceptionType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
            case DioExceptionType.badCertificate:
              errorDescription = "Bad certificate. Please contact support";
              break;
            case DioExceptionType.connectionError:
              errorDescription = "Connection error, please retry.";
              break;
          }
        } else {
          errorDescription = "Unexpected error occurred";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "is not a subtype of exception";
    }
    return errorDescription;
  }
}

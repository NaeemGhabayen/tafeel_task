import 'dart:io';

import 'package:tafeel_task/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:tafeel_task/utils/app_constants.dart';

class DioClient {
  final String? baseUrl;
  final LoggingInterceptor? loggingInterceptor;

  Dio? dio;
  String? countryCode;

  DioClient(
    this.baseUrl,
    Dio dioC, {
    this.loggingInterceptor,
  }) {
    dio = dioC;
    dio!
      ..options.baseUrl = baseUrl!
      ..options.connectTimeout = const Duration(milliseconds: 15000)
      ..options.receiveTimeout = const Duration(milliseconds: 15000)
         ;
    dio!.interceptors.add(loggingInterceptor!);
  }


  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio!.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

}

import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:dio/dio.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;
  int totalDownloadedBytes = 0;

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    final String responseAsString = response.data.toString();
    final int responseSize = responseAsString.length;

    totalDownloadedBytes += responseSize;

    dev.log(
        "✅ RESPONSE [${response.statusCode}] ${response.requestOptions.uri}");
    dev.log("📥 Response Size: ${_formatBytes(responseSize)} bytes");
    dev.log(
        "📊 Total Downloaded in Session: ${_formatBytes(totalDownloadedBytes)}");

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    dev.log(
        "ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path} ");
    return super.onError(err, handler);
  }

  String _formatBytes(int bytes, [int decimals = 2]) {
    if (bytes == 0) return "0 B";
    const k = 1024;
    const sizes = ["B", "KB", "MB", "GB"];
    final i = (math.log(bytes) / math.log(k)).floor();
    final value = (bytes / math.pow(k, i)).toStringAsFixed(decimals);
    return "$value ${sizes[i]}";
  }
}

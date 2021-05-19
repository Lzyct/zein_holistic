import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'utils.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logs(
        // ignore: unnecessary_null_comparison
        "REQUEST ► ︎ ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl) + (options.path)}");
    debugPrint("Headers:");
    options.headers.forEach((k, v) => debugPrint('► $k: $v'));
    debugPrint("❖ QueryParameters :");
    try {
      options.queryParameters.forEach((k, v) => debugPrint('► $k: $v'));
    } catch (e) {
      debugPrint("Error : $e");
    }
    if (options.data != null) {
      try {
        JsonEncoder encoder = new JsonEncoder.withIndent('  ');
        String prettyJson = encoder.convert(options.data);
        debugPrint("Body: $prettyJson");
      } catch (e) {
        debugPrint("Error $e");
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    debugPrint(
        "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL')}");
    debugPrint(
        "${dioError.response != null ? dioError.response!.data : 'Unknown Error'}");
    debugPrint("<-- End error");
    super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logs(
        // ignore: unnecessary_null_comparison
        "◀ ︎RESPONSE ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
    debugPrint("Headers:");
    response.headers.forEach((k, v) => debugPrint('$k: $v'));

    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyJson = encoder.convert(response.data);
    debugPrint("Response: $prettyJson");
    logs("◀ END REQUEST ► ︎");
    super.onResponse(response, handler);
  }
}

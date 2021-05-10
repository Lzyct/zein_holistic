import 'package:dio/dio.dart';
import 'package:zein_holistic/utils/utils.dart';

class API {
  static const BASE_URL = "http://localhost:8989/api";

  Dio getDio() {
    return Dio(BaseOptions(
      baseUrl: BASE_URL,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      receiveTimeout: 60000,
      connectTimeout: 60000,
    ))
      ..interceptors.add(DioInterceptor());
  }
}

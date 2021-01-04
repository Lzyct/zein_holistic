import 'package:dio/dio.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/utils/dio_interceptor.dart';

class API {
  static const BASE_URL = "https://zein_holistic.id";

  Dio getDio({String token}) {
    return Dio(BaseOptions(
        baseUrl: BASE_URL,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': sl<PrefManager>().getToken()
        },
        receiveTimeout: 60000,
        connectTimeout: 60000,
        validateStatus: (int status) {
          return status > 0;
        }))
      ..interceptors.add(DioInterceptor());
  }
}

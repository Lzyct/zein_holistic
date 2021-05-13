import 'package:dio/dio.dart';
import 'package:zein_holistic/core/data/models/request/patient/create_patient_request.dart';
import 'package:zein_holistic/core/data/models/request/patient/list_patient_request.dart';
import 'package:zein_holistic/core/data/sources/rest/patient_api.dart';
import 'package:zein_holistic/di/di.dart';

class PatientApiImpl extends PatientApi {
  var _dio = sl<API>().getDio();

  @override
  Future<Response> createPatient(CreatePatientRequest request) async =>
      await _dio.post("/patient",
          data: request.toMap(),
          options: Options(contentType: Headers.formUrlEncodedContentType));

  @override
  Future<Response> getListPatient(ListPatientRequest request) async =>
      await _dio.get("/patients", queryParameters: request.toMap());
}

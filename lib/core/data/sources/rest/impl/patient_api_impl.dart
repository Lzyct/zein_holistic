import 'package:dio/dio.dart';
import 'package:zein_holistic/core/data/models/request/patient/patient_request.dart';
import 'package:zein_holistic/core/data/models/request/patient/list_patient_request.dart';
import 'package:zein_holistic/core/data/sources/rest/patient_api.dart';
import 'package:zein_holistic/di/di.dart';

class PatientApiImpl extends PatientApi {
  var _dio = sl<API>().getDio();

  @override
  Future<Response> createPatient(PatientRequest request) async =>
      await _dio.post("/patient",
          data: request.toMap(),
          options: Options(contentType: Headers.formUrlEncodedContentType));

  @override
  Future<Response> listPatient(ListPatientRequest request) async =>
      await _dio.get("/patients", queryParameters: request.toMap());

  @override
  Future<Response> deletePatient(String idPatient) async =>
      await _dio.delete("/patient/$idPatient");

  @override
  Future<Response> detailPatient(String idPatient) async =>
      await _dio.get("/patient/$idPatient");

  @override
  Future<Response> updatePatient(PatientRequest request,String idPatient) async =>
      await _dio.put("/patient/$idPatient",
          data: request.toMap(),
          options: Options(contentType: Headers.formUrlEncodedContentType));
}

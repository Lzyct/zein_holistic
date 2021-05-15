import 'package:dio/dio.dart';
import 'package:zein_holistic/core/data/models/request/patient/list_medical_record_request.dart';
import 'package:zein_holistic/core/data/models/request/patient/medical_record_request.dart';
import 'package:zein_holistic/core/data/sources/rest/medical_record_api.dart';
import 'package:zein_holistic/di/di.dart';

class MedicalRecordImpl extends MedicalRecordApi {
  var _dio = sl<API>().getDio();

  @override
  Future<Response> createMedicalRecord(MedicalRecordRequest request) async =>
      await _dio.post("/medical-record",
          data: request.toMap(),
          options: Options(contentType: Headers.formUrlEncodedContentType));

  @override
  Future<Response> listMedicalRecord(ListMedicalRecordRequest request) async =>
      await _dio.get("/medical-records", queryParameters: request.toMap());

  @override
  Future<Response> deleteMedicalRecord(String idMedicalRecord) async =>
      await _dio.delete("/medical-record/$idMedicalRecord");

  @override
  Future<Response> detailMedicalRecord(String idMedicalRecord) async =>
      await _dio.get("/medical-record/$idMedicalRecord");

  @override
  Future<Response> updateMedicalRecord(
          MedicalRecordRequest request, String idMedicalRecord) async =>
      await _dio.put("/medical-record/$idMedicalRecord",
          data: request.toMap(),
          options: Options(contentType: Headers.formUrlEncodedContentType));
}

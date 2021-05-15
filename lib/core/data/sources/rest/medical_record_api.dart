import 'package:dio/dio.dart';
import 'package:zein_holistic/core/data/models/request/patient/list_medical_record_request.dart';
import 'package:zein_holistic/core/data/models/request/patient/medical_record_request.dart';

abstract class MedicalRecordApi {
  Future<Response> createMedicalRecord(MedicalRecordRequest request);

  Future<Response> listMedicalRecord(ListMedicalRecordRequest request);

  Future<Response> detailMedicalRecord(String idMedicalRecord);

  Future<Response> updateMedicalRecord(
      MedicalRecordRequest request, String idMedicalRecord);

  Future<Response> deleteMedicalRecord(String idMedicalRecord);
}

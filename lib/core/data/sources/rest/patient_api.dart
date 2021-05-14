import 'package:dio/dio.dart';
import 'package:zein_holistic/core/data/models/request/patient/patient_request.dart';
import 'package:zein_holistic/core/data/models/request/patient/list_patient_request.dart';

abstract class PatientApi {
  Future<Response> createPatient(PatientRequest request);

  Future<Response> listPatient(ListPatientRequest request);

  Future<Response> detailPatient(String idPatient);

  Future<Response> updatePatient(PatientRequest request,String idPatient);

  Future<Response> deletePatient(String idPatient);
}

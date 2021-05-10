import 'package:dio/dio.dart';
import 'package:zein_holistic/core/data/models/request/patient/create_patient_request.dart';
import 'package:zein_holistic/core/data/models/request/patient/list_patient_request.dart';

abstract class PatientApi {
  Future<Response> createPatient(CreatePatientRequest request);

  Future<Response> getListPatient(ListPatientRequest request);
}

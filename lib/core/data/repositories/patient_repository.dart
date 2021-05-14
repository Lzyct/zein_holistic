import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/models/responses/diagnostic.dart';
import 'package:zein_holistic/core/data/models/responses/list_patient_response.dart';
import 'package:zein_holistic/core/data/models/responses/patient_response.dart';
import 'package:zein_holistic/core/data/sources/sources.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/resources/resources.dart';

class PatientRepository {
  var _restPatient = sl<PatientApi>();

  Future<Result<PatientResponse>> createPatient(PatientRequest request) async {
    try {
      Result.isLoading();

      var _response = await _restPatient.createPatient(request);
      var _createPatientResponse = PatientResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return Result.isSuccess(data: _createPatientResponse);
      } else {
        return Result.isError(_createPatientResponse.diagnostic?.status);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<PatientResponse>> updatePatient(
      PatientRequest request, String idPatient) async {
    try {
      Result.isLoading();

      var _response = await _restPatient.updatePatient(request, idPatient);
      var _createPatientResponse = PatientResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return Result.isSuccess(data: _createPatientResponse);
      } else {
        return Result.isError(_createPatientResponse.diagnostic?.status);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<Diagnostic>> deletePatient(String idPatient) async {
    try {
      Result.isLoading();

      var _response = await _restPatient.deletePatient(idPatient);
      var _diagnosticResponse = Diagnostic.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return Result.isSuccess(data: _diagnosticResponse);
      } else {
        return Result.isError(_diagnosticResponse.status);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<PatientResponse>> detailPatient(String idPatient) async {
    try {
      Result.isLoading();

      var _response = await _restPatient.detailPatient(idPatient);
      var _patientResponse = PatientResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return Result.isSuccess(data: _patientResponse);
      } else {
        return Result.isError(_patientResponse.diagnostic?.status);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<ListPatientResponse>> listPatient(
      ListPatientRequest request) async {
    try {
      Result.isLoading();

      var _response = await _restPatient.listPatient(request);
      var _listPatientResponse = ListPatientResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        if (_listPatientResponse.data!.isNotEmpty)
          return Result.isSuccess(data: _listPatientResponse);
        else
          return Result.isEmpty(Strings.dataNotFound);
      } else {
        return Result.isError(_listPatientResponse.diagnostic?.status);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Patient? _patientDb = sl<Patient>();

  Future<Result<PatientEntity>> getDetailPatient(String? id) async {
    try {
      var _response = await _patientDb!.getDetailPatient(id);
      return Result.isSuccess(data: _response);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }
}

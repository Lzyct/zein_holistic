import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/models/responses/create_patient_response.dart';
import 'package:zein_holistic/core/data/models/responses/list_patient_response.dart';
import 'package:zein_holistic/core/data/sources/sources.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

class PatientRepository {
  var _restPatient = sl<PatientApi>();

  Future<Result<CreatePatientResponse>> createPatient(
      CreatePatientRequest request) async {
    try {
      Result.isLoading();

      var _response = await _restPatient.createPatient(request);
      var _createPatientResponse =
          CreatePatientResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return Result.isSuccess(data: _createPatientResponse);
      } else {
        return Result.isError(_createPatientResponse.diagnostic?.status);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<ListPatientResponse>> listPatient(
      ListPatientRequest request) async {
    try {
      Result.isLoading();

      var _response = await _restPatient.getListPatient(request);
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

  Future<Result<dynamic>> addPatient(Map<String, String> _params) async {
    try {
      var _response = await _patientDb!.addPatient(_params);

      logs("is bool ${_response is bool}");
      if (_response is bool) {
        return Result.isSuccess(data: true);
      } else {
        return Result.isError(_response);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<dynamic>> deletePatient(String? id) async {
    try {
      var _response = await _patientDb!.deletePatient(id);
      logs("is bool ${_response is bool}");
      if (_response is bool) {
        return Result.isSuccess(data: true);
      } else {
        return Result.isError(_response);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<dynamic>> editPatient(Map<String, String?> _params) async {
    try {
      await _patientDb!.editPatient(_params);
      return Result.isSuccess(data: true);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<PatientEntity>> getDetailPatient(String? id) async {
    try {
      var _response = await _patientDb!.getDetailPatient(id);
      return Result.isSuccess(data: _response);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<List<PatientEntity>>> getListPatient(String name) async {
    try {
      var _response = await _patientDb!.getListPatient(name);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Result.isEmpty(Strings.errorNoPatient);
      } else {
        return Result.isSuccess(data: _response);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }
}

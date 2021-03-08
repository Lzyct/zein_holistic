import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/sources/local/patient.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

class PatientRepository {
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

import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/models/models.dart';
import 'package:zein_holistic/data/sources/local/patient.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

class PatientRepository {
  var _patientDb = sl<Patient>();

  Future<Resources<dynamic>> addPatient(Map<String, String> _params) async {
    try {
      var _response = await _patientDb.addPatient(_params);

      logs("is bool ${_response is bool}");
      if (_response is bool) {
        return Resources.success(data: true);
      } else {
        return Resources.error(_response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<dynamic>> deletePatient(String id) async {
    try {
      var _response = await _patientDb.deletePatient(id);
      logs("is bool ${_response is bool}");
      if (_response is bool) {
        return Resources.success(data: true);
      } else {
        return Resources.error(_response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<dynamic>> editPatient(Map<String, String> _params) async {
    try {
      await _patientDb.editPatient(_params);
      return Resources.success(data: true);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<PatientEntity>> getDetailPatient(String id) async {
    try {
      var _response = await _patientDb.getDetailPatient(id);
      return Resources.success(data: _response);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<List<PatientEntity>>> getListPatient(String name) async {
    try {
      var _response = await _patientDb.getListPatient(name);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Resources.empty(Strings.errorNoPatient);
      } else {
        return Resources.success(data: _response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }
}

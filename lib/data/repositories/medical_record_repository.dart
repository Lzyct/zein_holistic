import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/models/models.dart';
import 'package:zein_holistic/data/sources/sources.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

class MedicalRecordRepository {
  var _medicalRecordDb = sl<MedicalRecord>();

  Future<Resources<dynamic>> addMedicalRecord(
      Map<String, String> _params) async {
    try {
      var _response = await _medicalRecordDb.addMedicalRecord(_params);

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

  Future<Resources<dynamic>> deleteMedicalRecord(String id) async {
    try {
      var _response = await _medicalRecordDb.deleteMedicalRecord(id);
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

  Future<Resources<dynamic>> editMedicalRecord(
      Map<String, String> _params) async {
    try {
      await _medicalRecordDb.editMedicalRecord(_params);
      return Resources.success(data: true);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<MedicalRecordEntity>> getDetailMedicalRecord(
      String id) async {
    try {
      var _response = await _medicalRecordDb.getDetailMedicalRecord(id);
      return Resources.success(data: _response);
    } catch (e) {
      return Resources.error(e.toString());
    }
  }

  Future<Resources<List<MedicalRecordEntity>>> getListMedicalRecord(
      String idPatient, String mainComplaint) async {
    try {
      var _response =
          await _medicalRecordDb.getListMedicalRecord(idPatient, mainComplaint);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Resources.empty(Strings.errorNoMedicalRecord);
      } else {
        return Resources.success(data: _response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }
}

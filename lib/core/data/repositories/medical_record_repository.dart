import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/sources/sources.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

class MedicalRecordRepository {
  var _medicalRecordDb = sl<MedicalRecord>();

  Future<Result<dynamic>> addMedicalRecord(
      Map<String, String> _params) async {
    try {
      var _response = await _medicalRecordDb.addMedicalRecord(_params);

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

  Future<Result<dynamic>> deleteMedicalRecord(String id) async {
    try {
      var _response = await _medicalRecordDb.deleteMedicalRecord(id);
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

  Future<Result<dynamic>> editMedicalRecord(
      Map<String, String> _params) async {
    try {
      await _medicalRecordDb.editMedicalRecord(_params);
      return Result.isSuccess(data: true);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<MedicalRecordEntity>> getDetailMedicalRecord(
      String id) async {
    try {
      var _response = await _medicalRecordDb.getDetailMedicalRecord(id);
      return Result.isSuccess(data: _response);
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<List<MedicalRecordEntity>>> getListMedicalRecord(
      String idPatient, String mainComplaint) async {
    try {
      var _response =
          await _medicalRecordDb.getListMedicalRecord(idPatient, mainComplaint);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Result.isEmpty(Strings.errorNoMedicalRecord);
      } else {
        return Result.isSuccess(data: _response);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }
}

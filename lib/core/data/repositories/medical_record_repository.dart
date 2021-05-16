import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/request/patient/list_medical_record_request.dart';
import 'package:zein_holistic/core/data/models/request/patient/medical_record_request.dart';
import 'package:zein_holistic/core/data/models/responses/diagnostic.dart';
import 'package:zein_holistic/core/data/models/responses/list_medical_record_response.dart';
import 'package:zein_holistic/core/data/models/responses/medical_record_response.dart';
import 'package:zein_holistic/core/data/sources/rest/medical_record_api.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/resources/resources.dart';

class MedicalRecordRepository {
  var _restMedicalRecord = sl<MedicalRecordApi>();

  Future<Result<MedicalRecordResponse>> createMedicalRecord(
      MedicalRecordRequest request) async {
    try {
      Result.isLoading();

      var _response = await _restMedicalRecord.createMedicalRecord(request);
      var _createMedicalRecordResponse =
          MedicalRecordResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return Result.isSuccess(data: _createMedicalRecordResponse);
      } else {
        return Result.isError(_createMedicalRecordResponse.diagnostic?.status);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<MedicalRecordResponse>> updateMedicalRecord(
      MedicalRecordRequest request, String idMedicalRecord) async {
    try {
      Result.isLoading();

      var _response = await _restMedicalRecord.updateMedicalRecord(
          request, idMedicalRecord);
      var _createMedicalRecordResponse =
          MedicalRecordResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return Result.isSuccess(data: _createMedicalRecordResponse);
      } else {
        return Result.isError(_createMedicalRecordResponse.diagnostic?.status);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<Diagnostic>> deleteMedicalRecord(String idMedicalRecord) async {
    try {
      Result.isLoading();

      var _response =
          await _restMedicalRecord.deleteMedicalRecord(idMedicalRecord);
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

  Future<Result<MedicalRecordResponse>> detailMedicalRecord(
      String idMedicalRecord) async {
    try {
      Result.isLoading();

      var _response =
          await _restMedicalRecord.detailMedicalRecord(idMedicalRecord);
      var _patientResponse = MedicalRecordResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        return Result.isSuccess(data: _patientResponse);
      } else {
        return Result.isError(_patientResponse.diagnostic?.status);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }

  Future<Result<ListMedicalRecordResponse>> listMedicalRecord(
      ListMedicalRecordRequest request) async {
    try {
      if (request.isFirstPage) Result.isLoading();

      var _response = await _restMedicalRecord.listMedicalRecord(request);
      var _listMedicalRecordResponse =
          ListMedicalRecordResponse.fromJson(_response.data);
      if (_response.statusCode == 200) {
        if (_listMedicalRecordResponse.data!.isNotEmpty)
          return Result.isSuccess(data: _listMedicalRecordResponse);
        else
          return Result.isEmpty(Strings.dataNotFound);
      } else {
        return Result.isError(_listMedicalRecordResponse.diagnostic?.status);
      }
    } catch (e) {
      return Result.isError(e.toString());
    }
  }
}

import 'package:zein_holistic/data/models/entities/medical_record_entity.dart';
import 'package:zein_holistic/data/models/models.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

class MedicalRecord {
  Future<dynamic> addMedicalRecord(Map<String, String> _params) async {
    var dbClient = await sl.get<DbHelper>().dataBase;
    try {
      await dbClient.transaction((insert) async => insert.rawInsert('''
      INSERT INTO medicalRecord(
        idPatient,
        mainComplaint,
        additionalComplaint,
        historyOfDisease,
        checkUpResult,
        conclusionDiagnosis,
        suggestion,
        examiner,
        createAt,
        updateAt
      ) VALUES (
        '${_params['idPatient']}',
        '${_params['mainComplaint']}',
        '${_params['additionalComplaint']}',
        '${_params['historyOfDisease']}',
        '${_params['checkUpResult']}',
        '${_params['conclusionDiagnosis']}',
        '${_params['suggestion']}',
        '${_params['examiner']}',
        '${DateTime.now()}',
        '${DateTime.now()}'
      )
    '''));
      return true;
    } catch (e) {
      logs(e);
      return Strings.errorMedicalRecordExist;
    }
  }

  Future<dynamic> editMedicalRecord(Map<String, String> _params) async {
    var dbClient = await sl.get<DbHelper>().dataBase;
    try {
      await dbClient.transaction((update) async => update.rawUpdate('''
      UPDATE medicalRecord SET 
          mainComplaint = '${_params['mainComplaint']}',
          additionalComplaint = '${_params['additionalComplaint']}',
          historyOfDisease = '${_params['historyOfDisease']}',
          checkUpResult = '${_params['checkUpResult']}',
          conclusionDiagnosis = '${_params['conclusionDiagnosis']}',
          suggestion = '${_params['suggestion']}',
          examiner = '${_params['examiner']}', 
          updateAt='${DateTime.now()}'
      WHERE id='${_params['id']}'
    '''));
      return true;
    } catch (e) {
      logs(e);
      return Strings.failedToSave;
    }
  }

  Future<dynamic> deleteMedicalRecord(String id) async {
    var dbClient = await sl.get<DbHelper>().dataBase;
    try {
      await dbClient.transaction((delete) async => delete.rawDelete('''
        DELETE FROM medicalRecord WHERE id='$id'
      '''));
      return true;
    } catch (e) {
      logs(e);
      return e;
    }
  }

  Future<List<MedicalRecordEntity>> getListMedicalRecord(
      String idPatient, String mainComplaint) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query =
        "SELECT * FROM medicalRecord WHERE mainComplaint like '%$mainComplaint%' AND idPatient='$idPatient' ORDER BY createAt DESC";
    if (mainComplaint.isEmpty) {
      _query =
          "SELECT * FROM medicalRecord WHERE idPatient='$idPatient' ORDER BY createAt DESC";
    }

    logs("Query -> $_query");
    List<Map> _queryMap = await _dbClient.rawQuery(_query);
    List<MedicalRecordEntity> _listMedicalRecord = [];
    _queryMap.forEach((element) {
      _listMedicalRecord.add(MedicalRecordEntity(
          id: element["id"],
          idPatient: element["idPatient"],
          mainComplaint: element["mainComplaint"],
          additionalComplaint: element["additionalComplaint"],
          historyOfDisease: element["historyOfDisease"],
          checkUpResult: element["checkUpResult"],
          conclusionDiagnosis: element["conclusionDiagnosis"],
          suggestion: element["suggestion"],
          examiner: element["examiner"],
          createAt: element["createAt"],
          updateAt: element["updateAt"]));
    });
    return _listMedicalRecord;
  }

  Future<MedicalRecordEntity> getDetailMedicalRecord(String id) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query =
        "SELECT * FROM medicalRecord WHERE id='$id' ORDER BY updateAt DESC";

    List<Map> _queryMap = await _dbClient.rawQuery(_query);
    List<MedicalRecordEntity> _listMedicalRecord = [];
    _queryMap.forEach((element) {
      _listMedicalRecord.add(MedicalRecordEntity(
          id: element["id"],
          idPatient: element["idPatient"],
          mainComplaint: element["mainComplaint"],
          additionalComplaint: element["additionalComplaint"],
          historyOfDisease: element["historyOfDisease"],
          checkUpResult: element["checkUpResult"],
          conclusionDiagnosis: element["conclusionDiagnosis"],
          suggestion: element["suggestion"],
          examiner: element["examiner"],
          createAt: element["createAt"],
          updateAt: element["updateAt"]));
    });
    return _listMedicalRecord[0];
  }
}

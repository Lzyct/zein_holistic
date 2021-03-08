import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

class Patient {
  Future<dynamic> addPatient(Map<String, String> _params) async {
    var dbClient = await sl.get<DbHelper>().dataBase;
    if (dbClient != null)
      try {
        await dbClient.transaction((insert) async => insert.rawInsert('''
      INSERT INTO patient(
        id,
        name,
        sex,
        dateBirth,
        address,
        phoneNumber,
        createAt,
        updateAt
      ) VALUES (
        '${_params['name']}-${_params['dateBirth']}',
        '${_params['name']}',
        '${_params['sex']}',
        '${_params['dateBirth']}',
        '${_params['address']}',
        '${_params['phoneNumber']}',
        '${DateTime.now()}',
        '${DateTime.now()}'
      )
    '''));
        return true;
      } catch (e) {
        logs(e);
        return Strings.errorPatientExist;
      }
  }

  Future<dynamic> editPatient(Map<String, String?> _params) async {
    var dbClient = await sl.get<DbHelper>().dataBase;
    if (dbClient != null)
      try {
        await dbClient.transaction((update) async => update.rawUpdate('''
      UPDATE patient SET 
          name='${_params['name']}',
          sex='${_params['sex']}',
          dateBirth='${_params['dateBirth']}',
          address='${_params['address']}',
          phoneNumber='${_params['phoneNumber']}',
          updateAt='${DateTime.now()}'
      WHERE id='${_params['id']}'
    '''));
        return true;
      } catch (e) {
        logs(e);
        return Strings.failedToSave;
      }
  }

  Future<dynamic> deletePatient(String? id) async {
    var dbClient = await sl.get<DbHelper>().dataBase;
    if (dbClient != null)
      try {
        await dbClient.transaction((delete) async => delete.rawDelete('''
        DELETE FROM patient WHERE id='$id'
      '''));
        return true;
      } catch (e) {
        logs(e);
        return e;
      }
  }

  Future<List<PatientEntity>> getListPatient(String name) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    List<PatientEntity> _listPatient = [];
    if (_dbClient != null) {
      var _query =
          "SELECT * FROM patient WHERE name like '%$name%' ORDER BY name ASC";
      if (name.isEmpty) {
        _query = "SELECT * FROM patient ORDER BY name ASC";
      }

      logs("Query -> $_query");
      List<Map> _queryMap = await _dbClient.rawQuery(_query);
      _queryMap.forEach((element) {
        _listPatient.add(PatientEntity(
          id: element['id'],
          name: element['name'],
          sex: element['sex'],
          dateBirth: element['dateBirth'],
          address: element['address'],
          phoneNumber: element['phoneNumber'],
          createAt: element['createAt'],
          updateAt: element['updateAt'],
        ));
      });
      logs("list patient $_listPatient");
    }

    return _listPatient;
  }

  Future<PatientEntity> getDetailPatient(String? id) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    List<PatientEntity> _listPatient = [];
    if (_dbClient != null) {
      var _query = "SELECT * FROM patient WHERE id='$id' ORDER BY name ASC";

      List<Map> _queryMap = await _dbClient.rawQuery(_query);
      _queryMap.forEach((element) {
        _listPatient.add(PatientEntity(
          id: element['id'],
          name: element['name'],
          sex: element['sex'],
          dateBirth: element['dateBirth'],
          address: element['address'],
          phoneNumber: element['phoneNumber'],
          createAt: element['createAt'],
          updateAt: element['updateAt'],
        ));
      });
    }
    return _listPatient[0];
  }
}

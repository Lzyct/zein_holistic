import 'package:zein_holistic/data/models/entities/table_user.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

class User {
  Future<dynamic> addUser(Map<String, String> _params) async {
    var dbClient = await sl.get<DbHelper>().dataBase;
    try {
      await dbClient.transaction((insert) async => insert.rawInsert('''
      INSERT INTO user(
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
      return Strings.errorUserExist;
    }
  }

  Future<List<TableUser>> listUser(String name) async {
    //connect db
    var _dbClient = await sl.get<DbHelper>().dataBase;
    var _query =
        "SELECT * FROM user WHERE name like '%$name%' ORDER BY name ASC";
    if (name.isEmpty) {
      _query = "SELECT * FROM user ORDER BY name ASC";
    }

    logs("Query -> $_query");
    List<Map> _queryMap = await _dbClient.rawQuery(_query);
    List<TableUser> _listUser = [];
    _queryMap.forEach((element) {
      _listUser.add(TableUser(
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
    return _listUser;
  }
}

import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/models/models.dart';
import 'package:zein_holistic/data/sources/local/user.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

class UserRepository {
  Future<Resources<dynamic>> addUser(Map<String, String> _params) async {
    var _userDb = sl<User>();
    try {
      var _response = await _userDb.addUser(_params);

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

  Future<Resources<List<TableUser>>> listUser(String name) async {
    var _userDb = sl<User>();
    try {
      var _response = await _userDb.listUser(name);

      logs("is bool ${_response is bool}");
      if (_response.isEmpty) {
        return Resources.empty(Strings.errorNoData);
      } else {
        return Resources.success(data: _response);
      }
    } catch (e) {
      return Resources.error(e.toString());
    }
  }
}

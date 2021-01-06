import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class AddUserBloc extends Cubit<Resources<dynamic>> {
  AddUserBloc() : super(Resources.loading());

  var _userRepo = sl<UserRepository>();

  addUser(Map<String, String> _params) async {
    emit(Resources.loading());
    emit(await _userRepo.addUser(_params));
  }
}

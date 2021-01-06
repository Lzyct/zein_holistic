import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/models/models.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class ListUserBloc extends Cubit<Resources<List<TableUser>>> {
  ListUserBloc() : super(Resources.loading());

  var _userRepo = sl<UserRepository>();

  listUser(String name) async {
    emit(Resources.loading());
    emit(await _userRepo.listUser(name));
  }
}

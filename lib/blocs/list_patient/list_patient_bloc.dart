import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/models/models.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class ListPatientBloc extends Cubit<Resources<List<PatientEntity>>> {
  ListPatientBloc() : super(Resources.loading());

  var _userRepo = sl<PatientRepository>();

  getListPatient(String name) async {
    emit(Resources.loading());
    emit(await _userRepo.getListPatient(name));
  }
}

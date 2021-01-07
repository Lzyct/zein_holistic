import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class DeletePatientBloc extends Cubit<Resources<dynamic>> {
  DeletePatientBloc() : super(Resources.loading());

  var _userRepo = sl<PatientRepository>();

  deletePatient(String id) async {
    emit(Resources.loading());
    emit(await _userRepo.deletePatient(id));
  }
}

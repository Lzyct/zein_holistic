import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class DeletePatientBloc extends Cubit<Result<dynamic>> {
  DeletePatientBloc() : super(Result.isLoading());

  var _userRepo = sl<PatientRepository>();

  deletePatient(String id) async {
    emit(Result.isLoading());
    emit(await _userRepo.deletePatient(id));
  }
}

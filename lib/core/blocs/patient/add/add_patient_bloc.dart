import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class AddPatientBloc extends Cubit<Result<dynamic>> {
  AddPatientBloc() : super(Result.isLoading());

  var _patientRepo = sl<PatientRepository>();

  addPatient(Map<String, String> _params) async {
    emit(Result.isLoading());
    emit(await _patientRepo.addPatient(_params));
  }
}

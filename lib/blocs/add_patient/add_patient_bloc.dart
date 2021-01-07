import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class AddPatientBloc extends Cubit<Resources<dynamic>> {
  AddPatientBloc() : super(Resources.loading());

  var _patientRepo = sl<PatientRepository>();

  addPatient(Map<String, String> _params) async {
    emit(Resources.loading());
    emit(await _patientRepo.addPatient(_params));
  }
}

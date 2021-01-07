import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class EditPatientBloc extends Cubit<Resources<dynamic>> {
  EditPatientBloc() : super(Resources.loading());

  var _patientRepo = sl<PatientRepository>();

  editPatient(Map<String, String> _params) async {
    emit(Resources.loading());
    emit(await _patientRepo.editPatient(_params));
  }
}

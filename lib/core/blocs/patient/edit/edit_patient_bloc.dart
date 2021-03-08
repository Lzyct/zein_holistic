import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class EditPatientBloc extends Cubit<Result<dynamic>> {
  EditPatientBloc() : super(Result.isLoading());

  PatientRepository? _patientRepo = sl<PatientRepository>();

  editPatient(Map<String, String?> _params) async {
    emit(Result.isLoading());
    emit(await _patientRepo!.editPatient(_params));
  }
}

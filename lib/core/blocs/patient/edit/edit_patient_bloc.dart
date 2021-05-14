import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/request/patient/patient_request.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class EditPatientBloc extends Cubit<Result<dynamic>> {
  EditPatientBloc() : super(Result.isLoading());

  PatientRepository? _patientRepo = sl<PatientRepository>();

  updatePatient(PatientRequest request, String idPatient) async {
    emit(Result.isLoading());
    emit(await _patientRepo!.updatePatient(request, idPatient));
  }
}

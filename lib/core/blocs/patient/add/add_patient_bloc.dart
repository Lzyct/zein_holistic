import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/models/responses/create_patient_response.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class AddPatientBloc extends Cubit<Result<CreatePatientResponse>> {
  AddPatientBloc() : super(Result.isLoading());

  var _patientRepo = sl<PatientRepository>();

  createPatient(CreatePatientRequest request) async {
    emit(await _patientRepo.createPatient(request));
  }
}

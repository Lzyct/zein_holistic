import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/models/responses/list_patient_response.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class ListPatientBloc extends Cubit<Result<ListPatientResponse>> {
  ListPatientBloc() : super(Result.isLoading());

  var _patientRepo = sl<PatientRepository>();

  listPatient(ListPatientRequest request) async {
    emit(await _patientRepo.listPatient(request));
  }
}

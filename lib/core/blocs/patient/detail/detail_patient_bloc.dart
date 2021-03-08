import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class DetailPatientBloc extends Cubit<Result<PatientEntity>> {
  DetailPatientBloc() : super(Result.isLoading());

  PatientRepository? _patientRepo = sl<PatientRepository>();

  getDetailPatient(String? id) async {
    emit(Result.isLoading());
    emit(await _patientRepo!.getDetailPatient(id));
  }
}

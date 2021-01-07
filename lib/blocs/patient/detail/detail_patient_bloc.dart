import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/models/entities/patient_entity.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class DetailPatientBloc extends Cubit<Resources<PatientEntity>> {
  DetailPatientBloc() : super(Resources.loading());

  var _patientRepo = sl<PatientRepository>();

  getDetailPatient(String id) async {
    emit(Resources.loading());
    emit(await _patientRepo.getDetailPatient(id));
  }
}

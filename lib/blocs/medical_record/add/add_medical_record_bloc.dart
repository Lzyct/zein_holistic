import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class AddMedicalRecordBloc extends Cubit<Resources<dynamic>> {
  AddMedicalRecordBloc() : super(Resources.loading());

  var _medicalRecordRepo = sl<MedicalRecordRepository>();

  addMedicalRecord(Map<String, String> _params) async {
    emit(Resources.loading());
    emit(await _medicalRecordRepo.addMedicalRecord(_params));
  }
}

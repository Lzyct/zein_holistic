import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class EditMedicalRecordBloc extends Cubit<Resources<dynamic>> {
  EditMedicalRecordBloc() : super(Resources.loading());

  var _medicalRecordRepo = sl<MedicalRecordRepository>();

  editMedicalRecord(Map<String, String> _params) async {
    emit(Resources.loading());
    emit(await _medicalRecordRepo.editMedicalRecord(_params));
  }
}

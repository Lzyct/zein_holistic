import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class EditMedicalRecordBloc extends Cubit<Result<dynamic>> {
  EditMedicalRecordBloc() : super(Result.isLoading());

  var _medicalRecordRepo = sl<MedicalRecordRepository>();

  editMedicalRecord(Map<String, String> _params) async {
    emit(Result.isLoading());
    emit(await _medicalRecordRepo.editMedicalRecord(_params));
  }
}

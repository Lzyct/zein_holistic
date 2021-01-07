import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class DeleteMedicalRecordBloc extends Cubit<Resources<dynamic>> {
  DeleteMedicalRecordBloc() : super(Resources.loading());

  var _userRepo = sl<MedicalRecordRepository>();

  deleteMedicalRecord(String id) async {
    emit(Resources.loading());
    emit(await _userRepo.deleteMedicalRecord(id));
  }
}

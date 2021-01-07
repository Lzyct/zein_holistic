import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/models/models.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class ListMedicalRecordBloc
    extends Cubit<Resources<List<MedicalRecordEntity>>> {
  ListMedicalRecordBloc() : super(Resources.loading());

  var _userRepo = sl<MedicalRecordRepository>();

  getListMedicalRecord(String idPatient, String mainComplaint) async {
    emit(Resources.loading());
    emit(await _userRepo.getListMedicalRecord(idPatient, mainComplaint));
  }
}

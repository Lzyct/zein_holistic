import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/blocs/blocs.dart';
import 'package:zein_holistic/data/models/models.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class DetailMedicalRecordBloc extends Cubit<Resources<MedicalRecordEntity>> {
  DetailMedicalRecordBloc() : super(Resources.loading());

  var _medicalRecordRepo = sl<MedicalRecordRepository>();

  getDetailMedicalRecord(String id) async {
    emit(Resources.loading());
    emit(await _medicalRecordRepo.getDetailMedicalRecord(id));
  }
}

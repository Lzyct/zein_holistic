import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class DetailMedicalRecordBloc extends Cubit<Result<MedicalRecordEntity>> {
  DetailMedicalRecordBloc() : super(Result.isLoading());

  var _medicalRecordRepo = sl<MedicalRecordRepository>();

  getDetailMedicalRecord(String id) async {
    emit(Result.isLoading());
    emit(await _medicalRecordRepo.getDetailMedicalRecord(id));
  }
}

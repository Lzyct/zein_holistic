import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/responses/medical_record_response.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class DetailMedicalRecordBloc extends Cubit<Result<MedicalRecordResponse>> {
  DetailMedicalRecordBloc() : super(Result.isLoading());

  MedicalRecordRepository _medicalRecordRepo = sl<MedicalRecordRepository>();

  getDetailMedicalRecord(String id) async {
    emit(await _medicalRecordRepo.detailMedicalRecord(id));
  }
}

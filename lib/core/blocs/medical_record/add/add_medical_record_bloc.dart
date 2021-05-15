import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/request/patient/medical_record_request.dart';
import 'package:zein_holistic/core/data/models/responses/medical_record_response.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class AddMedicalRecordBloc extends Cubit<Result<MedicalRecordResponse>> {
  AddMedicalRecordBloc() : super(Result.isLoading());

  MedicalRecordRepository _medicalRecordRepo = sl<MedicalRecordRepository>();

  addMedicalRecord(MedicalRecordRequest request) async {
    emit(await _medicalRecordRepo.createMedicalRecord(request));
  }
}

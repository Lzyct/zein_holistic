import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/request/patient/medical_record_request.dart';
import 'package:zein_holistic/core/data/models/responses/medical_record_response.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class EditMedicalRecordBloc extends Cubit<Result<MedicalRecordResponse>> {
  EditMedicalRecordBloc() : super(Result.isLoading());

  MedicalRecordRepository _medicalRecordRepo = sl<MedicalRecordRepository>();

  editMedicalRecord(MedicalRecordRequest request, String idMedicalRecord) async {
    emit(await _medicalRecordRepo.updateMedicalRecord(request,idMedicalRecord));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/request/patient/list_medical_record_request.dart';
import 'package:zein_holistic/core/data/models/responses/list_medical_record_response.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class ListMedicalRecordBloc extends Cubit<Result<ListMedicalRecordResponse>> {
  ListMedicalRecordBloc() : super(Result.isLoading());

  MedicalRecordRepository _medicalRecordRepo = sl<MedicalRecordRepository>();

  getListMedicalRecord(ListMedicalRecordRequest request) async {
    emit(await _medicalRecordRepo.listMedicalRecord(request));
  }
}

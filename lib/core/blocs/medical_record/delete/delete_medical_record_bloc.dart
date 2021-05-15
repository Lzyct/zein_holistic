import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/responses/diagnostic.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class DeleteMedicalRecordBloc extends Cubit<Result<Diagnostic>> {
  DeleteMedicalRecordBloc() : super(Result.isLoading());

  MedicalRecordRepository _medicalRecordRepo = sl<MedicalRecordRepository>();

  deleteMedicalRecord(String id) async {
    emit(await _medicalRecordRepo.deleteMedicalRecord(id));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class ListMedicalRecordBloc
    extends Cubit<Result<List<MedicalRecordEntity>>> {
  ListMedicalRecordBloc() : super(Result.isLoading());

  MedicalRecordRepository? _userRepo = sl<MedicalRecordRepository>();

  getListMedicalRecord(String? idPatient, String mainComplaint) async {
    emit(Result.isLoading());
    emit(await _userRepo!.getListMedicalRecord(idPatient, mainComplaint));
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/data/models/models.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/di/di.dart';

class ListPatientBloc extends Cubit<Result<List<PatientEntity>>> {
  ListPatientBloc() : super(Result.isLoading());

  PatientRepository? _userRepo = sl<PatientRepository>();

  getListPatient(String name) async {
    emit(Result.isLoading());
    emit(await _userRepo!.getListPatient(name));
  }
}

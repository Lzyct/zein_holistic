import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zein_holistic/core/data/repositories/repositories.dart';
import 'package:zein_holistic/core/data/sources/local/patient.dart';
import 'package:zein_holistic/core/data/sources/rest/impl/medical_record_api_impl.dart';
import 'package:zein_holistic/core/data/sources/rest/impl/patient_api_impl.dart';
import 'package:zein_holistic/core/data/sources/rest/medical_record_api.dart';
import 'package:zein_holistic/core/data/sources/rest/patient_api.dart';
import 'package:zein_holistic/core/data/sources/sources.dart';

import 'di.dart';

var sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerFactory<API>(() => API());
  sl.registerFactory<PatientApi>(() => PatientApiImpl());
  sl.registerFactory<MedicalRecordApi>(() => MedicalRecordImpl());

  sl.registerFactory<DbHelper>(() => DbHelper());
  sl.registerFactory<Patient>(() => Patient());
  sl.registerFactory<MedicalRecord>(() => MedicalRecord());

  //register  Repositories
  sl.registerLazySingleton(() => PatientRepository());
  sl.registerLazySingleton(() => MedicalRecordRepository());
}

//register prefManager
Future<void> initPrefManager() async {
  var _initPrefManager = await SharedPreferences.getInstance();
  sl.registerLazySingleton<PrefManager>(() => PrefManager(_initPrefManager));
}

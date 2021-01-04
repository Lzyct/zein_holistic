import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/data/sources/sources.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'di.dart';

var sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerFactory<API>(() => API());
  sl.registerFactory<RestApiImpl>(() => RestApiImpl());
  sl.registerFactory<DbHelper>(() => DbHelper());

  //register  Repositories
  sl.registerLazySingleton(() => SplashScreenRepository());
}

//register prefManager
Future<void> initPrefManager() async {
  var _initPrefManager = await SharedPreferences.getInstance();
  sl.registerLazySingleton<PrefManager>(() => PrefManager(_initPrefManager));
}

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zein_holistic/data/repositories/repositories.dart';
import 'package:zein_holistic/data/sources/local/user.dart';

import 'di.dart';

var sl = GetIt.instance;

Future<void> serviceLocator() async {
  sl.registerFactory<DbHelper>(() => DbHelper());
  sl.registerFactory<User>(() => User());

  //register  Repositories
  sl.registerLazySingleton(() => UserRepository());
}

//register prefManager
Future<void> initPrefManager() async {
  var _initPrefManager = await SharedPreferences.getInstance();
  sl.registerLazySingleton<PrefManager>(() => PrefManager(_initPrefManager));
}

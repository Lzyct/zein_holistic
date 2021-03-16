import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/pages/splashscreen/splash_screen_page.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

void main() async {
  sqfliteFfiInit();
  serviceLocator();

/*  Crashlytics.instance.enableInDevMode = true;
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;*/

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: LayoutBuilder(
        builder: (_, constrains) {
          logs("maxwidth ${constrains.maxWidth}");
          late Size size;
          if (constrains.maxWidth > 700 || isDesktop) {
            size = Size(1024, 768);
          } else {
            size = Size(375, 667);
          }
          logs("size is $size");
          return ScreenUtilInit(
            designSize: size,
            allowFontScaling: true,
            builder: () => MaterialApp(
              localizationsDelegates: [GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
              supportedLocales: [
                const Locale('id'),
              ],
              debugShowCheckedModeBanner: false,
              builder: (BuildContext context, Widget? child) {
                final MediaQueryData data = MediaQuery.of(context);
                return MediaQuery(
                  data: data.copyWith(textScaleFactor: 1, alwaysUse24HourFormat: true),
                  child: child!,
                );
              },
              title: Strings.appName,
              theme: themeDefault,
              home: SplashScreenPage(),
            ),
          );
        },
      ),
    );
  }
}

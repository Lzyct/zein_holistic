import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/pages/pages.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

void main() async {
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
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('id'),
      ],
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
              textScaleFactor: Responsive.isDesktop(context) ? 1.1 : 1.0,
              alwaysUse24HourFormat: true),
          child: OKToast(child: child!),
        );
      },
      title: Strings.appName,
      theme: themeDefault,
      onGenerateRoute: (RouteSettings settings) {
        var routes = AppRoute.getRoutes(settings: settings);
        WidgetBuilder? builder = routes[settings.name];
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => builder!(context),
            settings: settings,
            transitionDuration: Duration(seconds: 0));
      },
      initialRoute: AppRoute.listPatient,
    );
  }
}

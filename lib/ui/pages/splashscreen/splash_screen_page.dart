import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zein_holistic/core/blocs/blocs.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/pages/pages.dart';
import 'package:zein_holistic/ui/resources/resources.dart';

///*********************************************
/// Created by ukietux on 24/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    await initPrefManager();
    await initializeDateFormatting('id', null);

    Future.delayed(Duration(seconds: 1), () {
      context.goToReplace(MultiBlocProvider(providers: [
        BlocProvider(create: (_) => ListPatientBloc()),
        BlocProvider(create: (_) => DeletePatientBloc())
      ], child: ListPatientPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: Center(
          child: SvgPicture.asset(
        Images.icLogoText,
        width: context.widthInPercent(60),
      )),
    );
  }
}

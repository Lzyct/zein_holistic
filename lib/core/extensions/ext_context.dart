import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zein_holistic/di/di.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

extension ContextExtensions on BuildContext {
  bool isMobile() {
    var shortestSide = MediaQuery.of(this).size.shortestSide;
    return shortestSide < 600;
  }

  logs(dynamic message) {
    print(
        "========================================================================================");
    print("| Message Log : $message");
    print("| Widget Name : ${this.widget}");
    print(
        "========================================================================================");
  }

  goTo(String routeName, {Object? args}) async {
    await Navigator.pushNamed(this, routeName, arguments: args);
  }

  goToReplacePageRoute(String routeName, {Object? args}) async {
    await Navigator.pushReplacementNamed(this, routeName, arguments: args);
  }

  goToReplace(String routeName, {Object? args}) async {
    await Navigator.pushReplacementNamed(this, routeName, arguments: args);
  }

  goToClearStack(String routeName, {Object? args}) {
    Navigator.pushNamedAndRemoveUntil(
        this, routeName, (Route<dynamic> route) => false,
        arguments: args);
  }

  appBar() {
    return AppBar(
      toolbarHeight: Dimens.headerHeight,
      brightness: Brightness.light,
      title: Center(
        child: Container(
            constraints: BoxConstraints(maxWidth: Dimens.maxWidth),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Images.icLogoTextAlt,
                  height: Dimens.logoHeight,
                ),
                if (Responsive.isDesktop(this)) Spacer(),
                if (Responsive.isDesktop(this))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        Strings.address,
                        style: TextStyles.textBold,
                      ),
                      Text(
                        Strings.addressContent,
                        style: TextStyles.textBold,
                      ),
                    ],
                  )
              ],
            )),
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: Dimens.elevation,
      automaticallyImplyLeading: false,
    );
  }

  noAppBarDark() => PreferredSize(
      child: AppBar(
          backgroundColor: Palette.colorPrimary,
          elevation: 0.0,
          brightness: Brightness.dark),
      preferredSize: Size.fromHeight(0.0));

  noAppBarLight() => PreferredSize(
      child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light),
      preferredSize: Size.fromHeight(0.0));

  Future<DateTime?> datePicker({DateTime? currentDate}) async {
    return await showDatePicker(
      context: this,
      initialDate: currentDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
      initialEntryMode: DatePickerEntryMode.input,
      initialDatePickerMode: DatePickerMode.year,
      helpText: Strings.selectDate,
      confirmText: Strings.select,
      locale: Locale("id"),
      cancelText: Strings.cancel,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Palette.colorPrimary,
            hintColor: Palette.colorPrimary,
            accentColor: Palette.colorPrimary,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.light(
              primary: Palette.colorPrimary,
              onError: Palette.red,
              onPrimary: Colors.white,
              surface: Palette.colorPrimary,
              secondary: Colors.white,
              onSurface: Palette.colorPrimary,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
  }

/*  Future<String> timePicker() async {
    var result = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: this,
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: Strings.selectTime,
      confirmText: Strings.select,
      cancelText: Strings.cancel,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Palette.colorPrimary,
            hintColor: Palette.colorPrimary,
            accentColor: Palette.colorPrimary,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.light(
              primary: Palette.colorPrimary,
              onError: Palette.red,
              onPrimary: Colors.white,
              surface: Colors.white,
              secondary: Palette.colorPrimary,
              onSurface: Palette.colorPrimary,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );

    //add 0 if length =1
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(result.hour)}:${result.minute}";
  }*/

  bottomSheet({required String title, required Widget child, double? height}) {
    showModalBottomSheet(
        context: this,
        enableDrag: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.space16),
          topRight: Radius.circular(Dimens.space16),
        )),
        backgroundColor: Colors.white,
        elevation: Dimens.space16,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(
                vertical: Dimens.space16, horizontal: Dimens.space24),
            height: height ?? heightInPercent(80),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.space16),
              topRight: Radius.circular(Dimens.space16),
            )),
            child: Column(
              children: [
                Container(
                  width: Dimens.bottomButton,
                  height: Dimens.elevation,
                  margin: EdgeInsets.only(bottom: Dimens.space16),
                  decoration: BoxDecoration(
                      color: Palette.bottomIndicator,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
                Text(
                  title,
                  style: TextStyles.text.copyWith(
                      fontSize: Dimens.fontLarge2, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: Dimens.space16),
                Expanded(
                  child: child,
                )
              ],
            ),
          );
        });
  }

  /// Dimens should define in context extensions
  ///

  widthInPercent(double percent) {
    var toDouble = percent / 100;
    return MediaQuery.of(this).size.width * toDouble;
  }

  heightInPercent(double percent) {
    var toDouble = percent / 100;
    return MediaQuery.of(this).size.height * toDouble;
  }

  dp2() {
    return MediaQuery.of(this).size.width / 120;
  }

  dp4() {
    return MediaQuery.of(this).size.width / 100;
  }

  dp6() {
    return MediaQuery.of(this).size.width / 70;
  }

  double dp8() {
    return MediaQuery.of(this).size.width / 54;
  }

  dp10() {
    return MediaQuery.of(this).size.width / 41;
  }

  dp12() {
    return MediaQuery.of(this).size.width / 34;
  }

  dp14() {
    return MediaQuery.of(this).size.width / 29;
  }

  dp16() {
    return MediaQuery.of(this).size.width / 26;
  }

  dp18() {
    return MediaQuery.of(this).size.width / 23;
  }

  dp20() {
    return MediaQuery.of(this).size.width / 20;
  }

  dp22() {
    return MediaQuery.of(this).size.width / 17;
  }

  dp24() {
    return MediaQuery.of(this).size.width / 16;
  }

  dp25() {
    return MediaQuery.of(this).size.width / 15;
  }

  dp28() {
    return MediaQuery.of(this).size.width / 12;
  }

  dp30() {
    return MediaQuery.of(this).size.width / 10;
  }

  dp32() {
    return MediaQuery.of(this).size.width / 8;
  }

  dp36() {
    return MediaQuery.of(this).size.width / 6;
  }

  logout() {
    //clear shared Preferences
    sl<PrefManager>().logout();
    /*this.goToReplacePageRoute(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: LoginPage(),
    ));*/
  }
}

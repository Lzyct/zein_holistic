import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/utils/responsive.dart';

///*********************************************
/// Created by ukieTux on 23/04/2020 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class ButtonIcon extends StatelessWidget {
  final String? title;
  final Function onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final Color? titleColor;
  final double? fontSize;
  final Color? splashColor;
  final IconData icon;

  const ButtonIcon(
      {Key? key,
      this.title,
      required this.onPressed,
      this.width,
      this.height,
      this.color,
      this.titleColor,
      this.fontSize,
      this.splashColor,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minWidth: Responsive.isDesktop(context)
              ? Dimens.minWidthButtonDesktop
              : Dimens.minWidthButtonMobile),
      width: width,
      margin: EdgeInsets.symmetric(vertical: Dimens.space8),
      height: height ?? 45,
      padding: EdgeInsets.symmetric(horizontal: Dimens.space8),
      decoration: BoxDecorations.button.copyWith(color: color ?? Palette.blue),
      child: TextButton(
          onPressed: onPressed as void Function()?,
          style: TextButton.styleFrom(
            backgroundColor: splashColor,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(Dimens.space4)),
            padding: EdgeInsets.all(0.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != null)
                Text(
                  title!.toUpperCase(),
                  style: TextStyle(
                      color: titleColor ?? Colors.white,
                      fontSize: fontSize ?? Dimens.fontSmall,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              if (title != null)
                SizedBox(
                  width: Dimens.space8,
                ),
              Icon(
                icon,
                color: titleColor,
              )
            ],
          )),
    );
  }
}

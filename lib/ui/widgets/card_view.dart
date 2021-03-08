import 'package:flutter/material.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/resources/resources.dart';

///*********************************************
/// Created by ukietux on 31/10/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class CardView extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final Color bgColor;
  final double radius;
  final Function onTap;

  const CardView(
      {Key key,
      this.margin,
      this.bgColor,
      this.radius,
      @required this.child,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ??
          EdgeInsets.symmetric(
              vertical: context.dp8(), horizontal: context.dp16()),
      color: bgColor ?? Colors.white,
      elevation: Dimens.elevation,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 5))),
      child: InkWell(
        splashColor: Colors.black26,
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 5)),
        onTap: onTap,
        child: child,
      ),
    );
  }
}

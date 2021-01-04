import 'package:zein_holistic/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:zein_holistic/utils/utils.dart';

///*********************************************
/// Created by ukietux on 24/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class TextCR extends StatelessWidget {
  final Color color;

  const TextCR({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.copyRight,
          style: TextStyle(
              color: color ?? Palette.colorText, fontSize: Dimens.fontSmall),
        ),
        SizedBox(
          width: context.dp8(),
        ),
        Text(
          Strings.companyName,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color ?? Palette.colorText,
              fontSize: Dimens.fontSmall),
        )
      ],
    );
  }
}

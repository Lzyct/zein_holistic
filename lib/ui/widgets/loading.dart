import 'package:flutter/material.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/ui/widgets/widgets.dart';

///*********************************************
/// Created by ukietux on 25/06/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ColorLoader(),
        Text(
          Strings.pleaseWait,
          style: TextStyles.text,
        )
      ],
    );
  }
}

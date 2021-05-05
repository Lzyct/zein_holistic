import 'package:flutter/material.dart';
import 'package:zein_holistic/ui/resources/resources.dart';

///*********************************************
///  zein_holistic
///  |->
///    |-> back_button.dart
/// --------------------------------------------
/// Created by Mudassir 🧑🏻‍💻
/// on 📅 05/05/21 🕰 11:21 with ❤️
/// email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux
///*********************************************
/// © 2021 | All Right Reserved
class BackButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: Palette.colorHint,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}

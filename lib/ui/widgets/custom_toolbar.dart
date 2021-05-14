import 'package:flutter/material.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/ui/widgets/widgets.dart';

///*********************************************
///  zein_holistic
///  |->
///    |-> custom_toolbar.dart
/// --------------------------------------------
/// Created by Mudassir 🧑🏻‍💻
/// on 📅 05/05/21 🕰 11:42 with ❤️
/// email : hey.mudassir@gmail.com
/// github : https://www.github.com/ukieTux
///*********************************************
/// © 2021 | All Right Reserved
class CustomToolbar extends StatelessWidget {
  final String title;

  const CustomToolbar({Key? key, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.padding),
      child: Row(
        children: [
          BackButtons(),
          Text(
            title,
            style: TextStyles.textHint.copyWith(fontSize: Dimens.fontLarge4),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';
import 'package:zein_holistic/widgets/widgets.dart';

///*********************************************
/// Created by ukietux on 25/08/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: null,
      isScroll: false,
      child: Column(children: [
        SvgPicture.asset(
          Images.icLogo,
          height: context.heightInPercent(6),
        ),
        Expanded(
          child: ListView.builder(itemBuilder: (_, index) {
            return CardView(
                child: Text(
                  "Item ${index + 1}",
                  style: TextStyles.text,
                ),
                onTap: () {});
          }),
        )
      ]),
    );
  }
}

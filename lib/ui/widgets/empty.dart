import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/resources/resources.dart';

///*********************************************
/// Created by ukietux on 25/06/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Empty extends StatelessWidget {
  final String errorMessage;

  const Empty({Key key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Images.imgNoData,
            width: context.widthInPercent(50),
          ),
          SizedBox(
            height: context.dp16(),
          ),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyles.textHint,
          )
        ],
      ),
    );
  }
}

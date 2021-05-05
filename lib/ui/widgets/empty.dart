import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

///*********************************************
/// Created by ukietux on 25/06/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Empty extends StatelessWidget {
  final String? errorMessage;

  const Empty({Key? key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logs("normal font size ${Dimens.fontNormal}");
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Images.imgNoData,
            width: context.heightInPercent(25),
            height: context.heightInPercent(25),
          ),
          SizedBox(
            height: Dimens.space16,
          ),
          Text(
            errorMessage ?? Strings.dataNotFound,
            textAlign: TextAlign.center,
            style: TextStyles.textHint,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';

///*********************************************
/// Created by ukietux on 11/15/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class CardDashboard extends StatelessWidget {
  final String title;
  final String value1;
  final String value2;
  final String value3;

  const CardDashboard({
    Key key,
    this.title,
    this.value1,
    this.value2,
    this.value3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorations.white,
      margin: EdgeInsets.symmetric(vertical: context.dp8()),
      padding: EdgeInsets.symmetric(
          vertical: context.dp16(), horizontal: context.dp24()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            style: TextStyles.text.copyWith(fontSize: Dimens.fontLarge),
          ),
          SizedBox(height: context.dp16()),
          Row(
            children: [
              // Expanded(flex: 2, child: SvgPicture.asset(Images.icMailCloud)), // TODO Use image as SVG
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      Strings.total,
                      style: TextStyles.textHint,
                    ),
                    Text(
                      value1,
                      style: TextStyles.text.copyWith(
                        fontSize: Dimens.fontLarge3,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      title == Strings.concept ? Strings.sent : Strings.notYet,
                      style: TextStyles.textHint,
                    ),
                    Text(
                      value2,
                      style: TextStyles.text.copyWith(
                        fontSize: Dimens.fontLarge3,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      title == Strings.concept ? Strings.draft : Strings.notYet,
                      style: TextStyles.textHint,
                    ),
                    Text(
                      value3,
                      style: TextStyles.text.copyWith(
                        fontSize: Dimens.fontLarge3,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

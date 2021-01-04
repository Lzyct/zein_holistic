import 'package:zein_holistic/resources/dimens.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zein_holistic/utils/utils.dart';

///*********************************************
/// Created by ukietux on 01/11/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class ButtonAttachment extends StatefulWidget {
  ButtonAttachment({Key key, this.onTap}) : super(key: key);
  final Function onTap;

  @override
  _ButtonAttachmentState createState() => _ButtonAttachmentState();
}

class _ButtonAttachmentState extends State<ButtonAttachment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthInPercent(90),
      height: context.widthInPercent(70),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.radius),
          border: Border.all(color: Palette.borderTextF)),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.radius)),
        onPressed: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(Images.icFile), // TODO use image as SVG
            SizedBox(height: context.dp24()),
            Text(
              Strings.addFile,
              style: TextStyles.text.copyWith(fontSize: Dimens.fontLarge),
            )
          ],
        ),
      ),
    );
  }
}

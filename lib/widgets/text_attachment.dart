import 'package:zein_holistic/resources/dimens.dart';
import 'package:zein_holistic/resources/resources.dart';
import 'package:zein_holistic/utils/utils.dart';
import 'package:flutter/material.dart';

///*********************************************
/// Created by ukietux on 01/11/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class TextAttachment extends StatefulWidget {
  TextAttachment({
    Key key,
    this.onDelete,
    this.onTap,
    this.fileName = "Untitled.pdf",
    this.fileSize = "0 MB",
    this.url,
    this.hint,
  }) : super(key: key);
  final Function onDelete;
  final Function onTap;
  final String fileName;
  final String fileSize;
  final String url;
  final String hint;

  @override
  _TextAttachmentState createState() => _TextAttachmentState();
}

class _TextAttachmentState extends State<TextAttachment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hint ?? Strings.documentFax,
          style: TextStyles.textHint.copyWith(fontSize: Dimens.fontSmall),
        ),
        SizedBox(height: context.dp8()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: widget.onTap,
              child: Row(
                children: [
                  Text(
                    widget.fileName,
                    style: TextStyles.textLink,
                  ),
                  SizedBox(width: context.dp8()),
                  Text(
                    "(${widget.fileSize})",
                    style: TextStyles.text,
                  )
                ],
              ),
            ),
            SizedBox(
              height: context.dp24(),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.delete_outline,
                  color: Palette.red,
                ),
                onPressed: widget.onDelete,
              ),
            ),
          ],
        ),
        Divider(
          color: Palette.divider,
          thickness: 1,
        )
      ],
    );
  }
}

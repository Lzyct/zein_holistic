import 'package:flutter/material.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/resources/resources.dart';

///*********************************************
/// Created by ukietux on 01/11/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class DropDown<T> extends StatefulWidget {
  DropDown(
      {Key? key,
      this.value,
      this.items,
      this.hint,
      this.onChanged,
      this.hintIsVisible = true})
      : super(key: key);
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final bool hintIsVisible;
  final String? hint;
  final Function(T)? onChanged;

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimens.space8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.hintIsVisible,
            child: Text(
              widget.hint ?? "",
              style: TextStyles.textHint.copyWith(fontSize: Dimens.fontSmall),
            ),
          ),
          ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(Dimens.space4),
                    borderSide: BorderSide(
                      color: Palette.borderTextF,
                      width: 1.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(Dimens.space4),
                      borderSide: BorderSide(
                        color: Palette.red,
                        width: 1.0,
                      )),
                  errorBorder: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(Dimens.space4),
                      borderSide: BorderSide(
                        color: Palette.red,
                        width: 1.0,
                      )),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0,
                    borderRadius: BorderRadius.circular(Dimens.space4),
                    borderSide: BorderSide(
                      color: Palette.blue,
                      width: 1.0,
                    ),
                  )),
              value: widget.value,
              items: widget.items,
              onChanged: widget.onChanged,
            ),
          ).margin(edgeInsets: EdgeInsets.symmetric(vertical: Dimens.space8))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zein_holistic/resources/resources.dart';

extension WidgetExtensions on Widget {
  padding({EdgeInsets edgeInsets}) => Padding(padding: edgeInsets, child: this);

  margin({EdgeInsets edgeInsets}) => Container(
      margin: (edgeInsets == null) ? EdgeInsets.all(0) : edgeInsets,
      child: this);

  bgAlt() => Container(
        color: Palette.colorBackgroundAlt,
        child: this,
      );
}

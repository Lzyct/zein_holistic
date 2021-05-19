import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';

logs(dynamic message) {
  debugPrint(
      "========================================================================================");
  debugPrint("| Message Log : $message");
  debugPrint(
      "========================================================================================");
}

logsJson(dynamic message) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String prettyJson = encoder.convert(message);
  log("========================================================================================");
  log("| Message Log : $prettyJson");
  log("========================================================================================");
}

String calculateAge(DateTime _birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - _birthDate.year;
  int month1 = currentDate.month;
  int month2 = _birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = _birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age.toString();
}

bool get isDesktop => Platform.isWindows || Platform.isLinux || Platform.isMacOS;

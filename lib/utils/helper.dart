import 'dart:convert';
import 'dart:developer';

logs(dynamic message) {
  log("========================================================================================");
  log("| Message Log : $message");
  log("========================================================================================");
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

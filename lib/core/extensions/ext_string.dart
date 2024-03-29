import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:zein_holistic/ui/resources/resources.dart';
import 'package:zein_holistic/ui/widgets/widgets.dart';

extension StringExtension on String {
  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  String toStringDate() {
    var object = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(this);
    return DateFormat("dd MMMM yyyy", "id").format(object);
  }

  String toStringDateTime() {
    var object = new DateFormat("yyyy-MM-dd HH:mm:ss").parse(this);
    return DateFormat("dd MMMM yyyy HH:mm", "id").format(object);
  }

  DateTime toDate() {
    return DateFormat("dd MMMM yyyy", "id").parse(this);
  }

  String toClock() {
    var object = new DateFormat("HH:mm:ss").parse(this);
    return DateFormat("HH:mm").format(object);
  }

  DateTime toDateTime() {
    return DateFormat("dd MMMM yyyy", "id").parse(this);
  }

  toToastError() {
    try {
      var message = this == null || this.isEmpty ? "error" : this;

      //dismiss before show toast
      dismissAllToast(showAnim: false);

      showToastWidget(
          Toast(
            bgColor: Palette.red,
            icon: Icons.error,
            message: message,
            textColor: Colors.white,
          ),
          dismissOtherToast: true,
          position: ToastPosition.top,
          duration: Duration(seconds: 2));
    } catch (e) {
      print("error $e");
    }
  }

  toToastSuccess() {
    try {
      var message = (this == null || this.isEmpty) ? "success" : this;

      //dismiss before show toast
      dismissAllToast(showAnim: false);

      // showToast(msg)
      showToastWidget(
          Toast(
            bgColor: Colors.green,
            icon: Icons.check_circle,
            message: message,
            textColor: Colors.white,
          ),
          dismissOtherToast: true,
          position: ToastPosition.top,
          duration: Duration(seconds: 2));
    } catch (e) {
      print("success $e");
    }
  }

  toToastLoading() {
    try {
      var message = this == null || this.isEmpty ? "loading" : this;
      //dismiss before show toast
      dismissAllToast(showAnim: true);

      showToastWidget(
          Toast(
            bgColor: Colors.black,
            icon: Icons.info,
            message: message,
            textColor: Colors.white,
          ),
          dismissOtherToast: true,
          position: ToastPosition.top,
          duration: Duration(seconds: 3));
    } catch (e) {
      print("loading $e");
    }
  }

  /// Example how to save json into sharedPreference
  /// and load/read value by key
/*String toTextDictionary() {
    try {
      logs(
          "key $this : value : ${sl.get<DictionaryResponse>(instanceName: "text").data.singleWhere((element) => element.key.toLowerCase() == this.toLowerCase()).value}");
      return sl
          .get<DictionaryResponse>(instanceName: "text")
          .data
          .singleWhere(
              (element) => element.key.toLowerCase() == this.toLowerCase())
          .value;
    } catch (e) {
      logs(e);
      return "key $this belum terdaftar";
    }
  }*/

}

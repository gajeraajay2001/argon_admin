import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/constants/color_constant.dart';

class CustomDialogs {
  void showCircularDialog(BuildContext context) {
    CircularDialog.showLoadingDialog(context);
  }

  void hideCircularDialog(BuildContext context) {
    Get.back();
  }

  getDialog(
      {String title = "Error", String desc = "Some Thing went wrong...."}) {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: title,
        content: Text(desc),
        buttonColor: appTheme.primaryTheme,
        textConfirm: "Ok",
        confirmTextColor: Colors.black,
        onConfirm: () {
          Get.back();
        });
  }
}

class CircularDialog {
  static Future<void> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            child: Center(
              child: CircularProgressIndicator(color: appTheme.primaryTheme),
            ),
            onWillPop: () async {
              return false;
            });
      },
      barrierDismissible: false,
    );
  }
}

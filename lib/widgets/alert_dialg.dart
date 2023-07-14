import 'package:flutter/material.dart';

class MyAlertDialog {
  static void showMyDialogue(
      {required BuildContext context,
      required String title,
      required String content,
      required Function() tabNo,
      required Function() tabYes}) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text("No"),
          onPressed: tabNo,
        ),
        TextButton(
          child: const Text("Yes"),
          onPressed: tabYes,
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}

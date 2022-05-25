import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HelpFunctions {
  HelpFunctions._();
  factory HelpFunctions() => HelpFunctions._();
  Future<void> showSnackBar(String title, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.grey,
      content: Text(title),
    ));
  }

  Future<void> showToast(String text, BuildContext context) async {
    await Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.withOpacity(0.4),
      textColor: Theme.of(context).textTheme.headline1!.color,
      fontSize: 16.0,
    );
  }
}

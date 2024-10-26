import 'package:assignments/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonFunctions {
  /// for light status bar color
  static lightStatusBarColor(Color color) async {
    try {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: color,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: color,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint(e.message.toString());
    }
  }

  /// function to display exit popup
  Future<bool> exitPopUp(context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceBetween,
        contentTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        content: const Text(
          "Are you sure you want to exit this chat?",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.amber,
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: AppColors.appBackgroundColor,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            },
            child: const Text(
              "Yes,Exit",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

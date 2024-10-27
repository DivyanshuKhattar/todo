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
}

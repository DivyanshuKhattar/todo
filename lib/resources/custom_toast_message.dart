import 'package:flutter/material.dart';

///  ***************************************** Toast messages **********************************

class CustomToast {
  static toastMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}

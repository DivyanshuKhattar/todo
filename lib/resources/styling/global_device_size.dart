import 'package:flutter/material.dart';

class DeviceSize {
  static height(context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return deviceHeight;
  }

  static width(context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth;
  }
}

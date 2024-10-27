import 'package:assignments/resources/styling/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
/*
Note:
  Small = fontWeight.300
  Regular = fontWeight.400
  Normal = fontWeight.500
  SemiBold = fontWeight.600
  Bold = fontWeight.700
*/

  /// ************************ [16 pixel text] *************************
  // 16 normal black text style
  static const sixteenNormalBlackText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.black,
  );

  // 16 normal line through grey text style
  static const sixteenNormalLineThroughGreyText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.grey,
    decoration: TextDecoration.lineThrough,
  );

  /// ************************ [20 pixel text] *************************
  // 20 semi bold black text style
  static const twentySemiBoldBlackText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.black,
  );
}

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadows {
  AppShadows._();

  static const small = [
    BoxShadow(
      color: Color(0x140048B5),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ];

  static const medium = [
    BoxShadow(
      color: Color(0x290048B5),
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ];

  static const large = [
    BoxShadow(
      color: AppColors.shadowPrimary,
      blurRadius: 14,
      offset: Offset(0, 7),
    ),
  ];

  static const floating = [
    BoxShadow(
      color: Color(0x330048B5),
      blurRadius: 18,
      offset: Offset(0, 8),
    ),
  ];

  static const figmaTextShadow = [
    Shadow(
      offset: Offset(0, 1),
      blurRadius: 6,
      color: AppColors.white,
    ),
  ];

    static const figmaTextShadow2 = [
    Shadow(
      offset: Offset(0, 1),
      blurRadius: 6,
      color: AppColors.blueDark,
    ),
  ];

  static const List<BoxShadow> whiteGlow = [
  BoxShadow(
    color: AppColors.white,
    offset: Offset(0, 1),
    blurRadius: 6,
    spreadRadius: 0,
  ),
];
}
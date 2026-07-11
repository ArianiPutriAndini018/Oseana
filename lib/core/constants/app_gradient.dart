import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {
  AppGradients._();

  /// Primary Button
  static const primaryButton = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.secondary,
      AppColors.primary,
    ],
    stops: [
      0.30,
      0.67,
    ],
  );

  /// Primary Text
  static const primaryText = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF028BE6),
      Color(0xFF035EC4),
    ],
    stops: [
      0.2731,
      0.7819,
    ],
  );

  /// Ocean Blue
  static const ocean = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.blueSoft,
      AppColors.primary,
    ],
  );

  /// Sky
  static const sky = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFB6F4FF),
      Color(0xFF5DD9FF),
    ],
  );
}
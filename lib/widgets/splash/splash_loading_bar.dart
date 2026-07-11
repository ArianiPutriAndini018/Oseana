import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_duration.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';

class SplashLoadingBar extends StatelessWidget {
  final double progress;

  const SplashLoadingBar({
    super.key,
    required this.progress,
  });

  static const double _loadingBarWidth = 270;
  static const double _loadingBarHeight = 25;
  static const double _loadingBarPadding = 3;
  static const double _loadingBarBorderWidth = 3;
  static const double _loadingProgressWidth = 264;

  @override
  Widget build(BuildContext context) {
    final normalizedProgress = progress.clamp(0.0, 1.0).toDouble();

    return Positioned(
      bottom: AppSpacing.xxxl,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: _loadingBarWidth,
          height: _loadingBarHeight,
          padding: const EdgeInsets.all(_loadingBarPadding),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white,
              width: _loadingBarBorderWidth,
            ),
            borderRadius: AppRadius.radiusXXXL,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: AppDuration.veryFast,
              width: normalizedProgress * _loadingProgressWidth,
              decoration: const BoxDecoration(
                color: AppColors.blueSoft,
                borderRadius: AppRadius.radiusXXXL,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
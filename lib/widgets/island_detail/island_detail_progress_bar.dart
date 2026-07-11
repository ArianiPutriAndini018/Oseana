import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';

class IslandDetailProgressBar extends StatelessWidget {
  final double progress;
  final double height;

  const IslandDetailProgressBar({
    super.key,
    required this.progress,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final value = progress.clamp(0.0, 1.0).toDouble();

    return Container(
      decoration: const BoxDecoration(
        borderRadius: AppRadius.pill,
        boxShadow: AppShadows.whiteGlow,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.pill,
        child: LinearProgressIndicator(
          value: value,
          minHeight: height,
          backgroundColor: AppColors.white.withOpacity(0.65),
          valueColor: const AlwaysStoppedAnimation<Color>(
            AppColors.success,
          ),
        ),
      ),
    );
  }
}
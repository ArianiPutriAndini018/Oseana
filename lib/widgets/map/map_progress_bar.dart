import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';

class MapProgressBar extends StatelessWidget {
  final double progress;
  final bool isSmall;

  const MapProgressBar({
    super.key,
    required this.progress,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final value = progress.clamp(0.0, 1.0).toDouble();

    return Container(
      height: isSmall ? 11 : 12,
      decoration: const BoxDecoration(
        color: AppColors.graySoft,
        borderRadius: AppRadius.pill,
        boxShadow: AppShadows.small,
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: value,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.success,
            borderRadius: AppRadius.pill,
          ),
        ),
      ),
    );
  }
}

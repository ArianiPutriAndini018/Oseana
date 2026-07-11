import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';

class IslandDetailProgressHeader extends StatelessWidget {
  final int learnedBiota;
  final int totalBiota;
  final String progressText;
  final double fontSize;

  const IslandDetailProgressHeader({
    super.key,
    required this.learnedBiota,
    required this.totalBiota,
    required this.progressText,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyles.bodyLarge.copyWith(
      color: AppColors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      height: 1,
      shadows: AppShadows.figmaTextShadow2,
    );

    return Row(
      children: [
        Text(
          '$learnedBiota/$totalBiota biota dipelajari',
          style: textStyle,
        ),

        const Spacer(),

        Text(
          progressText,
          style: textStyle,
        ),
      ],
    );
  }
}
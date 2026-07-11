import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

class IslandLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const IslandLabel({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: 5,
    ),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.radiusXL,
        border: Border.all(
          color: AppColors.primary,
          width: 1.5,
        ),
        boxShadow: AppShadows.small,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyMedium.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
          height: 1,
        ),
      ),
    );

    if (onTap == null) return label;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.radiusXL,
        child: label,
      ),
    );
  }
}

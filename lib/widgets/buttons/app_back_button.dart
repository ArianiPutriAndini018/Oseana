import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;
  final BorderRadius borderRadius;
  final List<BoxShadow>? boxShadow;

  const AppBackButton({
    super.key,
    this.onPressed,
    this.size = 46,
    this.iconSize = 24,
    this.backgroundColor = AppColors.surface,
    this.iconColor = AppColors.primary,
    this.borderRadius = AppRadius.radiusLG,
    this.boxShadow = AppShadows.medium,
  });

  void _handleTap(BuildContext context) {
    if (onPressed != null) {
      onPressed!();
      return;
    }

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: () => _handleTap(context),
          borderRadius: borderRadius,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: iconSize,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_shadows.dart';
import '../../models/island_model.dart';

class IslandStatusNode extends StatelessWidget {
  final IslandStatus status;
  final double size;
  final double iconSize;
  final double borderWidth;
  final bool showBorder;
  final bool showShadow;
  final VoidCallback? onTap;

  const IslandStatusNode({
    super.key,
    required this.status,
    this.size = 52,
    this.iconSize = 30,
    this.borderWidth = 3,
    this.showBorder = true,
    this.showShadow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final node = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _backgroundColor,
        border: showBorder
            ? Border.all(
                color: AppColors.white,
                width: borderWidth,
              )
            : null,
        boxShadow: showShadow ? AppShadows.medium : null,
      ),
      child: Center(
        child: _buildIcon(),
      ),
    );

    if (onTap == null) return node;

    return GestureDetector(
      onTap: onTap,
      child: node,
    );
  }

  Color get _backgroundColor {
    switch (status) {
      case IslandStatus.completed:
        return AppColors.success;

      case IslandStatus.current:
        return AppColors.grayMedium;

      case IslandStatus.locked:
        return AppColors.grayDark;
    }
  }

  Widget? _buildIcon() {
    switch (status) {
      case IslandStatus.completed:
        return Icon(
          Icons.check_rounded,
          size: iconSize,
          color: AppColors.white,
        );

      case IslandStatus.current:
        return null;

      case IslandStatus.locked:
        return Image.asset(
          AppImages.mapLockIcon,
          width: iconSize,
          height: iconSize,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        );
    }
  }
}

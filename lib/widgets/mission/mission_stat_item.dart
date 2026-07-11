import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'mission_stat_image.dart';

class MissionStatItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final bool isSmall;
  final double iconSize;
  final double imageScale;

  const MissionStatItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.isSmall,
    required this.iconSize,
    required this.imageScale,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTight = constraints.maxWidth < 135;
        final resolvedIconSize = isTight ? iconSize - 4 : iconSize;
        final gap = isTight ? 6.0 : 8.0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MissionStatImage(
              image: icon,
              size: resolvedIconSize,
              scale: imageScale,
            ),

            SizedBox(width: gap),

            Expanded(
              child: _MissionStatText(
                label: label,
                value: value,
                isSmall: isSmall,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MissionStatText extends StatelessWidget {
  final String label;
  final String value;
  final bool isSmall;

  const _MissionStatText({
    required this.label,
    required this.value,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              maxLines: 1,
              softWrap: false,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textGrey,
                fontSize: isSmall ? 11 : 12,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
        ),

        SizedBox(height: isSmall ? 6 : 7),

        SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              softWrap: false,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.blueDark,
                fontSize: isSmall ? 14 : 16,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
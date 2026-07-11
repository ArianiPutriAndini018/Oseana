import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class MapLevelContent extends StatelessWidget {
  final int level;
  final bool isSmall;

  const MapLevelContent({
    super.key,
    required this.level,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmall ? 78 : 86,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Explorer',
            maxLines: 1,
            softWrap: false,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: isSmall ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Lv.$level',
            maxLines: 1,
            softWrap: false,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: isSmall ? 17 : 19,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

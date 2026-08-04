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

  String get _levelTitle {
    switch (level) {
      case 5:
        return 'Master Oceana';

      case 4:
        return 'Penjaga Samudra';

      case 3:
        return 'Explorer Oceana';

      case 2:
        return 'Penjelajah Laut';

      case 1:
      default:
        return 'Penjelajah Pemula';
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: isSmall ? 102 : 118,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _levelTitle,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: isSmall ? 11 : 12,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              height: 1.05,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
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
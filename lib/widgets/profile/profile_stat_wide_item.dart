import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/profile_stat_model.dart';
import 'profile_stat_icon.dart';

class ProfileStatWideItem extends StatelessWidget {
  final ProfileStatModel stat;
  final bool isSmall;

  const ProfileStatWideItem({
    super.key,
    required this.stat,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 12 : 16,
        vertical: isSmall ? 10 : 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileStatIcon(
            stat: stat,
            size: isSmall ? 32 : 34,
          ),
          SizedBox(width: isSmall ? 10 : 14),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    stat.title,
                    maxLines: 1,
                    style: AppTextStyles.caption.copyWith(
                      color: const Color(0xFF58627D),
                      fontSize: isSmall ? 12 : 14,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(height: isSmall ? 8 : 10),
                Text(
                  stat.value,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontSize: isSmall ? 10 : 12,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

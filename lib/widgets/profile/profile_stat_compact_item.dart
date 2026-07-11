import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/profile_stat_model.dart';
import 'profile_stat_icon.dart';

class ProfileStatCompactItem extends StatelessWidget {
  final ProfileStatModel stat;
  final bool isSmall;

  const ProfileStatCompactItem({
    super.key,
    required this.stat,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 4 : 6,
        vertical: isSmall ? 8 : 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileStatIcon(
            stat: stat,
            size: isSmall ? 26 : 28,
          ),
          SizedBox(height: isSmall ? 5 : 7),
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                stat.title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  color: const Color(0xFF58627D),
                  fontSize: isSmall ? 8.8 : 9.2,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
            ),
          ),
          SizedBox(height: isSmall ? 5 : 7),
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
    );
  }
}

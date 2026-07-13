import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';

class MissionFloatingXpBadge extends StatelessWidget {
  final int xp;

  const MissionFloatingXpBadge({
    super.key,
    required this.xp,
  });

  static const Color _borderColor = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 9 : 11,
        vertical: isSmall ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusMD,
        border: Border.all(
          color: _borderColor,
          width: 2,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImages.missionXpIcon,
            width: isSmall ? 25 : 28,
            height: isSmall ? 25 : 28,
            fit: BoxFit.contain,
          ),
          SizedBox(width: isSmall ? 4 : 5),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(end: xp.toDouble()),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Text(
                '${value.toInt()} XP',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.blueDark,
                  fontSize: isSmall ? 15 : 17,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

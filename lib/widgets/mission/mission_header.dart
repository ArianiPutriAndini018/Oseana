import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'mission_floating_xp_badge.dart';

class MissionHeader extends StatelessWidget {
  final int userXp;

  const MissionHeader({
    super.key,
    required this.userXp,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: isSmall ? 10 : 12,
            right: isSmall ? 0 : 2,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: MissionFloatingXpBadge(
              xp: userXp,
            ),
          ),
        ),
        SizedBox(height: isSmall ? 14 : 16),
        Text(
          'Misi Konservasi',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.blueDark,
            fontSize: isSmall ? 30 : 35,
            fontWeight: FontWeight.w900,
            height: 1,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: isSmall ? 8 : 9),
        Text(
          'Ocean Mission',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 17 : 20,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ],
    );
  }
}

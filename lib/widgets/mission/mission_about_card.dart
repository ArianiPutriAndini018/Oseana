import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import 'mission_stat_box.dart';

class MissionAboutCard extends StatelessWidget {
  final int completedMissionCount;
  final int totalMissionCount;
  final int completedMissionXp;
  final int totalMissionXp;

  const MissionAboutCard({
    super.key,
    required this.completedMissionCount,
    required this.totalMissionCount,
    required this.completedMissionXp,
    required this.totalMissionXp,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: isSmall ? 18 : 22,
            right: isSmall ? 8 : 10,
            child: Image.asset(
              AppImages.missionDolphin,
              width: isSmall ? 108 : 118,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              isSmall ? 14 : 16,
              isSmall ? 15 : 17,
              isSmall ? 14 : 16,
              isSmall ? 14 : 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MissionAboutTitle(isSmall: isSmall),
                SizedBox(height: isSmall ? 10 : 12),
                Padding(
                  padding: EdgeInsets.only(
                    right: isSmall ? 72 : 86,
                  ),
                  child: Text(
                    'Selesaikan aksi sederhana untuk menjaga laut dan dapatkan XP',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textGrey,
                      fontSize: isSmall ? 8 : 10,
                      fontWeight: FontWeight.w800,
                      height: 1.22,
                    ),
                  ),
                ),
                SizedBox(height: isSmall ? 16 : 18),
                MissionStatBox(
                  completedMissionCount: completedMissionCount,
                  totalMissionCount: totalMissionCount,
                  completedMissionXp: completedMissionXp,
                  totalMissionXp: totalMissionXp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionAboutTitle extends StatelessWidget {
  final bool isSmall;

  const _MissionAboutTitle({
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: isSmall ? 32 : 36,
          height: isSmall ? 32 : 36,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.assignment_rounded,
            color: AppColors.white,
            size: isSmall ? 18 : 20,
          ),
        ),
        SizedBox(width: isSmall ? 8 : 10),
        Text(
          'Tentang Misi',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.blueDark,
            fontSize: isSmall ? 18 : 20,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_radius.dart';
import 'mission_stat_divider.dart';
import 'mission_stat_item.dart';

class MissionStatBox extends StatelessWidget {
  final int completedMissionCount;
  final int totalMissionCount;
  final int completedMissionXp;
  final int totalMissionXp;

  const MissionStatBox({
    super.key,
    required this.completedMissionCount,
    required this.totalMissionCount,
    required this.completedMissionXp,
    required this.totalMissionXp,
  });

  static const Color _borderColor = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 10,
        vertical: isSmall ? 12 : 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: _borderColor,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 52,
            child: MissionStatItem(
              icon: AppImages.missionCoral,
              label: 'Misi Selesai',
              value: '$completedMissionCount/$totalMissionCount',
              isSmall: isSmall,
              iconSize: isSmall ? 52 : 60,
              imageScale: 1.16,
            ),
          ),
          MissionStatDivider(
            isSmall: isSmall,
          ),
          Expanded(
            flex: 48,
            child: MissionStatItem(
              icon: AppImages.missionXpIcon,
              label: 'XP Misi',
              value: '$completedMissionXp/$totalMissionXp XP',
              isSmall: isSmall,
              iconSize: isSmall ? 52 : 68,
              imageScale: 1.08,
            ),
          ),
        ],
      ),
    );
  }
}

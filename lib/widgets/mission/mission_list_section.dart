import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/mission_model.dart';
import 'mission_item_card.dart';

class MissionListSection extends StatelessWidget {
  final List<MissionModel> missions;

  const MissionListSection({
    super.key,
    required this.missions,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daftar Misi',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.blueDark,
            fontSize: isSmall ? 20 : 23,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
        SizedBox(height: isSmall ? 12 : 14),
        if (missions.isEmpty)
          _EmptyMissionMessage(isSmall: isSmall)
        else
          Column(
            children: [
              for (int index = 0; index < missions.length; index++) ...[
                MissionItemCard(
                  mission: missions[index],
                  isSmall: isSmall,
                ),
                if (index != missions.length - 1)
                  SizedBox(height: isSmall ? 10 : 12),
              ],
            ],
          ),
      ],
    );
  }
}

class _EmptyMissionMessage extends StatelessWidget {
  final bool isSmall;

  const _EmptyMissionMessage({
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 14 : 16,
        vertical: isSmall ? 18 : 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
          width: 2,
        ),
      ),
      child: Text(
        'Belum ada misi tersedia.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textGrey,
          fontSize: isSmall ? 12 : 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

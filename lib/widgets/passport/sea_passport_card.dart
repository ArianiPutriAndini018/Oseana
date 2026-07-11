import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/sea_passport_reward_model.dart';
import '../../models/sea_passport_stamp_model.dart';
import 'sea_passport_profile_card.dart';
import 'sea_passport_progress_section.dart';
import 'sea_passport_reward_section.dart';
import 'sea_passport_stamp_collection.dart';

class SeaPassportCard extends StatelessWidget {
  final String userName;
  final String avatar;
  final String level;
  final String title;
  final int xp;
  final List<SeaPassportStampModel> stamps;
  final List<SeaPassportRewardModel> rewards;
  final int completedIslandCount;
  final int totalIslandCount;
  final double learningProgressValue;
  final int learningProgressPercent;

  const SeaPassportCard({
    super.key,
    required this.userName,
    required this.avatar,
    required this.level,
    required this.title,
    required this.xp,
    required this.stamps,
    required this.rewards,
    required this.completedIslandCount,
    required this.totalIslandCount,
    required this.learningProgressValue,
    required this.learningProgressPercent,
  });

  static const Color _cardBackground = Color(0xFFBDEEFF);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isSmall ? 12 : 14,
        isSmall ? 18 : 20,
        isSmall ? 12 : 14,
        isSmall ? 16 : 18,
      ),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sea Passport',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.blueDark,
              fontSize: isSmall ? 14 : 16,
              fontWeight: FontWeight.w900,
              height: 1,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: isSmall ? 14 : 16),
          SeaPassportProfileCard(
            userName: userName,
            avatar: avatar,
            level: level,
            title: title,
            xp: xp,
          ),
          SizedBox(height: isSmall ? 16 : 18),
          SeaPassportStampCollection(
            stamps: stamps,
          ),
          SizedBox(height: isSmall ? 16 : 18),
          SeaPassportRewardSection(
            rewards: rewards,
          ),
          SizedBox(height: isSmall ? 16 : 18),
          SeaPassportProgressSection(
            completedIslandCount: completedIslandCount,
            totalIslandCount: totalIslandCount,
            progressValue: learningProgressValue,
            progressPercent: learningProgressPercent,
          ),
        ],
      ),
    );
  }
}

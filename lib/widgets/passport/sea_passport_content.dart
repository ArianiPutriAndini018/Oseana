import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/controllers/user_profile_controller.dart';
import '../../data/sea_passport_data.dart';
import 'sea_passport_card.dart';

class SeaPassportContent extends StatelessWidget {
  const SeaPassportContent({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return AnimatedBuilder(
      animation: UserProfileController.instance,
      builder: (context, _) {
        final profileController = UserProfileController.instance;

        return SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              isSmall ? 24 : 26,
              isSmall ? 44 : 64,
              isSmall ? 16 : 18,
              135,
            ),
            child: Column(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Sea Passport & Progress',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.blueDark,
                      fontSize: isSmall ? 18 : 22,
                      fontWeight: FontWeight.w900,
                      height: 1,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                SizedBox(height: isSmall ? 20 : 24),
                SeaPassportCard(
                  userName: profileController.userName,
                  avatar: profileController.avatar,
                  level: SeaPassportData.level,
                  title: SeaPassportData.title,
                  xp: SeaPassportData.xp,
                  stamps: SeaPassportData.orderedStamps,
                  rewards: SeaPassportData.unlockedRewards,
                  completedIslandCount: SeaPassportData.completedIslandCount,
                  totalIslandCount: SeaPassportData.totalIslandCount,
                  learningProgressValue: SeaPassportData.learningProgressValue,
                  learningProgressPercent:
                      SeaPassportData.learningProgressPercent,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

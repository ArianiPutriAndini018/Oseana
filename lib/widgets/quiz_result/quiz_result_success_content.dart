import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_text_styles.dart';
import 'quiz_result_dashed_divider.dart';
import 'quiz_result_score_label.dart';
import 'quiz_result_star_row.dart';
import 'quiz_result_xp_reward_line.dart';

class QuizResultSuccessContent extends StatelessWidget {
  final int scorePercentage;
  final int xpReward;
  final Color scoreColor;
  final bool isSmall;

  const QuizResultSuccessContent({
    super.key,
    required this.scorePercentage,
    required this.xpReward,
    required this.scoreColor,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Selamat!',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: scoreColor,
            fontSize: isSmall ? 28 : 31,
            fontWeight: FontWeight.w900,
            height: 1,
            letterSpacing: 1.2,
          ),
        ),

        SizedBox(height: isSmall ? 8 : 10),

        Text(
          'Kamu lulus kuis Pulau NTT',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 13.5 : 15,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: 0.7,
          ),
        ),

        SizedBox(height: isSmall ? 12 : 14),

        const QuizResultScoreLabel(),

        SizedBox(height: isSmall ? 12 : 14),

        Text(
          '$scorePercentage/100',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: scoreColor,
            fontSize: isSmall ? 32 : 40,
            fontWeight: FontWeight.w900,
            height: 1,
            letterSpacing: 1.2,
          ),
        ),

        SizedBox(height: isSmall ? 18 : 20),

        const QuizResultStarRow(
          score: 3,
          totalCount: 3,
        ),

        SizedBox(height: isSmall ? 10 : 12),

        QuizResultXpRewardLine(
          xpReward: xpReward,
          isSmall: isSmall,
        ),

        SizedBox(height: isSmall ? 12 : 14),

        const QuizResultDashedDivider(),

        SizedBox(height: isSmall ? 9 : 10),

        Text(
          'Stamp Pulau NTT\nterbuka dan tersimpan\ndi Sea Passport!',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 12 : 13,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: 0.6,
          ),
        ),

        SizedBox(height: isSmall ? 10 : 12),

        Image.asset(
          AppImages.quizStampNtt,
          width: isSmall ? 100 : 110,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
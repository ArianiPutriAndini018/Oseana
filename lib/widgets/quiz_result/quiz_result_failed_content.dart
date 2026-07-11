import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'quiz_result_dashed_divider.dart';
import 'quiz_result_score_label.dart';
import 'quiz_result_star_row.dart';

class QuizResultFailedContent extends StatelessWidget {
  final int score;
  final int totalCount;
  final int scorePercentage;
  final Color scoreValueColor;
  final Color totalScoreColor;
  final bool isSmall;

  const QuizResultFailedContent({
    super.key,
    required this.score,
    required this.totalCount,
    required this.scorePercentage,
    required this.scoreValueColor,
    required this.totalScoreColor,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Yah, belum berhasil',
          textAlign: TextAlign.center,
          maxLines: 1,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 25 : 28,
            fontWeight: FontWeight.w900,
            height: 1.08,
            letterSpacing: 1.1,
          ),
        ),

        SizedBox(height: isSmall ? 14 : 16),

        const QuizResultScoreLabel(),

        SizedBox(height: isSmall ? 12 : 14),

        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$scorePercentage',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: scoreValueColor,
                  fontSize: isSmall ? 32 : 40,
                  fontWeight: FontWeight.w900,
                  height: 1,
                  letterSpacing: 1.1,
                ),
              ),
              TextSpan(
                text: '/',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontSize: isSmall ? 38 : 42,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              TextSpan(
                text: '100',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: totalScoreColor,
                  fontSize: isSmall ? 38 : 42,
                  fontWeight: FontWeight.w900,
                  height: 1,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: isSmall ? 18 : 20),

        QuizResultStarRow(
          score: score,
          totalCount: totalCount,
        ),

        SizedBox(height: isSmall ? 8 : 10),

        const QuizResultDashedDivider(),

        SizedBox(height: isSmall ? 10 : 12),

        Text(
          'Belum lulus kuis\nBisa ulang kuis atau\nkembali ke peta',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 12 : 13,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}
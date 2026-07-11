import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../quiz/quiz_title_badge.dart';
import 'quiz_result_action_buttons.dart';
import 'quiz_result_failed_content.dart';
import 'quiz_result_success_content.dart';

class QuizResultCard extends StatelessWidget {
  final String title;
  final int score;
  final int totalCount;
  final int xpReward;
  final bool isPerfectScore;
  final String primaryButtonText;
  final VoidCallback onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  const QuizResultCard({
    super.key,
    required this.title,
    required this.score,
    required this.totalCount,
    this.xpReward = 15,
    required this.isPerfectScore,
    required this.primaryButtonText,
    required this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
  });

  static const Color _scoreGreen = Color(0xFF0B8754);
  static const Color _scoreYellow = Color(0xFFF4B400);
  static const Color _scoreRed = Color(0xFFD81717);

  int get _scorePercentage {
    if (totalCount <= 0) return 0;
    return ((score / totalCount) * 100).round();
  }

  Color get _scoreColor {
    if (_scorePercentage >= 100) return _scoreGreen;
    if (_scorePercentage >= 67) return _scoreYellow;
    return _scoreRed;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: isPerfectScore
                ? isSmall
                    ? 500
                    : 520
                : isSmall
                    ? 330
                    : 350,
          ),
          padding: EdgeInsets.fromLTRB(
            isSmall ? 14 : 16,
            isSmall ? 34 : 38,
            isSmall ? 14 : 16,
            isSmall ? 18 : 20,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppRadius.radiusXXL,
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
            boxShadow: AppShadows.medium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isPerfectScore)
                QuizResultSuccessContent(
                  scorePercentage: _scorePercentage,
                  xpReward: xpReward,
                  scoreColor: _scoreGreen,
                  isSmall: isSmall,
                )
              else
                QuizResultFailedContent(
                  score: score,
                  totalCount: totalCount,
                  scorePercentage: _scorePercentage,
                  scoreValueColor: _scoreColor,
                  totalScoreColor: _scoreGreen,
                  isSmall: isSmall,
                ),

              SizedBox(height: isPerfectScore ? 18 : 20),

              QuizResultActionButtons(
                isSmall: isSmall,
                primaryButtonText: primaryButtonText,
                onPrimaryPressed: onPrimaryPressed,
                secondaryButtonText: secondaryButtonText,
                onSecondaryPressed: onSecondaryPressed,
              ),
            ],
          ),
        ),

        Positioned(
          top: isSmall ? -31 : -34,
          child: QuizTitleBadge(
            title: title,
            coralLeft: 65,
            coralRight: 72,
            coralBottom: 5,
          ),
        ),
      ],
    );
  }
}
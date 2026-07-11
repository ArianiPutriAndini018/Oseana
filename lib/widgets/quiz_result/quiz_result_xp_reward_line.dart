import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_text_styles.dart';

class QuizResultXpRewardLine extends StatelessWidget {
  final int xpReward;
  final bool isSmall;

  const QuizResultXpRewardLine({
    super.key,
    required this.xpReward,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppImages.quizXpIcon,
          width: isSmall ? 42 : 46,
          height: isSmall ? 42 : 46,
          fit: BoxFit.contain,
        ),

        SizedBox(width: isSmall ? 7 : 8),

        Text(
          '+$xpReward XP',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 18 : 20,
            fontWeight: FontWeight.w900,
            height: 1,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}
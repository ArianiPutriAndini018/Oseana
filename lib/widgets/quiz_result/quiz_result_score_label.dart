import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class QuizResultScoreLabel extends StatelessWidget {
  const QuizResultScoreLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Text(
      'Skor',
      textAlign: TextAlign.center,
      style: AppTextStyles.bodySmall.copyWith(
        color: AppColors.primary,
        fontSize: isSmall ? 14 : 16,
        fontWeight: FontWeight.w900,
        height: 1,
        letterSpacing: 0.9,
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_colors.dart';

class QuizTitleBadge extends StatelessWidget {
  final String title;
  final double coralLeft;
  final double coralRight;
  final double coralBottom;
  final double? coralWidth;

  const QuizTitleBadge({
    super.key,
    required this.title,
    this.coralLeft = 26,
    this.coralRight = 32,
    this.coralBottom = 5,
    this.coralWidth,
  });

  static const LinearGradient _badgeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0045B1),
      Color(0xFF035FCB),
    ],
    stops: [0.30, 0.67],
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;
    final resolvedCoralWidth = coralWidth ?? (isSmall ? 62.0 : 70.0);

    return SizedBox(
      width: isSmall ? 315 : 345,
      height: isSmall ? 62 : 68,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: coralLeft,
            bottom: coralBottom,
            child: Image.asset(
              AppImages.quizCoralLeft,
              width: resolvedCoralWidth,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            right: coralRight,
            bottom: coralBottom,
            child: Image.asset(
              AppImages.quizCoralRight,
              width: resolvedCoralWidth,
              fit: BoxFit.contain,
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 17 : 20,
              vertical: isSmall ? 9 : 10,
            ),
            decoration: const BoxDecoration(
              gradient: _badgeGradient,
              borderRadius: AppRadius.radiusXXL,
              boxShadow: AppShadows.medium,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.white,
                fontSize: isSmall ? 14 : 15.5,
                fontWeight: FontWeight.w800,
                height: 1,
                letterSpacing: 0.4,
                shadows: AppShadows.figmaTextShadow2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
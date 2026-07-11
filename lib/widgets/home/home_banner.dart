import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/text/stroke_text.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return SizedBox(
      width: double.infinity,
      height: isSmall ? 150 : 165,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.bannerBackground,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: isSmall ? 6 : 10,
            top: isSmall ? 8 : 10,
            bottom: 0,
            child: Image.asset(
              AppImages.bannerDolphin,
              width: isSmall ? 130 : 150,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: isSmall ? 28 : 32,
            left: isSmall ? 95 : 120,
            right: 12,
            child: StrokeText(
              text: "Halo, Explorer!",
              fontSize: isSmall ? 24 : 29,
              fillColor: AppColors.primary,
              strokeColor: AppColors.white,
              strokeWidth: 5,
            ),
          ),
          Positioned(
            top: isSmall ? 70 : 78,
            left: isSmall ? 115 : 145,
            right: 12,
            child: Text(
              "Siap menjelajah\nbiota laut\nIndonesia hari ini?",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: isSmall ? 12 : 14,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                height: 1.25,
                shadows: const [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

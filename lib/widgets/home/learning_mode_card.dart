import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

class LearningModeCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final Color backgroundColor;
  final Color buttonColor;
  final VoidCallback onTap;

  const LearningModeCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.backgroundColor,
    required this.buttonColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      height: isSmall ? 155 : 170,
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 12 : 16,
        vertical: isSmall ? 12 : 14,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.radiusXXL,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowBlueSoft,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          AppSpacing.w16,
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    maxLines: 1,
                    style: AppTextStyles.headingMedium.copyWith(
                      fontSize: isSmall ? 19 : 22,
                      color: AppColors.secondary,
                      letterSpacing: isSmall ? 1 : 2,
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: double.infinity,
                  height: 1.4,
                  color: AppColors.secondaryLine,
                ),
                SizedBox(height: isSmall ? 8 : 10),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: isSmall ? 8 : 10,
                    color: AppColors.secondary,
                    height: 1.28,
                    letterSpacing: isSmall ? 0.8 : 1.2,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: isSmall ? 36 : 40,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: buttonColor,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppRadius.pill,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              buttonText,
                              maxLines: 1,
                              style: AppTextStyles.buttonSmall.copyWith(
                                fontSize: isSmall ? 12 : 14,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                        AppSpacing.w8,
                        Container(
                          width: isSmall ? 25 : 28,
                          height: isSmall ? 25 : 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.white,
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.chevron_right_rounded,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

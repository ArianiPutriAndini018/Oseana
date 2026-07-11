import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';

class IslandDetailInfoRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final double iconSize;
  final double labelWidth;
  final double gap;
  final double fontSize;
  final double lineHeight;
  final int maxLines;
  final double iconYOffset;

  const IslandDetailInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconSize,
    required this.labelWidth,
    required this.gap,
    required this.fontSize,
    required this.lineHeight,
    required this.maxLines,
    required this.iconYOffset,
  });

  @override
  Widget build(BuildContext context) {
    final textBlockHeight = fontSize * lineHeight * maxLines;
    final textTop = (iconSize - textBlockHeight) / 2;

    return SizedBox(
      height: iconSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: iconYOffset,
            child: Image.asset(
              icon,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            left: iconSize + gap,
            right: 0,
            top: textTop,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: labelWidth,
                  child: Text(
                    '$label :',
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w400,
                      height: lineHeight,
                      shadows: AppShadows.figmaTextShadow,
                    ),
                  ),
                ),

                Expanded(
                  child: Text(
                    value,
                    maxLines: maxLines,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w400,
                      height: lineHeight,
                      shadows: AppShadows.figmaTextShadow,
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
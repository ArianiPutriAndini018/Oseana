import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_text_styles.dart';

class ProfileXpProgress extends StatelessWidget {
  final int xp;
  final int maxXp;
  final double progressValue;
  final bool isSmall;

  const ProfileXpProgress({
    super.key,
    required this.xp,
    required this.maxXp,
    required this.progressValue,
    required this.isSmall,
  });

  static const Color _trackColor = Color(0xFFCADCEB);
  static const Color _fillColor = Color(0xFFFFBE18);

  @override
  Widget build(BuildContext context) {
    final iconSize = isSmall ? 48.0 : 58.0;
    final barHeight = isSmall ? 13.0 : 16.0;
    final barRadius = BorderRadius.circular(999);

    return Row(
      children: [
        Transform.translate(
          offset: Offset(
            isSmall ? 8 : 10,
            0,
          ),
          child: Image.asset(
            AppImages.passportXpIcon,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: isSmall ? 10 : 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$xp XP',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.blueDark,
                  fontSize: isSmall ? 12 : 14,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              SizedBox(height: isSmall ? 7 : 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  final baseWidth = constraints.maxWidth;

                  if (baseWidth <= 0) {
                    return SizedBox(height: barHeight);
                  }

                  final extraRight = isSmall ? 34.0 : 36.0;
                  final barWidth = baseWidth + extraRight;

                  final value = progressValue.clamp(0.0, 1.0).toDouble();
                  final rawFillWidth = barWidth * value;

                  final minFillWidth =
                      barWidth < barHeight ? barWidth : barHeight;

                  final fillWidth =
                      rawFillWidth.clamp(minFillWidth, barWidth).toDouble();

                  return SizedBox(
                    width: baseWidth,
                    height: barHeight,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          width: barWidth,
                          height: barHeight,
                          child: ClipRRect(
                            borderRadius: barRadius,
                            child: Stack(
                              children: [
                                const Positioned.fill(
                                  child: ColoredBox(
                                    color: _trackColor,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: fillWidth,
                                    height: barHeight,
                                    decoration: BoxDecoration(
                                      color: _fillColor,
                                      borderRadius: barRadius,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: isSmall ? 8 : 10),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  '$xp / $maxXp XP',
                  maxLines: 1,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: const Color(0xFF536AA0),
                    fontSize: isSmall ? 12 : 14,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

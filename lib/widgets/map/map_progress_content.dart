import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'map_progress_bar.dart';
import 'map_scale_down_text.dart';

class MapProgressContent extends StatelessWidget {
  final int completedCount;
  final int totalCount;
  final double progress;
  final int percentage;
  final bool isSmall;

  const MapProgressContent({
    super.key,
    required this.completedCount,
    required this.totalCount,
    required this.progress,
    required this.percentage,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = AppTextStyles.bodyMedium.copyWith(
      fontSize: isSmall ? 16 : 18,
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
      letterSpacing: 0.6,
      height: 1,
    );

    final valueStyle = AppTextStyles.bodyMedium.copyWith(
      fontSize: isSmall ? 14 : 16,
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
      letterSpacing: 0.4,
      height: 1,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 6,
              child: MapScaleDownText(
                text: 'Progress Perjalanan',
                style: titleStyle,
                alignment: Alignment.centerLeft,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: MapScaleDownText(
                text: '$completedCount/$totalCount Pulau selesai',
                style: valueStyle,
                alignment: Alignment.centerRight,
              ),
            ),
          ],
        ),
        SizedBox(height: isSmall ? 16 : 18),
        Row(
          children: [
            Expanded(
              child: MapProgressBar(
                progress: progress,
                isSmall: isSmall,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '$percentage%',
              maxLines: 1,
              softWrap: false,
              style: valueStyle,
            ),
          ],
        ),
      ],
    );
  }
}

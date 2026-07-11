import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';

class SeaPassportProgressSection extends StatelessWidget {
  final int completedIslandCount;
  final int totalIslandCount;
  final double progressValue;
  final int progressPercent;

  const SeaPassportProgressSection({
    super.key,
    required this.completedIslandCount,
    required this.totalIslandCount,
    required this.progressValue,
    required this.progressPercent,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isSmall ? 12 : 14,
        isSmall ? 14 : 16,
        isSmall ? 12 : 14,
        isSmall ? 14 : 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusXL,
        border: Border.all(
          color: AppColors.primary,
          width: 1.5,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProgressHeader(
            completedIslandCount: completedIslandCount,
            totalIslandCount: totalIslandCount,
            isSmall: isSmall,
          ),
          SizedBox(height: isSmall ? 14 : 16),
          _SegmentedProgressBar(
            completedCount: completedIslandCount,
            totalCount: totalIslandCount,
            isSmall: isSmall,
          ),
          SizedBox(height: isSmall ? 12 : 14),
          _ProgressFooter(
            progressPercent: progressPercent,
            isSmall: isSmall,
          ),
        ],
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  final int completedIslandCount;
  final int totalIslandCount;
  final bool isSmall;

  const _ProgressHeader({
    required this.completedIslandCount,
    required this.totalIslandCount,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = AppTextStyles.bodySmall.copyWith(
      color: AppColors.primary,
      fontSize: isSmall ? 14 : 15,
      fontWeight: FontWeight.w900,
      height: 1,
    );

    return Row(
      children: [
        Expanded(
          child: Text(
            'Progress Belajar',
            style: titleStyle,
          ),
        ),
        Text(
          '$completedIslandCount/$totalIslandCount Pulau',
          style: titleStyle,
        ),
      ],
    );
  }
}

class _SegmentedProgressBar extends StatelessWidget {
  final int completedCount;
  final int totalCount;
  final bool isSmall;

  const _SegmentedProgressBar({
    required this.completedCount,
    required this.totalCount,
    required this.isSmall,
  });

  static const Color _activeColor = Color(0xFF45DE45);
  static const Color _inactiveColor = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final safeTotalCount = totalCount <= 0 ? 1 : totalCount;
    final safeCompletedCount = completedCount.clamp(0, safeTotalCount);

    return Row(
      children: List.generate(safeTotalCount, (index) {
        final isActive = index < safeCompletedCount;

        return Expanded(
          child: Container(
            height: isSmall ? 12 : 13,
            margin: EdgeInsets.only(
              right: index == safeTotalCount - 1 ? 0 : 5,
            ),
            decoration: BoxDecoration(
              color: isActive ? _activeColor : _inactiveColor,
              borderRadius: AppRadius.pill,
            ),
          ),
        );
      }),
    );
  }
}

class _ProgressFooter extends StatelessWidget {
  final int progressPercent;
  final bool isSmall;

  const _ProgressFooter({
    required this.progressPercent,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.caption.copyWith(
      color: AppColors.textGrey,
      fontSize: isSmall ? 10.5 : 11.5,
      fontWeight: FontWeight.w700,
      height: 1.25,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'Terus belajar dan jelajahi lebih banyak pulau',
            style: style,
          ),
        ),
        SizedBox(width: isSmall ? 8 : 10),
        Text(
          '$progressPercent%',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 11 : 12,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ],
    );
  }
}

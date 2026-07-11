import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import 'map_level_content.dart';
import 'map_progress_content.dart';
import 'map_progress_divider.dart';

class MapProgressCard extends StatelessWidget {
  final int completedCount;
  final int totalCount;
  final int level;

  const MapProgressCard({
    super.key,
    required this.completedCount,
    required this.totalCount,
    required this.level,
  });

  double get _progress {
    if (totalCount == 0) return 0;
    return completedCount / totalCount;
  }

  int get _percentage {
    return (_progress * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 380;

        return Container(
          width: double.infinity,
          height: isSmall ? 92 : 100,
          padding: EdgeInsets.fromLTRB(
            isSmall ? 14 : 18,
            13,
            isSmall ? 12 : 14,
            13,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.radiusXL,
            border: Border.all(
              color: AppColors.border,
              width: 1.3,
            ),
            boxShadow: AppShadows.medium,
          ),
          child: Row(
            children: [
              Expanded(
                child: MapProgressContent(
                  completedCount: completedCount,
                  totalCount: totalCount,
                  progress: _progress,
                  percentage: _percentage,
                  isSmall: isSmall,
                ),
              ),
              SizedBox(width: isSmall ? 10 : 14),
              const MapProgressDivider(),
              SizedBox(width: isSmall ? 10 : 14),
              MapLevelContent(
                level: level,
                isSmall: isSmall,
              ),
            ],
          ),
        );
      },
    );
  }
}

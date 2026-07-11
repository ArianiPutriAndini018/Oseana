import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/island_model.dart';
import 'island_status_node.dart';

class MapLegend extends StatelessWidget {
  const MapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 380;

        return Container(
          width: double.infinity,
          height: 48,
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 8 : 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.radiusXL,
            border: Border.all(
              color: AppColors.border,
              width: 1.3,
            ),
            boxShadow: AppShadows.small,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 30,
                child: _LegendItem(
                  status: IslandStatus.completed,
                  label: 'Selesai',
                  isSmall: isSmall,
                ),
              ),
              const _LegendDivider(),
              Expanded(
                flex: 44,
                child: _LegendItem(
                  status: IslandStatus.current,
                  label: 'Sedang dipelajari',
                  isSmall: isSmall,
                ),
              ),
              const _LegendDivider(),
              Expanded(
                flex: 30,
                child: _LegendItem(
                  status: IslandStatus.locked,
                  label: 'Terkunci',
                  isSmall: isSmall,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LegendItem extends StatelessWidget {
  final IslandStatus status;
  final String label;
  final bool isSmall;

  const _LegendItem({
    required this.status,
    required this.label,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IslandStatusNode(
              status: status,
              size: isSmall ? 22 : 25,
              iconSize: isSmall ? 16 : 18,
              borderWidth: 0,
              showBorder: false,
              showShadow: false,
            ),
            SizedBox(width: isSmall ? 6 : 8),
            Text(
              label,
              maxLines: 1,
              softWrap: false,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: isSmall ? 12.5 : 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                letterSpacing: 0.4,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDivider extends StatelessWidget {
  const _LegendDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 34,
      color: AppColors.border,
    );
  }
}

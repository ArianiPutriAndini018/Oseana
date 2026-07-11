import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/biota_model.dart';
import 'checkpoint_biota_grid_item.dart';

class CheckpointBiotaGrid extends StatelessWidget {
  final List<BiotaModel> biotas;
  final String? title;
  final ValueChanged<BiotaModel>? onBiotaTap;

  const CheckpointBiotaGrid({
    super.key,
    required this.biotas,
    this.title,
    this.onBiotaTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isSmall ? 14 : 18,
        isSmall ? 16 : 20,
        isSmall ? 14 : 18,
        isSmall ? 20 : 24,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: AppColors.border,
          width: 1.2,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '${biotas.length} Biota Khas',
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: isSmall ? 14 : 16,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              height: 1,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              biotas.length,
              (index) {
                final biota = biotas[index];

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0 : (isSmall ? 7 : 10),
                      right:
                          index == biotas.length - 1 ? 0 : (isSmall ? 7 : 10),
                    ),
                    child: CheckpointBiotaGridItem(
                      biota: biota,
                      onTap: onBiotaTap == null
                          ? null
                          : () {
                              onBiotaTap!(biota);
                            },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

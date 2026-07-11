import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/island_checkpoint_model.dart';

class IslandDetailHeader extends StatelessWidget {
  final IslandCheckpointModel checkpoint;

  const IslandDetailHeader({
    super.key,
    required this.checkpoint,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Column(
      children: [
        Text(
          checkpoint.title,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: isSmall ? 24 : 27,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          checkpoint.detailSubtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 12 : 14,
            fontWeight: FontWeight.w500,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

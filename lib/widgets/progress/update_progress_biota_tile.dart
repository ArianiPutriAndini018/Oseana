import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/biota_model.dart';

class UpdateProgressBiotaTile extends StatelessWidget {
  final BiotaModel biota;

  const UpdateProgressBiotaTile({
    super.key,
    required this.biota,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmall ? 9 : 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusXL,
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: AppRadius.radiusMD,
            child: Image.asset(
              biota.image,
              width: isSmall ? 76 : 82,
              height: isSmall ? 76 : 82,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: isSmall ? 10 : 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  biota.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontSize: isSmall ? 12 : 13,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                    letterSpacing: 0.2,
                  ),
                ),

                SizedBox(height: isSmall ? 3 : 4),

                Text(
                  '(${biota.scientificName})',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontSize: isSmall ? 9.5 : 10.5,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: isSmall ? 8 : 10),

          _LearnedCheckIcon(
            isLearned: biota.isLearned,
          ),
        ],
      ),
    );
  }
}

class _LearnedCheckIcon extends StatelessWidget {
  final bool isLearned;

  const _LearnedCheckIcon({
    required this.isLearned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: isLearned ? AppColors.success : AppColors.grayMedium,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check_rounded,
        color: AppColors.white,
        size: 19,
      ),
    );
  }
}
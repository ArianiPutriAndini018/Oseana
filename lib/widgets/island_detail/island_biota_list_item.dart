import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/biota_model.dart';

class IslandBiotaListItem extends StatelessWidget {
  final BiotaModel biota;
  final VoidCallback? onTap;

  const IslandBiotaListItem({
    super.key,
    required this.biota,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    final imageSize = isSmall ? 88.0 : 100.0;
    final cardHeight = isSmall ? 112.0 : 124.0;

    return Container(
      width: double.infinity,
      height: cardHeight,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: AppColors.border,
          width: 1.1,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadius.radiusXXL,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.radiusXXL,
          child: Padding(
            padding: EdgeInsets.all(isSmall ? 10 : 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: AppRadius.radiusLG,
                  child: _buildImage(imageSize),
                ),
                SizedBox(width: isSmall ? 12 : 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        biota.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.primary,
                          fontSize: isSmall ? 12 : 14,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '(${biota.scientificName})',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontSize: isSmall ? 10 : 12,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: isSmall ? 6 : 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Pelajari',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontSize: isSmall ? 11 : 12,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.primary,
                      size: isSmall ? 20 : 22,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(double size) {
    if (biota.image.startsWith('http')) {
      return Image.network(
        biota.image,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      biota.image,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}

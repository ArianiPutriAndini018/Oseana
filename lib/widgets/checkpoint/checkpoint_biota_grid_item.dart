import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/biota_model.dart';

class CheckpointBiotaGridItem extends StatelessWidget {
  final BiotaModel biota;
  final VoidCallback? onTap;

  const CheckpointBiotaGridItem({
    super.key,
    required this.biota,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    final item = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: isSmall ? 82 : 92,
          child: ClipRRect(
            borderRadius: AppRadius.radiusLG,
            child: Hero(
              tag: 'biota-image-${biota.id}',
              child: _buildImage(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          biota.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: isSmall ? 8 : 10,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          '(${biota.scientificName})',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: isSmall ? 8 : 10,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            color: AppColors.primary,
            height: 1.25,
          ),
        ),
      ],
    );

    if (onTap == null) return item;

    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.radiusLG,
        child: item,
      ),
    );
  }

  Widget _buildImage() {
    if (biota.image.startsWith('http')) {
      return Image.network(
        biota.image,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        filterQuality: FilterQuality.high,
        errorBuilder: (_, __, ___) {
          return _buildImagePlaceholder();
        },
      );
    }

    return Image.asset(
      biota.image,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      filterQuality: FilterQuality.high,
      errorBuilder: (_, __, ___) {
        return _buildImagePlaceholder();
      },
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: AppColors.blueLight,
      alignment: Alignment.center,
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: 32,
        color: AppColors.primary,
      ),
    );
  }
}

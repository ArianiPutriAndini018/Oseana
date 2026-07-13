import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/biota_model.dart';

class BiotaHeader extends StatelessWidget {
  final BiotaModel biota;

  const BiotaHeader({
    super.key,
    required this.biota,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Column(
      children: [
        Text(
          biota.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.white,
            fontSize: isSmall ? 24 : 27,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '(${biota.scientificName})',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.white,
            fontSize: isSmall ? 16 : 18,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            height: 1.15,
          ),
        ),
      ],
    );
  }
}

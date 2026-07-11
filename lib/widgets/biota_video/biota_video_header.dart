import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/biota_model.dart';

class BiotaVideoHeader extends StatelessWidget {
  final BiotaModel biota;

  const BiotaVideoHeader({
    super.key,
    required this.biota,
  });

  String _spacedText(String value) {
    return value.split('').join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Column(
      children: [
        Text(
          'Video Edukatif',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.white,
            fontSize: isSmall ? 22 : 25,
            fontWeight: FontWeight.w800,
            height: 1,
            shadows: AppShadows.figmaTextShadow2,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _spacedText(biota.name),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.white,
            fontSize: isSmall ? 14 : 17,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
            height: 1,
            shadows: AppShadows.figmaTextShadow2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '(${_spacedText(biota.scientificName)})',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.white,
            fontSize: isSmall ? 10 : 12,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            letterSpacing: 1,
            height: 1,
            shadows: AppShadows.figmaTextShadow2,
          ),
        ),
      ],
    );
  }
}

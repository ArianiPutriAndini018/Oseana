import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../models/learning_mode_type.dart';
import '../../widgets/text/stroke_text.dart';
import 'learning_mode_card.dart';

class LearningModeSection extends StatelessWidget {
  const LearningModeSection({super.key});

  void _openAquariumMode(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.map,
      arguments: const MapRouteArgs(
        learningMode: LearningModeType.aquarium,
      ),
    );
  }

  void _openExploreMode(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.map,
      arguments: const MapRouteArgs(
        learningMode: LearningModeType.explore,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Column(
      children: [
        IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
            child: StrokeText(
              text: 'Pilih Mode Belajar',
              fontSize: isSmall ? 16 : 18,
              style: AppTextStyles.sectionTitle,
              fillColor: AppColors.white,
              strokeColor: AppColors.primary,
              strokeWidth: 4,
              letterSpacing: 0.3,
              shadows: const [],
            ),
          ),
        ),
        AppSpacing.h12,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'Pilih cara belajar dan scan QR di lokasi\natau jelajahi pulau secara mandiri',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: isSmall ? 11 : 13,
              color: AppColors.secondary,
              fontWeight: FontWeight.w700,
              height: 1.35,
              letterSpacing: 0.5,
            ),
          ),
        ),
        AppSpacing.h24,
        LearningModeCard(
          image: AppImages.qrCode,
          title: 'Aquarium Mode',
          description: 'Scan QR di lokasi\nuntuk mulai belajar',
          buttonText: 'Pilih Aquarium Mode',
          backgroundColor: AppColors.aquaLight,
          buttonColor: AppColors.primary,
          onTap: () => _openAquariumMode(context),
        ),
        AppSpacing.h24,
        LearningModeCard(
          image: AppImages.map,
          title: 'Explore Mode',
          description: 'Pilih pulau di peta\ndan belajar mandiri',
          buttonText: 'Pilih Explore Mode',
          backgroundColor: AppColors.mintLight,
          buttonColor: AppColors.teal,
          onTap: () => _openExploreMode(context),
        ),
      ],
    );
  }
}

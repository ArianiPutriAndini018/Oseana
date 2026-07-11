import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../data/checkpoint_data.dart';
import '../../data/island_data.dart';
import '../../models/island_checkpoint_model.dart';
import '../../models/island_model.dart';
import '../../screens/qr_scan/qr_scan_screen.dart';
import '../../widgets/text/stroke_text.dart';
import 'learning_mode_card.dart';

class LearningModeSection extends StatelessWidget {
  const LearningModeSection({super.key});

  static const int _currentBottomNavIndex = 0;

  IslandCheckpointModel? _findCurrentCheckpoint() {
  for (final checkpoint in CheckpointData.checkpoints) {
    return checkpoint;
  }

  return null;
  }

  void _openAquariumMode(BuildContext context) {
    final checkpoint = _findCurrentCheckpoint();

    if (checkpoint == null) {
      AppSnackBar.show(
        context,
        'Checkpoint belum tersedia',
        backgroundColor: AppColors.warning,
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QrScanScreen(
          checkpoint: checkpoint,
        ),
      ),
    );
  }

  void _openExploreMode(BuildContext context) {
    HomeBottomNavAction.handle(
      context: context,
      index: 1,
      currentIndex: _currentBottomNavIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: isSmall ? 18 : 24,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: AppColors.primary,
          width: 3,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.primary,
                  width: 3,
                ),
              ),
            ),
            child: StrokeText(
              text: 'Pilih Mode Belajar',
              fontSize: isSmall ? 12 : 14,
              style: AppTextStyles.sectionTitle,
              fillColor: AppColors.white,
              strokeColor: AppColors.primary,
              strokeWidth: 3,
              letterSpacing: 0.3,
              shadows: const [],
            ),
          ),
          AppSpacing.h16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'Pilih cara belajar dan scan QR di lokasi\n'
              'atau jelajahi pulau secara mandiri',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: isSmall ? 8 : 10,
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
                height: 1.35,
                letterSpacing: 0.5,
              ),
            ),
          ),
          AppSpacing.h24,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 16 : 24,
            ),
            child: LearningModeCard(
              image: AppImages.qrCode,
              title: 'Aquarium Mode',
              description: 'Scan QR di lokasi\nuntuk mulai belajar',
              buttonText: 'Pilih Aquarium Mode',
              backgroundColor: AppColors.aquaLight,
              buttonColor: AppColors.primary,
              onTap: () => _openAquariumMode(context),
            ),
          ),
          AppSpacing.h24,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 16 : 24,
            ),
            child: LearningModeCard(
              image: AppImages.map,
              title: 'Explore Mode',
              description: 'Pilih pulau di peta\ndan belajar mandiri',
              buttonText: 'Pilih Explore Mode',
              backgroundColor: AppColors.mintLight,
              buttonColor: AppColors.teal,
              onTap: () => _openExploreMode(context),
            ),
          ),
        ],
      ),
    );
  }
}

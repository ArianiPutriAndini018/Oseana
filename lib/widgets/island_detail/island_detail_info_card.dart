import 'package:flutter/material.dart';

import '../../core/constants/app_images.dart';
import '../../models/island_checkpoint_model.dart';
import 'island_detail_info_row.dart';
import 'island_detail_progress_bar.dart';
import 'island_detail_progress_header.dart';

class IslandDetailInfoCard extends StatelessWidget {
  final IslandCheckpointModel checkpoint;

  const IslandDetailInfoCard({
    super.key,
    required this.checkpoint,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    final cardHeight = isSmall ? 150.0 : 165.0;

    return SizedBox(
      width: double.infinity,
      height: cardHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth;

          final iconSize = isSmall ? 34.0 : 40.0;
          final iconLeft = cardWidth * 0.07;
          final rightPadding = cardWidth * 0.035;

          final labelWidth = isSmall ? 58.0 : 62.0;
          final gap = isSmall ? 5.0 : 6.0;

          const infoFontSize = 12.0;
          const infoLineHeight = 1.18;

          final temaTop = isSmall ? 20.0 : 24.0;
          final rewardTop = isSmall ? 58.0 : 65.0;

          final rowHeight = iconSize;

          final progressLeft = cardWidth * 0.075;
          final progressRight = cardWidth * 0.075;
          final progressFontSize = isSmall ? 12.0 : 12.5;
          final progressBarHeight = isSmall ? 11.0 : 13.0;
          final progressBarBottom = isSmall ? 14.0 : 17.0;
          final progressTextBottom = progressBarBottom + progressBarHeight + 8;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppImages.bannerBackground,
                  fit: BoxFit.fill,
                ),
              ),

              Positioned(
                left: iconLeft,
                top: temaTop,
                right: rightPadding,
                height: rowHeight,
                child: IslandDetailInfoRow(
                  icon: AppImages.islandDetailTemaIcon,
                  label: 'Tema',
                  value: checkpoint.theme.isEmpty ? '-' : checkpoint.theme,
                  iconSize: iconSize,
                  labelWidth: labelWidth,
                  gap: gap,
                  fontSize: infoFontSize,
                  lineHeight: infoLineHeight,
                  maxLines: 2,
                  iconYOffset: isSmall ? -8 : -10,
                ),
              ),

              Positioned(
                left: iconLeft,
                top: rewardTop,
                right: rightPadding,
                height: rowHeight,
                child: IslandDetailInfoRow(
                  icon: AppImages.islandDetailRewardIcon,
                  label: 'Reward',
                  value: checkpoint.reward.isEmpty ? '-' : checkpoint.reward,
                  iconSize: iconSize,
                  labelWidth: labelWidth,
                  gap: gap,
                  fontSize: infoFontSize,
                  lineHeight: infoLineHeight,
                  maxLines: 1,
                  iconYOffset: isSmall ? -1 : -3,
                ),
              ),

              Positioned(
                left: progressLeft,
                right: progressRight,
                bottom: progressTextBottom,
                child: IslandDetailProgressHeader(
                  learnedBiota: checkpoint.learnedBiota,
                  totalBiota: checkpoint.totalBiota,
                  progressText: checkpoint.progressText,
                  fontSize: progressFontSize,
                ),
              ),

              Positioned(
                left: progressLeft,
                right: progressRight,
                bottom: progressBarBottom,
                child: IslandDetailProgressBar(
                  progress: checkpoint.progress,
                  height: progressBarHeight,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
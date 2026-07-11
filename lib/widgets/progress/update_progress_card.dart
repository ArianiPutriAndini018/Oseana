import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/island_checkpoint_model.dart';
import '../quiz/quiz_title_badge.dart';
import 'update_progress_biota_tile.dart';

class UpdateProgressCard extends StatelessWidget {
  final IslandCheckpointModel checkpoint;

  const UpdateProgressCard({
    super.key,
    required this.checkpoint,
  });

  int get _totalBiota {
    return checkpoint.totalBiota;
  }

  int get _learnedBiota {
    return checkpoint.learnedBiota;
  }

  double get _progressValue {
    if (_totalBiota <= 0) return 0;
    return _learnedBiota / _totalBiota;
  }

  int get _progressPercent {
    return (_progressValue * 100).round();
  }

  String get _progressText {
    return '$_learnedBiota/$_totalBiota biota dipelajari';
  }

  String get _footerText {
    if (checkpoint.isCompleted) {
      return 'Semua biota dari pulau ini telah dipelajari';
    }

    return 'Terus pelajari semua biota dari pulau ini';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            isSmall ? 10 : 12,
            isSmall ? 34 : 38,
            isSmall ? 10 : 12,
            isSmall ? 16 : 18,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppRadius.radiusXXL,
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
            boxShadow: AppShadows.medium,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                checkpoint.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontSize: isSmall ? 24 : 27,
                  fontWeight: FontWeight.w900,
                  height: 1,
                  letterSpacing: 0.7,
                ),
              ),

              SizedBox(height: isSmall ? 18 : 20),

              _ProgressHeader(
                progressText: _progressText,
                progressPercent: _progressPercent,
                isSmall: isSmall,
              ),

              SizedBox(height: isSmall ? 8 : 9),

              _ProgressBar(
                value: _progressValue,
              ),

              SizedBox(height: isSmall ? 18 : 20),

              for (final biota in checkpoint.biotas) ...[
                UpdateProgressBiotaTile(
                  biota: biota,
                ),
                if (biota != checkpoint.biotas.last)
                  SizedBox(height: isSmall ? 12 : 14),
              ],

              SizedBox(height: isSmall ? 16 : 18),

              Text(
                _footerText,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontSize: isSmall ? 11 : 12,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: isSmall ? -31 : -34,
          child: const QuizTitleBadge(
            title: 'Update Progress',
            coralLeft: 40,
            coralRight: 44,
            coralBottom: 5,
          ),
        ),
      ],
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  final String progressText;
  final int progressPercent;
  final bool isSmall;

  const _ProgressHeader({
    required this.progressText,
    required this.progressPercent,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles.bodySmall.copyWith(
      color: AppColors.primary,
      fontSize: isSmall ? 12 : 13,
      fontWeight: FontWeight.w900,
      height: 1,
      letterSpacing: 0.7,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              progressText,
              style: style,
            ),
          ),
          Text(
            '$progressPercent%',
            style: style,
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value;

  const _ProgressBar({
    required this.value,
  });

  static const Color _progressGreen = Color(0xFF45DE45);

  @override
  Widget build(BuildContext context) {
    final resolvedValue = value.clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: AppRadius.pill,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 15,
              color: AppColors.graySoft,
            ),
            FractionallySizedBox(
              widthFactor: resolvedValue,
              child: Container(
                height: 15,
                color: _progressGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
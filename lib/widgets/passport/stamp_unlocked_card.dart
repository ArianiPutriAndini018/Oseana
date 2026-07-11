import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import 'stamp_unlocked_confetti_layer.dart';
import 'stamp_unlocked_stamp.dart';

class StampUnlockedCard extends StatelessWidget {
  final bool isSmall;
  final Animation<double> stampAnimation;
  final Animation<double> idleAnimation;
  final ConfettiController confettiController;

  const StampUnlockedCard({
    super.key,
    required this.isSmall,
    required this.stampAnimation,
    required this.idleAnimation,
    required this.confettiController,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = isSmall ? 440.0 : 462.0;
    final stampSize = isSmall ? 176.0 : 194.0;

    return Container(
      width: double.infinity,
      height: cardHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: StampUnlockedConfettiLayer(
              controller: confettiController,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                isSmall ? 18 : 20,
                isSmall ? 24 : 26,
                isSmall ? 18 : 20,
                isSmall ? 22 : 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Yeeay!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontSize: isSmall ? 35 : 39,
                      fontWeight: FontWeight.w900,
                      height: 1,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: isSmall ? 10 : 12),
                  Text(
                    'Stamp Pulau\nTerbuka!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontSize: isSmall ? 24 : 27,
                      fontWeight: FontWeight.w900,
                      height: 1.15,
                      letterSpacing: 0.8,
                    ),
                  ),
                  SizedBox(height: isSmall ? 16 : 18),
                  StampUnlockedStamp(
                    size: stampSize,
                    stampAnimation: stampAnimation,
                    idleAnimation: idleAnimation,
                  ),
                  SizedBox(height: isSmall ? 16 : 18),
                  Text(
                    'Animasi stamp terbuka\nmasuk ke Sea Passport.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontSize: isSmall ? 13 : 14,
                      fontWeight: FontWeight.w900,
                      height: 1.35,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

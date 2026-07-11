import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';

double _curveValue(
  double value,
  double start,
  double end,
  Curve curve,
) {
  final normalized =
      ((value - start) / (end - start)).clamp(0.0, 1.0).toDouble();

  return curve.transform(normalized);
}

class StampUnlockedStamp extends StatelessWidget {
  final double size;
  final Animation<double> stampAnimation;
  final Animation<double> idleAnimation;

  const StampUnlockedStamp({
    super.key,
    required this.size,
    required this.stampAnimation,
    required this.idleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        stampAnimation,
        idleAnimation,
      ]),
      builder: (context, child) {
        final value = stampAnimation.value;

        final fade = _curveValue(
          value,
          0,
          0.20,
          Curves.easeOut,
        );

        final move = _curveValue(
          value,
          0,
          0.80,
          Curves.easeOutCubic,
        );

        final flip = _curveValue(
          value,
          0,
          0.88,
          Curves.easeOutCubic,
        );

        final pop = _curveValue(
          value,
          0.12,
          1,
          Curves.elasticOut,
        );

        final settle = _curveValue(
          value,
          0.70,
          1,
          Curves.easeOutBack,
        );

        final canIdle = stampAnimation.status == AnimationStatus.completed;
        final idleValue = idleAnimation.value;
        final idleAngle = idleValue * pi * 2;

        final idleRotation = canIdle ? sin(idleAngle) * 0.010 : 0.0;
        final idleY = canIdle ? sin(idleAngle + pi / 2) * 1.2 : 0.0;
        final idleScale = canIdle ? 1 + sin(idleAngle) * 0.004 : 1.0;

        final startY = (1 - move) * -48;
        final settleY = sin(settle * pi) * 4;

        final scale = (0.56 + pop * 0.44) * idleScale;

        final rotationY = (1 - flip) * pi * 4;
        final tiltRotation = (1 - flip) * -0.18;

        final matrix = Matrix4.identity()
          ..setEntry(3, 2, 0.0015)
          ..rotateY(rotationY);

        return Opacity(
          opacity: fade.clamp(0.0, 1.0).toDouble(),
          child: Transform.translate(
            offset: Offset(0, startY + settleY + idleY),
            child: Transform(
              alignment: Alignment.center,
              transform: matrix,
              child: Transform.rotate(
                angle: tiltRotation + idleRotation,
                child: Transform.scale(
                  scale: scale,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _StampGlowPulse(
              size: size,
              idleAnimation: idleAnimation,
            ),
            Image.asset(
              AppImages.quizStampNtt,
              width: size,
              height: size,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

class _StampGlowPulse extends StatelessWidget {
  final double size;
  final Animation<double> idleAnimation;

  const _StampGlowPulse({
    required this.size,
    required this.idleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: idleAnimation,
      builder: (context, child) {
        final pulse = 0.5 + sin(idleAnimation.value * pi * 2) * 0.5;
        final glowSize = size * (0.84 + pulse * 0.04);

        return Container(
          width: glowSize,
          height: glowSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.14 + pulse * 0.06),
                blurRadius: 18 + pulse * 7,
                spreadRadius: 2 + pulse * 2,
              ),
            ],
          ),
        );
      },
    );
  }
}

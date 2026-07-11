import 'dart:math';

import 'package:flutter/material.dart';

class QuizResultAnimatedStar extends StatelessWidget {
  final String asset;
  final double size;
  final double yOffset;
  final Animation<double> fallAnimation;
  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;
  final Animation<double> settleWiggleAnimation;
  final Animation<double> idleWiggleAnimation;
  final double idlePhase;

  const QuizResultAnimatedStar({
    super.key,
    required this.asset,
    required this.size,
    required this.yOffset,
    required this.fallAnimation,
    required this.scaleAnimation,
    required this.fadeAnimation,
    required this.settleWiggleAnimation,
    required this.idleWiggleAnimation,
    required this.idlePhase,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        fallAnimation,
        scaleAnimation,
        fadeAnimation,
        settleWiggleAnimation,
        idleWiggleAnimation,
      ]),
      builder: (context, child) {
        final fallY = (1 - fallAnimation.value) * -44;
        final dropScale = 0.45 + scaleAnimation.value * 0.55;

        final settleValue = settleWiggleAnimation.value;
        final settleRotation = sin(settleValue * pi * 6) *
            (1 - settleValue) *
            0.075;

        final settleScale = 1 + sin(settleValue * pi) * 0.035;

        final canIdle =
            settleWiggleAnimation.status == AnimationStatus.completed;

        final idleValue = idleWiggleAnimation.value;
        final idleAngle = idleValue * pi * 2 + idlePhase;

        final idleRotation = canIdle ? sin(idleAngle) * 0.010 : 0.0;
        final idleY = canIdle ? sin(idleAngle + pi / 2) * 0.45 : 0.0;
        final idleScale = canIdle ? 1 + sin(idleAngle) * 0.003 : 1.0;

        return Opacity(
          opacity: fadeAnimation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, fallY + yOffset + idleY),
            child: Transform.rotate(
              angle: settleRotation + idleRotation,
              child: Transform.scale(
                scale: dropScale * settleScale * idleScale,
                child: child,
              ),
            ),
          ),
        );
      },
      child: Image.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
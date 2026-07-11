import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class SplashBubbleOverlay extends StatefulWidget {
  const SplashBubbleOverlay({super.key});

  @override
  State<SplashBubbleOverlay> createState() => _SplashBubbleOverlayState();
}

class _SplashBubbleOverlayState extends State<SplashBubbleOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_BubbleData> _bubbles;

  static const int _bubbleCount = 32;

  @override
  void initState() {
    super.initState();

    final random = Random(14);

    _bubbles = List.generate(
      _bubbleCount,
      (index) {
        return _BubbleData(
          xFactor: random.nextDouble(),
          delay: random.nextDouble(),
          size: 5 + random.nextDouble() * 18,
          speed: 0.65 + random.nextDouble() * 0.55,
          sway: 8 + random.nextDouble() * 22,
          opacity: 0.18 + random.nextDouble() * 0.34,
          phase: random.nextDouble() * pi * 2,
        );
      },
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _SplashBubblePainter(
                progress: _controller.value,
                bubbles: _bubbles,
              ),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class _SplashBubblePainter extends CustomPainter {
  final double progress;
  final List<_BubbleData> bubbles;

  _SplashBubblePainter({
    required this.progress,
    required this.bubbles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..isAntiAlias = true;

    for (final bubble in bubbles) {
      final rawLife = ((progress * bubble.speed) + bubble.delay) % 1.0;

      final y = size.height + bubble.size - ((size.height + 90) * rawLife);
      final wave = sin((rawLife * pi * 2) + bubble.phase);
      final x = (size.width * bubble.xFactor) + (wave * bubble.sway);

      final fadeIn = (rawLife / 0.18).clamp(0.0, 1.0);
      final fadeOut = ((1.0 - rawLife) / 0.28).clamp(0.0, 1.0);
      final opacity = bubble.opacity * fadeIn * fadeOut;

      final radius = bubble.size / 2;

      fillPaint.color = AppColors.white.withOpacity(opacity * 0.45);
      strokePaint.color = AppColors.white.withOpacity(opacity);

      canvas.drawCircle(
        Offset(x, y),
        radius,
        fillPaint,
      );

      canvas.drawCircle(
        Offset(x, y),
        radius,
        strokePaint,
      );

      canvas.drawCircle(
        Offset(x - radius * 0.25, y - radius * 0.25),
        radius * 0.22,
        Paint()
          ..style = PaintingStyle.fill
          ..isAntiAlias = true
          ..color = AppColors.white.withOpacity(opacity * 0.65),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SplashBubblePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _BubbleData {
  final double xFactor;
  final double delay;
  final double size;
  final double speed;
  final double sway;
  final double opacity;
  final double phase;

  const _BubbleData({
    required this.xFactor,
    required this.delay,
    required this.size,
    required this.speed,
    required this.sway,
    required this.opacity,
    required this.phase,
  });
}
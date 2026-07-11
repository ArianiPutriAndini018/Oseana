import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class QuizResultConfetti extends StatefulWidget {
  final bool isActive;

  const QuizResultConfetti({
    super.key,
    required this.isActive,
  });

  @override
  State<QuizResultConfetti> createState() => _QuizResultConfettiState();
}

class _QuizResultConfettiState extends State<QuizResultConfetti> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();

    _controller = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playIfActive();
    });
  }

  @override
  void didUpdateWidget(covariant QuizResultConfetti oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.isActive && widget.isActive) {
      _playIfActive();
    }
  }

  void _playIfActive() {
    if (!mounted || !widget.isActive) return;
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                emissionFrequency: 0.05,
                numberOfParticles: 18,
                minBlastForce: 12,
                maxBlastForce: 28,
                gravity: 0.22,
                minimumSize: const Size(8, 8),
                maximumSize: const Size(14, 14),
                colors: const [
                  Color(0xFFFFD84D),
                  Color(0xFFFF7A59),
                  Color(0xFF56D7FF),
                  Color(0xFF61E786),
                  AppColors.white,
                ],
                createParticlePath: _drawStar,
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirection: 0,
                blastDirectionality: BlastDirectionality.directional,
                shouldLoop: false,
                emissionFrequency: 0.04,
                numberOfParticles: 10,
                minBlastForce: 10,
                maxBlastForce: 24,
                gravity: 0.18,
                minimumSize: const Size(7, 7),
                maximumSize: const Size(12, 12),
                colors: const [
                  Color(0xFFFFD84D),
                  Color(0xFFFF7A59),
                  Color(0xFF56D7FF),
                  AppColors.white,
                ],
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirection: pi,
                blastDirectionality: BlastDirectionality.directional,
                shouldLoop: false,
                emissionFrequency: 0.04,
                numberOfParticles: 10,
                minBlastForce: 10,
                maxBlastForce: 24,
                gravity: 0.18,
                minimumSize: const Size(7, 7),
                maximumSize: const Size(12, 12),
                colors: const [
                  Color(0xFFFFD84D),
                  Color(0xFFFF7A59),
                  Color(0xFF56D7FF),
                  AppColors.white,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Path _drawStar(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final innerRadius = outerRadius * 0.48;

    for (var i = 0; i < 10; i++) {
      final isOuterPoint = i.isEven;
      final radius = isOuterPoint ? outerRadius : innerRadius;
      final angle = -pi / 2 + i * pi / 5;

      final point = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    path.close();
    return path;
  }
}
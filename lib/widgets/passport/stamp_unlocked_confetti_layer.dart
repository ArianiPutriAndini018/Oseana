import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class StampUnlockedConfettiLayer extends StatelessWidget {
  final ConfettiController controller;

  const StampUnlockedConfettiLayer({
    super.key,
    required this.controller,
  });

  static const List<Color> _mainColors = [
    Color(0xFFFFB300),
    Color(0xFFFF2F3F),
    Color(0xFF0A91FF),
    Color(0xFF00B859),
    Color(0xFF9B5DE5),
  ];

  static const List<Color> _sideColors = [
    Color(0xFFFFB300),
    Color(0xFFFF2F3F),
    Color(0xFF0A91FF),
    Color(0xFF00B859),
  ];

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: controller,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.035,
              numberOfParticles: 14,
              minBlastForce: 8,
              maxBlastForce: 21,
              gravity: 0.18,
              minimumSize: const Size(6, 6),
              maximumSize: const Size(11, 11),
              colors: _mainColors,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: controller,
              blastDirection: 0,
              blastDirectionality: BlastDirectionality.directional,
              shouldLoop: false,
              emissionFrequency: 0.025,
              numberOfParticles: 7,
              minBlastForce: 7,
              maxBlastForce: 15,
              gravity: 0.16,
              minimumSize: const Size(5, 5),
              maximumSize: const Size(10, 10),
              colors: _sideColors,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: controller,
              blastDirection: pi,
              blastDirectionality: BlastDirectionality.directional,
              shouldLoop: false,
              emissionFrequency: 0.025,
              numberOfParticles: 7,
              minBlastForce: 7,
              maxBlastForce: 15,
              gravity: 0.16,
              minimumSize: const Size(5, 5),
              maximumSize: const Size(10, 10),
              colors: _sideColors,
            ),
          ),
        ],
      ),
    );
  }
}

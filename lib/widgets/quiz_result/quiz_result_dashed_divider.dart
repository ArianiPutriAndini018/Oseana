import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class QuizResultDashedDivider extends StatelessWidget {
  const QuizResultDashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _QuizResultDashedDividerPainter(),
      child: const SizedBox(
        width: double.infinity,
        height: 1,
      ),
    );
  }
}

class _QuizResultDashedDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.55)
      ..strokeWidth = 1;

    const dashWidth = 2.5;
    const dashGap = 2.5;

    var x = 0.0;

    while (x < size.width) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + dashWidth, 0),
        paint,
      );

      x += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
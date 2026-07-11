import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class QuizProgressDivider extends StatelessWidget {
  final int currentIndex;
  final int totalCount;

  const QuizProgressDivider({
    super.key,
    required this.currentIndex,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Row(
      children: [
        const Expanded(child: _DashedLine()),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmall ? 9 : 10),
          child: Text(
            '${currentIndex + 1}/$totalCount Soal',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
              fontSize: isSmall ? 11.5 : 12.5,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ),

        const Expanded(child: _DashedLine()),
      ],
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(),
      child: const SizedBox(height: 1),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.45)
      ..strokeWidth = 1;

    const dashWidth = 2.5;
    const dashSpace = 2.5;

    var startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );

      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
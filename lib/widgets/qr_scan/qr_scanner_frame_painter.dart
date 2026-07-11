import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class QrScannerFramePainter extends CustomPainter {
  const QrScannerFramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final scanSize = size.width * 0.62;
    final left = (size.width - scanSize) / 2;
    final top = (size.height - scanSize) / 2;

    final rect = Rect.fromLTWH(
      left,
      top,
      scanSize,
      scanSize,
    );

    final paint = Paint()
      ..color = AppColors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const cornerLength = 34.0;

    final path = Path()
      // kiri atas
      ..moveTo(rect.left, rect.top + cornerLength)
      ..lineTo(rect.left, rect.top)
      ..lineTo(rect.left + cornerLength, rect.top)

      // kanan atas
      ..moveTo(rect.right - cornerLength, rect.top)
      ..lineTo(rect.right, rect.top)
      ..lineTo(rect.right, rect.top + cornerLength)

      // kanan bawah
      ..moveTo(rect.right, rect.bottom - cornerLength)
      ..lineTo(rect.right, rect.bottom)
      ..lineTo(rect.right - cornerLength, rect.bottom)

      // kiri bawah
      ..moveTo(rect.left + cornerLength, rect.bottom)
      ..lineTo(rect.left, rect.bottom)
      ..lineTo(rect.left, rect.bottom - cornerLength);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
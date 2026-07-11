import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'island_decoration_layout.dart';

class MapRouteLayer extends StatelessWidget {
  final double canvasWidth;
  final double canvasHeight;
  final List<String> routeOrder;

  const MapRouteLayer({
    super.key,
    required this.canvasWidth,
    required this.canvasHeight,
    this.routeOrder = const [
      'NTT',
      'NTB',
      'Papua',
      'Jawa',
      'Sumatra',
      'Kalimantan',
      'Sulawesi',
    ],
  });

  @override
  Widget build(BuildContext context) {
    final points = routeOrder.map((name) {
      final layout = IslandDecorationLayout.of(name);

      return Offset(
        canvasWidth * layout.node.dx,
        canvasHeight * layout.node.dy,
      );
    }).toList();

    return Positioned.fill(
      child: CustomPaint(
        painter: _MapRoutePainter(points: points),
      ),
    );
  }
}

class _MapRoutePainter extends CustomPainter {
  final List<Offset> points;

  const _MapRoutePainter({
    required this.points,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    for (int i = 0; i < points.length - 1; i++) {
      _drawDashedCapsuleLine(
        canvas: canvas,
        start: points[i],
        end: points[i + 1],
      );
    }
  }

  void _drawDashedCapsuleLine({
    required Canvas canvas,
    required Offset start,
    required Offset end,
  }) {
    final delta = end - start;
    final distance = delta.distance;

    if (distance == 0) return;

    final angle = delta.direction;

    // Ubah ukuran garis putus-putus dari sini
    const double dashLength = 13;
    const double dashHeight = 6;
    const double gap = 9;
    const double strokeWidth = 1.5;

    final fillPaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final borderPaint = Paint()
      ..color = AppColors.blueDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    double current = 0;

    while (current < distance) {
      final dashCenterDistance = current + dashLength / 2;

      if (dashCenterDistance > distance) break;

      final t = dashCenterDistance / distance;
      final center = Offset.lerp(start, end, t);

      if (center == null) break;

      canvas.save();

      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);

      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: dashLength,
        height: dashHeight,
      );

      final rRect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(999),
      );

      canvas.drawRRect(rRect, fillPaint);
      canvas.drawRRect(rRect, borderPaint);

      canvas.restore();

      current += dashLength + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _MapRoutePainter oldDelegate) {
    if (oldDelegate.points.length != points.length) return true;

    for (int i = 0; i < points.length; i++) {
      if (oldDelegate.points[i] != points[i]) {
        return true;
      }
    }

    return false;
  }
}

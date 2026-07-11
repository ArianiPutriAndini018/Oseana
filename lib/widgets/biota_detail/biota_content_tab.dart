import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/biota_model.dart';

class BiotaContentTab extends StatelessWidget {
  final BiotaContentType type;
  final bool isSelected;
  final VoidCallback onTap;
  final double size;

  const BiotaContentTab({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : AppColors.textSecondary;

    return SizedBox(
      width: size,
      height: size,
      child: _TabSurface(
        child: Material(
          color: Colors.transparent,
          borderRadius: AppRadius.radiusLG,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppRadius.radiusLG,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 9,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _iconByType(type),
                    color: color,
                    size: size <= 76 ? 25 : 28,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    type.label,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: color,
                      fontSize: size <= 65 ? 8.5 : 9.5,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconByType(BiotaContentType type) {
    switch (type) {
      case BiotaContentType.summary:
        return Icons.article_rounded;
      case BiotaContentType.habitat:
        return Icons.home_rounded;
      case BiotaContentType.threat:
        return Icons.warning_rounded;
      case BiotaContentType.funFact:
        return Icons.lightbulb_rounded;
      case BiotaContentType.food:
        return Icons.restaurant_rounded;
    }
  }
}

class _TabSurface extends StatelessWidget {
  final Widget child;

  const _TabSurface({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.radiusLG,
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.radiusLG,
                border: Border.all(
                  color: AppColors.tabBorder,
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
            ),
          ),
          const Positioned.fill(
            child: CustomPaint(
              painter: _InnerShadowPainter(),
            ),
          ),
          Positioned.fill(
            child: child,
          ),
        ],
      ),
    );
  }
}

class _InnerShadowPainter extends CustomPainter {
  const _InnerShadowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = AppRadius.radiusLG.toRRect(rect);

    const offset = Offset(0, 2);
    const blurRadius = 4.0;

    final shadowPaint = Paint()
      ..color = AppColors.tabInnerShadow
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        blurRadius,
      );

    final outerRect = rect.inflate(blurRadius * 2);
    final innerRRect = AppRadius.radiusLG.toRRect(
      rect.shift(offset),
    );

    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(outerRect)
      ..addRRect(innerRRect);

    canvas.save();
    canvas.clipRRect(rrect);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

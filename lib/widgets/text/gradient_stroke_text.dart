import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class GradientStrokeText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final List<Color> gradientColors;
  final Color strokeColor;
  final double strokeWidth;
  final double letterSpacing;
  final double height;
  final TextAlign textAlign;
  final List<Shadow>? shadows;

  const GradientStrokeText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.gradientColors,
    this.fontWeight = FontWeight.w700,
    this.strokeColor = AppColors.white,
    this.strokeWidth = 6,
    this.letterSpacing = -0.5,
    this.height = 1,
    this.textAlign = TextAlign.center,
    this.shadows = const [
      Shadow(
        offset: Offset(0, 4),
        blurRadius: 10,
        color: AppColors.shadowPrimary,
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ).createShader(
          Rect.fromLTWH(
            0,
            0,
            constraints.maxWidth == double.infinity
                ? fontSize * text.length
                : constraints.maxWidth,
            fontSize * 2,
          ),
        );

        return Stack(
          alignment: Alignment.center,
          children: [
            /// Stroke
            Text(
              text,
              textAlign: textAlign,
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: fontSize,
                fontWeight: fontWeight,
                height: height,
                letterSpacing: letterSpacing,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = strokeWidth
                  ..color = strokeColor,
              ),
            ),

            /// Gradient Fill
            Text(
              text,
              textAlign: textAlign,
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: fontSize,
                fontWeight: fontWeight,
                height: height,
                letterSpacing: letterSpacing,
                foreground: Paint()..shader = shader,
                shadows: shadows,
              ),
            ),
          ],
        );
      },
    );
  }
}
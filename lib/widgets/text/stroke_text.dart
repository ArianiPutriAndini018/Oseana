import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextStyle? style;
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;
  final double letterSpacing;
  final double height;
  final TextAlign textAlign;
  final List<Shadow>? shadows;

  const StrokeText({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.w700,
    this.style,
    this.fillColor = AppColors.blueLight,
    this.strokeColor = AppColors.blueDark,
    this.strokeWidth = 6,
    this.letterSpacing = -0.5,
    this.height = 1.0,
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
    final baseStyle = (style ??
            TextStyle(
              fontFamily: 'Fredoka',
              fontWeight: fontWeight,
            ))
        .copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        /// Stroke
        Text(
          text,
          textAlign: textAlign,
          style: baseStyle.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),

        /// Fill
        Text(
          text,
          textAlign: textAlign,
          style: baseStyle.copyWith(
            color: fillColor,
            shadows: shadows,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  final List<Color> colors;
  final Alignment begin;
  final Alignment end;
  final List<double>? stops;

  const GradientText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign = TextAlign.start,
    this.colors = const [
      AppColors.blueBright,
      AppColors.blueDark,
    ],
    this.begin = Alignment.bottomCenter,
    this.end = Alignment.topCenter,
    this.stops = const [0.2731, 0.7819],
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: begin,
          end: end,
          colors: colors,
          stops: stops,
        ).createShader(bounds);
      },
      child: Text(
        text,
        textAlign: textAlign,
        style: style.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
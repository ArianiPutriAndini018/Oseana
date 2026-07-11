import 'package:flutter/material.dart';

class MapScaleDownText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Alignment alignment;

  const MapScaleDownText({
    super.key,
    required this.text,
    required this.style,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: alignment,
      child: Text(
        text,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.visible,
        style: style,
      ),
    );
  }
}

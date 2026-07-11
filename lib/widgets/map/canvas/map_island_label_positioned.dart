import 'package:flutter/material.dart';

import '../../../models/island_model.dart';
import '../island_label.dart';
import 'island_decoration_layout.dart';

class MapIslandLabelPositioned extends StatelessWidget {
  final IslandModel island;
  final double canvasWidth;
  final double canvasHeight;
  final ValueChanged<IslandModel>? onTap;

  const MapIslandLabelPositioned({
    super.key,
    required this.island,
    required this.canvasWidth,
    required this.canvasHeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final layout = IslandDecorationLayout.of(island.name);
    final isSmall = canvasWidth < 380;

    return Positioned(
      left: canvasWidth * layout.label.dx,
      top: canvasHeight * layout.label.dy,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: IslandLabel(
          text: island.name,
          fontSize: _labelFontSize(
            island.name,
            isSmall: isSmall,
          ),
          onTap: onTap == null ? null : () => onTap!(island),
        ),
      ),
    );
  }

  double _labelFontSize(
    String name, {
    required bool isSmall,
  }) {
    final baseSize = isSmall ? 12.5 : 14.0;

    if (name.length >= 9) {
      return baseSize - 0.5;
    }

    return baseSize;
  }
}

import 'package:flutter/material.dart';

import '../../../models/island_model.dart';

class MapIslandImage extends StatelessWidget {
  final IslandModel island;
  final double canvasWidth;
  final double canvasHeight;
  final ValueChanged<IslandModel>? onTap;

  const MapIslandImage({
    super.key,
    required this.island,
    required this.canvasWidth,
    required this.canvasHeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final islandWidth = canvasWidth * island.widthFactor;

    return Positioned(
      left: canvasWidth * island.leftFactor,
      top: canvasHeight * island.topFactor,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap == null ? null : () => onTap!(island),
        child: Image.asset(
          island.image,
          width: islandWidth,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

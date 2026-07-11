import 'package:flutter/material.dart';

import '../../../models/island_model.dart';
import '../island_status_node.dart';
import 'island_decoration_layout.dart';

class MapStatusNodePositioned extends StatelessWidget {
  final IslandModel island;
  final double canvasWidth;
  final double canvasHeight;
  final ValueChanged<IslandModel>? onTap;

  final double? nodeSize;
  final double? iconSize;

  const MapStatusNodePositioned({
    super.key,
    required this.island,
    required this.canvasWidth,
    required this.canvasHeight,
    this.onTap,
    this.nodeSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final layout = IslandDecorationLayout.of(island.name);
    final isSmall = canvasWidth < 380;

    return Positioned(
      left: canvasWidth * layout.node.dx,
      top: canvasHeight * layout.node.dy,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: IslandStatusNode(
          status: island.status,
          size: nodeSize ?? (isSmall ? 34 : 38),
          iconSize: iconSize ?? (isSmall ? 20 : 24),
          borderWidth: 3,
          onTap: onTap == null ? null : () => onTap!(island),
        ),
      ),
    );
  }
}

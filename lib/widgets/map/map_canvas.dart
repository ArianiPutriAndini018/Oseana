import 'dart:math' as math;

import 'package:flutter/material.dart';

import '/core/constants/app_images.dart';
import '/data/island_data.dart';
import '/models/island_model.dart';
import 'canvas/map_island_image.dart';
import 'canvas/map_island_label_positioned.dart';
import 'canvas/map_route_layer.dart';
import 'canvas/map_stars.dart';
import 'canvas/map_status_node_positioned.dart';

class MapCanvas extends StatelessWidget {
  final List<IslandModel> islands;
  final ValueChanged<IslandModel>? onIslandTap;
  final bool showBackground;

  const MapCanvas({
    super.key,
    this.islands = IslandData.islands,
    this.onIslandTap,
    this.showBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;

        final canvasHeight = math.max(
          680.0,
          width * 1.82,
        );

        return SizedBox(
          width: double.infinity,
          height: canvasHeight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              if (showBackground) _buildBackground(),
              MapRouteLayer(
                canvasWidth: width,
                canvasHeight: canvasHeight,
              ),
              for (final island in islands)
                MapIslandImage(
                  island: island,
                  canvasWidth: width,
                  canvasHeight: canvasHeight,
                  onTap: onIslandTap,
                ),
              for (final island in islands)
                if (island.stars > 0)
                  MapStars(
                    island: island,
                    canvasWidth: width,
                    canvasHeight: canvasHeight,
                  ),
              for (final island in islands)
                MapIslandLabelPositioned(
                  island: island,
                  canvasWidth: width,
                  canvasHeight: canvasHeight,
                  onTap: onIslandTap,
                ),
              for (final island in islands)
                MapStatusNodePositioned(
                  island: island,
                  canvasWidth: width,
                  canvasHeight: canvasHeight,
                  onTap: onIslandTap,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Image.asset(
        AppImages.mapBackground,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

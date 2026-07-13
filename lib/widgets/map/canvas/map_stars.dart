import 'package:flutter/material.dart';

import '../../../core/constants/app_images.dart';
import '../../../models/island_model.dart';
import 'island_decoration_layout.dart';

class MapStars extends StatelessWidget {
  final IslandModel island;
  final double canvasWidth;
  final double canvasHeight;

  const MapStars({
    super.key,
    required this.island,
    required this.canvasWidth,
    required this.canvasHeight,
  });

  @override
  Widget build(BuildContext context) {
    final layout = IslandDecorationLayout.of(island.name);

    final starsPosition = layout.stars ??
        Offset(
          layout.label.dx,
          layout.label.dy - 0.05,
        );

    Widget starImage = Image.asset(
      _starAsset,
      width: canvasWidth * _starWidthFactor,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );

    if (island.stars <= 0) {
      starImage = ColorFiltered(
        colorFilter: const ColorFilter.mode(
          Colors.grey,
          BlendMode.srcIn,
        ),
        child: starImage,
      );
    }

    return Positioned(
      left: canvasWidth * starsPosition.dx,
      top: canvasHeight * starsPosition.dy,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: starImage,
      ),
    );
  }

  String get _starAsset {
    switch (island.stars) {
      case 1:
        return AppImages.mapStar1;
      case 2:
        return AppImages.mapStar2;
      case 3:
        return AppImages.mapStar3;
      default:
        return AppImages.mapStar3;
    }
  }

  double get _starWidthFactor {
    switch (island.stars) {
      case 1:
        return 0.055;
      case 2:
        return 0.085;
      case 3:
        return 0.12;
      default:
        return 0.12;
    }
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/app_text_styles.dart';
import '../../models/island_model.dart';
import 'map_canvas.dart';
import 'map_legend.dart';
import 'map_progress_card.dart';

class MapContent extends StatelessWidget {
  final int completedCount;
  final int totalCount;
  final int level;
  final List<IslandModel> islands;
  final ValueChanged<IslandModel> onIslandTap;

  const MapContent({
    super.key,
    required this.completedCount,
    required this.totalCount,
    required this.level,
    required this.islands,
    required this.onIslandTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 84, 16, 130),
        child: Column(
          children: [
            Text(
              'Ocean Journey Map',
              textAlign: TextAlign.center,
              style: AppTextStyles.mapTitle,
            ),
            const SizedBox(height: 22),
            MapProgressCard(
              completedCount: completedCount,
              totalCount: totalCount,
              level: level,
            ),
            const SizedBox(height: 14),
            const MapLegend(),
            const SizedBox(height: 8),
            MapCanvas(
              islands: islands,
              showBackground: false,
              onIslandTap: onIslandTap,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/controllers/audio_controller.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../data/checkpoint_data.dart';
import '../../data/island_data.dart';
import '../../models/island_model.dart';
import '../../models/learning_mode_type.dart';
import '../../widgets/map/map_background.dart';
import '../../widgets/map/map_content.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../checkpoint/island_checkpoint_screen.dart';

class MapScreen extends StatefulWidget {
  final LearningModeType learningMode;

  const MapScreen({
    super.key,
    this.learningMode = LearningModeType.explore,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const int _currentIndex = 1;

  @override
  void initState() {
    super.initState();

    unawaited(
      AudioController.instance.playMapMusic(),
    );
  }

  int get _completedCount {
    return IslandData.islands
        .where((island) => island.status == IslandStatus.completed)
        .length;
  }

  void _handleBack() {
    unawaited(
      AudioController.instance.playAppBacksound(),
    );

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  void _onIslandTap(IslandModel island) {
    switch (island.status) {
      case IslandStatus.completed:
      case IslandStatus.current:
        final checkpoint = CheckpointData.findCheckpointByIslandId(
          island.name,
        );

        if (checkpoint == null) {
          AppSnackBar.show(
            context,
            'Checkpoint ${island.name} belum tersedia',
            backgroundColor: AppColors.warning,
          );
          return;
        }

        unawaited(
          _openCheckpoint(island),
        );
        break;

      case IslandStatus.locked:
        AppSnackBar.show(
          context,
          '${island.name} masih terkunci',
          backgroundColor: AppColors.grayDark,
        );
        break;
    }
  }

  Future<void> _openCheckpoint(IslandModel island) async {
    unawaited(
      AudioController.instance.playAppBacksound(),
    );

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IslandCheckpointScreen(
          island: island,
          learningMode: widget.learningMode,
        ),
      ),
    );

    if (!mounted) return;

    final route = ModalRoute.of(context);

    if (route == null || !route.isCurrent) return;

    unawaited(
      AudioController.instance.playMapMusic(),
    );
  }

  void _onBottomNavTap(int index) {
    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      extendBody: true,
      body: Stack(
        children: [
          const MapBackground(),
          MapContent(
            completedCount: _completedCount,
            totalCount: IslandData.islands.length,
            level: 1,
            onIslandTap: _onIslandTap,
          ),
          ScreenBackButton(
            onPressed: _handleBack,
          ),
          FloatingHomeBottomNav(
            currentIndex: _currentIndex,
            onTap: _onBottomNavTap,
          ),
        ],
      ),
    );
  }
}
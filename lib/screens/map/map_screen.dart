import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/controllers/audio_controller.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/auth_service.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../data/checkpoint_data.dart';
import '../../data/island_data.dart';
import '../../data/repositories/passport_repository.dart';
import '../../data/repositories/quiz_repository.dart';
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

  final _passportRepository = PassportRepository();
  final _authService = AuthService();
  List<IslandModel> _islands = IslandData.islands;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    unawaited(
      AudioController.instance.playMapMusic(),
    );

    unawaited(_loadIslands());
  }

  Future<void> _loadIslands() async {
    final userId = _authService.currentUser?.id;

    try {
      final stamps = await _passportRepository.getStamps(userId);
      final unlockedIds = stamps
          .where((s) => s.isUnlocked)
          .map((s) => s.id)
          .toSet();

      Map<String, int> userStars = {};
      if (userId != null) {
        userStars = await QuizRepository().getUserStars(userId);
      }

      final updated = <IslandModel>[];
      var currentAssigned = false;

      for (final island in IslandData.islands) {
        IslandStatus status;
        int stars = island.stars;

        if (unlockedIds.contains(island.id)) {
          status = IslandStatus.completed;
          stars = userStars[island.id] ?? 0;
        } else if (!currentAssigned) {
          status = IslandStatus.current;
          currentAssigned = true;
          stars = userStars[island.id] ?? 0;
        } else {
          status = IslandStatus.locked;
          stars = 0;
        }

        updated.add(
          IslandModel(
            id: island.id,
            name: island.name,
            image: island.image,
            status: status,
            leftFactor: island.leftFactor,
            topFactor: island.topFactor,
            widthFactor: island.widthFactor,
            stars: stars,
          ),
        );
      }

      if (!mounted) return;

      setState(() {
        _islands = updated;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  int get _completedCount {
    return _islands
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
            totalCount: _islands.length,
            level: 1,
            islands: _islands,
            onIslandTap: _onIslandTap,
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
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
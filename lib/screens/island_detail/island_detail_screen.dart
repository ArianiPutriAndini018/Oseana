import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/ocean_page_route.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../data/repositories/checkpoint_repository.dart';
import '../../models/biota_model.dart';
import '../../models/island_checkpoint_model.dart';
import '../../models/learning_mode_type.dart';
import '../../widgets/island_detail/island_detail_content.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../biota_detail/biota_detail_screen.dart';
import '../quiz/quiz_screen.dart';

class IslandDetailScreen extends StatefulWidget {
  final IslandCheckpointModel checkpoint;
  final LearningModeType learningMode;

  const IslandDetailScreen({
    super.key,
    required this.checkpoint,
    this.learningMode = LearningModeType.explore,
  });

  @override
  State<IslandDetailScreen> createState() {
    return _IslandDetailScreenState();
  }
}

class _IslandDetailScreenState
    extends State<IslandDetailScreen> {
  static const int _currentIndex = 1;

  late IslandCheckpointModel
      _currentCheckpoint;

  @override
  void initState() {
    super.initState();

    _currentCheckpoint =
        widget.checkpoint;
  }

  Future<void> _refreshCheckpoint() async {
    await CheckpointRepository()
        .loadAllCheckpoints();

    final updated =
        CheckpointRepository
            .cachedCheckpoints
            .firstWhere(
      (checkpoint) {
        return checkpoint.id ==
            _currentCheckpoint.id;
      },
      orElse: () {
        return _currentCheckpoint;
      },
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _currentCheckpoint = updated;
    });
  }

  Future<void> _onBiotaTap(
    BuildContext context,
    BiotaModel biota,
  ) async {
    await Navigator.push(
      context,
      OceanPageRoute(
        builder: (_) => BiotaDetailScreen(
          checkpoint: _currentCheckpoint,
          biota: biota,
          learningMode:
              widget.learningMode,
        ),
      ),
    );

    await _refreshCheckpoint();
  }

  void _onQuizPressed(
    BuildContext context,
  ) {
    Navigator.push(
      context,
      OceanPageRoute(
        builder: (_) => QuizScreen(
          checkpoint: _currentCheckpoint,
          learningMode:
              widget.learningMode,
        ),
      ),
    );
  }

  void _onBottomNavTap(
    BuildContext context,
    int index,
  ) {
    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _currentIndex,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      extendBody: true,
      body: Stack(
        children: [
          IslandDetailContent(
            checkpoint: _currentCheckpoint,
            onBiotaTap: (biota) {
              _onBiotaTap(
                context,
                biota,
              );
            },
            onQuizPressed: () {
              _onQuizPressed(
                context,
              );
            },
          ),
          const ScreenBackButton(),
          FloatingHomeBottomNav(
            currentIndex: _currentIndex,
            onTap: (index) {
              _onBottomNavTap(
                context,
                index,
              );
            },
          ),
        ],
      ),
    );
  }
}
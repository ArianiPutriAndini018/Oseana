import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../models/biota_model.dart';
import '../../models/island_checkpoint_model.dart';
import '../../widgets/island_detail/island_detail_content.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../biota_detail/biota_detail_screen.dart';
import '../quiz/quiz_screen.dart';

class IslandDetailScreen extends StatelessWidget {
  final IslandCheckpointModel checkpoint;

  const IslandDetailScreen({
    super.key,
    required this.checkpoint,
  });

  static const int _currentIndex = 1;

  void _onBiotaTap(
    BuildContext context,
    BiotaModel biota,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BiotaDetailScreen(
          checkpoint: checkpoint,
          biota: biota,
        ),
      ),
    );
  }

  void _onQuizPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(checkpoint: checkpoint),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      extendBody: true,
      body: Stack(
        children: [
          IslandDetailContent(
            checkpoint: checkpoint,
            onBiotaTap: (biota) {
              _onBiotaTap(
                context,
                biota,
              );
            },
            onQuizPressed: () {
              _onQuizPressed(context);
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

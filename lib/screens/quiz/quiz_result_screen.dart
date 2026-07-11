import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../models/island_checkpoint_model.dart';
import '../../widgets/backgrounds/animated_splash_background.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../../widgets/quiz_result/quiz_result_confetti.dart';
import '../../widgets/quiz_result/quiz_result_content.dart';
import '../map/map_screen.dart';
import '../progress/update_progress_screen.dart';
import 'quiz_screen.dart';

class QuizResultScreen extends StatelessWidget {
  final IslandCheckpointModel checkpoint;
  final int score;
  final int totalCount;
  final int xpReward;

  const QuizResultScreen({
    super.key,
    required this.checkpoint,
    required this.score,
    required this.totalCount,
    this.xpReward = 15,
  });

  static const int _bottomNavIndex = 1;

  bool get _isPerfectScore {
    return totalCount > 0 && score == totalCount;
  }

  void _onPassportPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => UpdateProgressScreen(
          checkpoint: checkpoint,
        ),
      ),
    );
  }

  void _onRetryPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          checkpoint: checkpoint,
        ),
      ),
    );
  }

  void _onBackToMapPressed(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const MapScreen(),
      ),
      (route) => route.isFirst,
    );
  }

  void _onBottomNavTap(BuildContext context, int index) {
    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _bottomNavIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBody: true,
      body: Stack(
        children: [
          const AnimatedSplashBackground(),

          QuizResultContent(
            title: 'Hasil Kuis',
            score: score,
            totalCount: totalCount,
            xpReward: xpReward,
            onPassportPressed: () => _onPassportPressed(context),
            onRetryPressed: () => _onRetryPressed(context),
            onBackToMapPressed: () => _onBackToMapPressed(context),
          ),

          QuizResultConfetti(
            isActive: _isPerfectScore,
          ),

          const ScreenBackButton(),

          FloatingHomeBottomNav(
            currentIndex: _bottomNavIndex,
            onTap: (index) => _onBottomNavTap(context, index),
          ),
        ],
      ),
    );
  }
}
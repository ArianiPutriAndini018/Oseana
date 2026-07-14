import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../models/island_checkpoint_model.dart';
import '../../widgets/backgrounds/animated_splash_background.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../../widgets/progress/update_progress_content.dart';
import '../passport/stamp_unlocked_screen.dart';
import '../../core/routes/ocean_page_route.dart';

class UpdateProgressScreen extends StatelessWidget {
  final IslandCheckpointModel checkpoint;

  const UpdateProgressScreen({
    super.key,
    required this.checkpoint,
  });

  static const int _bottomNavIndex = 1;

  void _onContinuePressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      OceanPageRoute(
        builder: (_) => StampUnlockedScreen(
          checkpoint: checkpoint,
        ),
      ),
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
          UpdateProgressContent(
            checkpoint: checkpoint,
            onContinuePressed: () => _onContinuePressed(context),
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

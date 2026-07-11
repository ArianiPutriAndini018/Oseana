import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../models/island_checkpoint_model.dart';
import '../../widgets/backgrounds/animated_splash_background.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../../widgets/passport/sea_passport_content.dart';

class SeaPassportScreen extends StatelessWidget {
  final IslandCheckpointModel? checkpoint;
  final bool openedFromBottomNav;

  const SeaPassportScreen({
    super.key,
    this.checkpoint,
    this.openedFromBottomNav = false,
  });

  static const int _bottomNavIndex = 2;

  void _handleBack(BuildContext context) {
    if (openedFromBottomNav) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
      return;
    }

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

  Future<bool> _onWillPop(BuildContext context) async {
    _handleBack(context);
    return false;
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
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        extendBody: true,
        body: Stack(
          children: [
            const AnimatedSplashBackground(),
            const SeaPassportContent(),
            ScreenBackButton(
              onPressed: () => _handleBack(context),
            ),
            FloatingHomeBottomNav(
              currentIndex: _bottomNavIndex,
              onTap: (index) => _onBottomNavTap(context, index),
            ),
          ],
        ),
      ),
    );
  }
}

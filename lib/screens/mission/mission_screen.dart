import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../widgets/mission/mission_content.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../home/home_screen.dart';
import '../../core/routes/ocean_page_route.dart';

class MissionScreen extends StatelessWidget {
  final bool openedFromBottomNav;

  const MissionScreen({
    super.key,
    this.openedFromBottomNav = false,
  });

  static const int _bottomNavIndex = 3;

  void _handleBack(BuildContext context) {
    if (openedFromBottomNav) {
      Navigator.pushAndRemoveUntil(
        context,
        OceanPageRoute(
          builder: (_) => const HomeScreen(),
        ),
        (route) => false,
      );
      return;
    }

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      OceanPageRoute(
        builder: (_) => const HomeScreen(),
      ),
      (route) => false,
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
    return WillPopScope(
      onWillPop: () async {
        _handleBack(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        extendBody: true,
        body: Stack(
          children: [
            const MissionContent(),
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

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../../widgets/profile/profile_content.dart';

class ProfileScreen extends StatelessWidget {
  final bool openedFromBottomNav;

  const ProfileScreen({
    super.key,
    this.openedFromBottomNav = false,
  });

  static const int _bottomNavIndex = 4;

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

  void _handleBottomNavTap(
    BuildContext context,
    int index,
  ) {
    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _bottomNavIndex,
    );
  }

  void _handleEditProfile(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.editProfile,
    );
  }

  void _handleMenuTap(
    BuildContext context,
    String menuId,
  ) {
    String message;

    switch (menuId) {
      case 'settings':
        Navigator.pushNamed(
          context,
          AppRoutes.settings,
        );
        return;
      case 'faq':
        Navigator.pushNamed(context, AppRoutes.faq);
        return;

      case 'about':
        Navigator.pushNamed(context, AppRoutes.aboutOseana);
        return;

      default:
        message = 'Menu akan dibuat nanti';
        break;
    }

    AppSnackBar.show(
      context,
      message,
      backgroundColor: AppColors.primary,
    );
  }

  void _handleLogout(BuildContext context) {
    AppSnackBar.show(
      context,
      'Fitur keluar akan dihubungkan nanti',
      backgroundColor: AppColors.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          ProfileContent(
            onEditProfile: () => _handleEditProfile(context),
            onMenuTap: (menuId) => _handleMenuTap(
              context,
              menuId,
            ),
            onLogout: () => _handleLogout(context),
          ),
          ScreenBackButton(
            onPressed: () => _handleBack(context),
          ),
          FloatingHomeBottomNav(
            currentIndex: _bottomNavIndex,
            onTap: (index) => _handleBottomNavTap(
              context,
              index,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/controllers/user_profile_controller.dart';
import '../../data/profile_data.dart';
import 'profile_logout_button.dart';
import 'profile_menu_card.dart';
import 'profile_summary_card.dart';

class ProfileContent extends StatelessWidget {
  final VoidCallback onEditProfile;
  final ValueChanged<String> onMenuTap;
  final VoidCallback onLogout;

  const ProfileContent({
    super.key,
    required this.onEditProfile,
    required this.onMenuTap,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return AnimatedBuilder(
      animation: UserProfileController.instance,
      builder: (context, _) {
        final profileController = UserProfileController.instance;

        return SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              isSmall ? 18 : 22,
              isSmall ? 82 : 92,
              isSmall ? 18 : 22,
              150,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Profil Pengguna',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.blueDark,
                    fontSize: isSmall ? 24 : 28,
                    fontWeight: FontWeight.w900,
                    height: 1,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: isSmall ? 28 : 34),
                ProfileSummaryCard(
                  userName: profileController.userName,
                  avatar: profileController.avatar,
                  level: profileController.level,
                  title: profileController.title,
                  xp: profileController.xp,
                  maxXp: profileController.maxXp,
                  xpProgressValue: profileController.xpProgressValue,
                  topStats: profileController.topStats,
                  bottomStats: profileController.bottomStats,
                  onEditProfile: onEditProfile,
                ),
                SizedBox(height: isSmall ? 42 : 50),
                ProfileMenuCard(
                  menus: ProfileData.orderedMenus,
                  onMenuTap: onMenuTap,
                ),
                SizedBox(height: isSmall ? 44 : 54),
                ProfileLogoutButton(
                  onPressed: onLogout,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

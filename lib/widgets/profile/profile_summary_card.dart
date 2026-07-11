import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../models/profile_stat_model.dart';
import 'profile_main_info.dart';
import 'profile_stat_rows.dart';

class ProfileSummaryCard extends StatelessWidget {
  final String userName;
  final String avatar;
  final String level;
  final String title;
  final int xp;
  final int maxXp;
  final double xpProgressValue;
  final List<ProfileStatModel> topStats;
  final List<ProfileStatModel> bottomStats;
  final VoidCallback onEditProfile;

  const ProfileSummaryCard({
    super.key,
    required this.userName,
    required this.avatar,
    required this.level,
    required this.title,
    required this.xp,
    required this.maxXp,
    required this.xpProgressValue,
    required this.topStats,
    required this.bottomStats,
    required this.onEditProfile,
  });

  static const Color _dividerColor = Color(0xFFD3E1F0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: AppColors.primary,
          width: 3.5,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              isSmall ? 16 : 20,
              isSmall ? 24 : 28,
              isSmall ? 16 : 20,
              isSmall ? 20 : 24,
            ),
            child: ProfileMainInfo(
              userName: userName,
              avatar: avatar,
              level: level,
              title: title,
              xp: xp,
              maxXp: maxXp,
              xpProgressValue: xpProgressValue,
              isSmall: isSmall,
              onEditProfile: onEditProfile,
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1.4,
            color: _dividerColor,
          ),
          ProfileTopStatsRow(
            stats: topStats,
            isSmall: isSmall,
          ),
          const Divider(
            height: 1,
            thickness: 1.4,
            color: _dividerColor,
          ),
          ProfileBottomStatsRow(
            stats: bottomStats,
            isSmall: isSmall,
          ),
        ],
      ),
    );
  }
}

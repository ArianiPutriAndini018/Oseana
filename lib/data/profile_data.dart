import 'package:flutter/material.dart';

import '../core/constants/app_images.dart';
import '../models/profile_menu_model.dart';
import '../models/profile_stat_model.dart';

class ProfileData {
  ProfileData._();

  static const String userId = 'user_001';

  static const String userName = 'Cassie';
  static const String avatar = AppImages.avatarCrab;

  static const String level = 'Level 1';
  static const int levelNumber = 1;
  static const String title = 'Penjelajah Pemula';

  static const int xp = 20;
  static const int maxXp = 150;

  static double get xpProgressValue {
    if (maxXp <= 0) return 0;
    return xp / maxXp;
  }

  static int get xpProgressPercent {
    return (xpProgressValue * 100).round();
  }

  static const List<ProfileStatModel> topStats = [
    ProfileStatModel(
      id: 'islands_learned',
      title: 'Pulau Dipelajari',
      value: '1/7',
      iconKey: 'island',
      iconAsset: AppImages.profileIslandIcon,
      fallbackIcon: Icons.beach_access_rounded,
      fallbackIconColor: Color(0xFFFFB703),
      order: 1,
    ),
    ProfileStatModel(
      id: 'total_stars',
      title: 'Total Bintang',
      value: '3/21',
      iconKey: 'star',
      iconAsset: AppImages.profileStarIcon,
      fallbackIcon: Icons.star_rounded,
      fallbackIconColor: Color(0xFFFFB703),
      order: 2,
    ),
    ProfileStatModel(
      id: 'biota_learned',
      title: 'Biota Dipelajari',
      value: '1/21',
      iconKey: 'biota',
      iconAsset: AppImages.profileBiotaLearnedIcon,
      fallbackIcon: Icons.menu_book_rounded,
      fallbackIconColor: Color(0xFF0A66D6),
      order: 3,
    ),
    ProfileStatModel(
      id: 'missions_done',
      title: 'Misi Selesai',
      value: '3/21',
      iconKey: 'mission',
      iconAsset: AppImages.profileMissionCompleteIcon,
      fallbackIcon: Icons.fact_check_rounded,
      fallbackIconColor: Color(0xFF00A84F),
      order: 4,
    ),
  ];

  static const List<ProfileStatModel> bottomStats = [
    ProfileStatModel(
      id: 'badges_earned',
      title: 'Badge Diperoleh',
      value: '3/16',
      iconKey: 'badge',
      iconAsset: AppImages.profileBadgeIcon,
      fallbackIcon: Icons.workspace_premium_rounded,
      fallbackIconColor: Color(0xFFFFB703),
      order: 1,
    ),
    ProfileStatModel(
      id: 'stamps_collected',
      title: 'Stamp Terkumpul',
      value: '1/9',
      iconKey: 'stamp',
      iconAsset: AppImages.profileStampIcon,
      fallbackIcon: Icons.approval_rounded,
      fallbackIconColor: Color(0xFF0A66D6),
      order: 2,
    ),
  ];

  static const List<ProfileMenuModel> menus = [
    ProfileMenuModel(
      id: 'settings',
      title: 'Pengaturan',
      iconKey: 'settings',
      iconAsset: null,
      fallbackIcon: Icons.settings_rounded,
      order: 1,
    ),
    ProfileMenuModel(
      id: 'faq',
      title: 'Bantuan & FAQ',
      iconKey: 'faq',
      iconAsset: null,
      fallbackIcon: Icons.help_rounded,
      order: 2,
    ),
    ProfileMenuModel(
      id: 'about',
      title: 'Tentang Oseana Quest',
      iconKey: 'about',
      iconAsset: null,
      fallbackIcon: Icons.info_rounded,
      order: 3,
    ),
  ];

  static List<ProfileStatModel> get orderedTopStats {
    final result = [...topStats];
    result.sort((a, b) => a.order.compareTo(b.order));
    return result;
  }

  static List<ProfileStatModel> get orderedBottomStats {
    final result = [...bottomStats];
    result.sort((a, b) => a.order.compareTo(b.order));
    return result;
  }

  static List<ProfileMenuModel> get orderedMenus {
    final result = [...menus];
    result.sort((a, b) => a.order.compareTo(b.order));
    return result;
  }
}

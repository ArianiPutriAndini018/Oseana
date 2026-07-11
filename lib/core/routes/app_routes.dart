import 'package:flutter/material.dart';

import '../../models/island_checkpoint_model.dart';
import '../../screens/about/about_oseana_screen.dart';
import '../../screens/faq/faq_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/map/map_screen.dart';
import '../../screens/mission/mission_list_screen.dart';
import '../../screens/mission/mission_screen.dart';
import '../../screens/passport/sea_passport_screen.dart';
import '../../screens/profile/edit_profile_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/qr_scan/qr_scan_screen.dart';
import '../../screens/settings/settings_screen.dart';

class SeaPassportRouteArgs {
  final IslandCheckpointModel? checkpoint;
  final bool openedFromBottomNav;

  const SeaPassportRouteArgs({
    this.checkpoint,
    this.openedFromBottomNav = false,
  });
}

class MissionRouteArgs {
  final bool openedFromBottomNav;

  const MissionRouteArgs({
    this.openedFromBottomNav = false,
  });
}

class ProfileRouteArgs {
  final bool openedFromBottomNav;

  const ProfileRouteArgs({
    this.openedFromBottomNav = false,
  });
}

class QrScanRouteArgs {
  final IslandCheckpointModel checkpoint;

  const QrScanRouteArgs({
    required this.checkpoint,
  });
}

class AppRoutes {
  AppRoutes._();

  static const String home = '/home';
  static const String map = '/map';
  static const String passport = '/passport';
  static const String mission = '/mission';
  static const String missionList = '/mission-list';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String faq = '/faq';
  static const String aboutOseana = '/about-oseana';
  static const String qrScanner = '/qr-scanner';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _buildRoute(
          settings,
          const HomeScreen(),
        );

      case map:
        return _buildRoute(
          settings,
          const MapScreen(),
        );

      case passport:
        return _buildSeaPassportRoute(settings);

      case mission:
        return _buildMissionRoute(settings);

      case AppRoutes.missionList:
        return _buildRoute(
          settings,
          const MissionListScreen(),
        );

      case profile:
        return _buildProfileRoute(settings);

      case editProfile:
        return _buildRoute(
          settings,
          const EditProfileScreen(),
        );

      case AppRoutes.settings:
        return _buildRoute(
          settings,
          const SettingsScreen(),
        );

      case AppRoutes.faq:
        return _buildRoute(
          settings,
          const FaqScreen(),
        );

      case AppRoutes.aboutOseana:
        return _buildRoute(
          settings,
          const AboutOseanaScreen(),
        );

      case AppRoutes.qrScanner:
        return _buildQrScanRoute(settings);

      default:
        return _buildRoute(
          settings,
          const HomeScreen(),
        );
    }
  }

  static Route<dynamic> _buildSeaPassportRoute(RouteSettings settings) {
    final args = settings.arguments;

    IslandCheckpointModel? checkpoint;
    bool openedFromBottomNav = false;

    if (args is SeaPassportRouteArgs) {
      checkpoint = args.checkpoint;
      openedFromBottomNav = args.openedFromBottomNav;
    }

    if (args is IslandCheckpointModel) {
      checkpoint = args;
    }

    return _buildRoute(
      settings,
      SeaPassportScreen(
        checkpoint: checkpoint,
        openedFromBottomNav: openedFromBottomNav,
      ),
    );
  }

  static Route<dynamic> _buildMissionRoute(RouteSettings settings) {
    final args = settings.arguments;

    bool openedFromBottomNav = false;

    if (args is MissionRouteArgs) {
      openedFromBottomNav = args.openedFromBottomNav;
    }

    return _buildRoute(
      settings,
      MissionScreen(
        openedFromBottomNav: openedFromBottomNav,
      ),
    );
  }

  static Route<dynamic> _buildProfileRoute(RouteSettings settings) {
    final args = settings.arguments;

    bool openedFromBottomNav = false;

    if (args is ProfileRouteArgs) {
      openedFromBottomNav = args.openedFromBottomNav;
    }

    return _buildRoute(
      settings,
      ProfileScreen(
        openedFromBottomNav: openedFromBottomNav,
      ),
    );
  }

  static Route<dynamic> _buildQrScanRoute(RouteSettings settings) {
    final args = settings.arguments;

    IslandCheckpointModel? checkpoint;

    if (args is QrScanRouteArgs) {
      checkpoint = args.checkpoint;
    }

    if (args is IslandCheckpointModel) {
      checkpoint = args;
    }

    if (checkpoint == null) {
      return _buildRoute(
        settings,
        const MapScreen(),
      );
    }

    return _buildRoute(
      settings,
      QrScanScreen(
        checkpoint: checkpoint,
      ),
    );
  }

  static MaterialPageRoute _buildRoute(
    RouteSettings settings,
    Widget screen,
  ) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => screen,
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';

import '../controllers/audio_controller.dart';
import '../routes/app_routes.dart';

class HomeBottomNavAction {
  HomeBottomNavAction._();

  static void handle({
    required BuildContext context,
    required int index,
    required int currentIndex,
  }) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        unawaited(
          AudioController.instance.playAppBacksound(),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
        );
        break;

      case 1:
        unawaited(
          AudioController.instance.playMapMusic(),
        );

        Navigator.pushNamed(
          context,
          AppRoutes.map,
        );
        break;

      case 2:
        unawaited(
          AudioController.instance.playAppBacksound(),
        );

        Navigator.pushNamed(
          context,
          AppRoutes.passport,
          arguments: const SeaPassportRouteArgs(
            openedFromBottomNav: true,
          ),
        );
        break;

      case 3:
        unawaited(
          AudioController.instance.playAppBacksound(),
        );

        Navigator.pushNamed(
          context,
          AppRoutes.mission,
          arguments: const MissionRouteArgs(
            openedFromBottomNav: true,
          ),
        );
        break;

      case 4:
        unawaited(
          AudioController.instance.playAppBacksound(),
        );

        Navigator.pushNamed(
          context,
          AppRoutes.profile,
          arguments: const ProfileRouteArgs(
            openedFromBottomNav: true,
          ),
        );
        break;

      default:
        break;
    }
  }
}

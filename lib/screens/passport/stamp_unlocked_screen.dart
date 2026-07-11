import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/controllers/audio_controller.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../models/island_checkpoint_model.dart';
import '../../widgets/backgrounds/animated_splash_background.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../../widgets/passport/stamp_unlocked_content.dart';

class StampUnlockedScreen extends StatefulWidget {
  final IslandCheckpointModel checkpoint;

  const StampUnlockedScreen({
    super.key,
    required this.checkpoint,
  });

  @override
  State<StampUnlockedScreen> createState() => _StampUnlockedScreenState();
}

class _StampUnlockedScreenState extends State<StampUnlockedScreen> {
  static const int _bottomNavIndex = 1;

  bool _hasPlayedStampSound = false;

  @override
  void initState() {
    super.initState();

    _playStampSound();
  }

  void _playStampSound() {
    if (_hasPlayedStampSound) return;

    _hasPlayedStampSound = true;

    unawaited(
      Future.delayed(
        const Duration(milliseconds: 350),
        () async {
          if (!mounted) return;

          await AudioController.instance.playStampSound();
        },
      ),
    );
  }

  void _onSeaPassportPressed() {
    unawaited(
      AudioController.instance.playAppBacksound(),
    );

    Navigator.pushNamed(
      context,
      AppRoutes.passport,
      arguments: SeaPassportRouteArgs(
        checkpoint: widget.checkpoint,
        openedFromBottomNav: false,
      ),
    );
  }

  void _onBottomNavTap(int index) {
    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _bottomNavIndex,
    );
  }

  void _onBackPressed() {
    unawaited(
      AudioController.instance.playAppBacksound(),
    );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBody: true,
      body: Stack(
        children: [
          const AnimatedSplashBackground(),
          StampUnlockedContent(
            checkpoint: widget.checkpoint,
            onSeaPassportPressed: _onSeaPassportPressed,
          ),
          ScreenBackButton(
            onPressed: _onBackPressed,
          ),
          FloatingHomeBottomNav(
            currentIndex: _bottomNavIndex,
            onTap: _onBottomNavTap,
          ),
        ],
      ),
    );
  }
}

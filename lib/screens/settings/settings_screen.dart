import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/controllers/audio_controller.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../../widgets/settings/settings_content.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const int _bottomNavIndex = 4;

  bool _isNotificationActive = true;
  bool _isSoundActive = true;
  bool _isMusicActive = true;

  @override
  void initState() {
    super.initState();

    _isSoundActive = AudioController.instance.isSoundEnabled;
    _isMusicActive = AudioController.instance.isMusicEnabled;
  }

  void _handleBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.profile,
      (route) => false,
    );
  }

  void _handleBottomNavTap(int index) {
    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _bottomNavIndex,
    );
  }

  void _toggleNotification(bool value) {
    setState(() {
      _isNotificationActive = value;
    });
  }

  void _toggleSound(bool value) {
    setState(() {
      _isSoundActive = value;
    });

    AudioController.instance.setSoundEnabled(value);
  }

  void _toggleMusic(bool value) {
    setState(() {
      _isMusicActive = value;
    });

    unawaited(
      AudioController.instance.setMusicEnabled(value),
    );
  }

  void _handleLanguageTap() {
    // Bahasa dibiarkan dulu.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SettingsContent(
            isNotificationActive: _isNotificationActive,
            isSoundActive: _isSoundActive,
            isMusicActive: _isMusicActive,
            onNotificationChanged: _toggleNotification,
            onSoundChanged: _toggleSound,
            onMusicChanged: _toggleMusic,
            onLanguageTap: _handleLanguageTap,
          ),
          ScreenBackButton(
            onPressed: _handleBack,
          ),
          FloatingHomeBottomNav(
            currentIndex: _bottomNavIndex,
            onTap: _handleBottomNavTap,
          ),
        ],
      ),
    );
  }
}

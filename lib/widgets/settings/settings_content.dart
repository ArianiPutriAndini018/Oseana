import 'package:flutter/material.dart';

import 'settings_card.dart';

class SettingsContent extends StatelessWidget {
  final bool isNotificationActive;
  final bool isSoundActive;
  final bool isMusicActive;
  final ValueChanged<bool> onNotificationChanged;
  final ValueChanged<bool> onSoundChanged;
  final ValueChanged<bool> onMusicChanged;
  final VoidCallback onLanguageTap;

  const SettingsContent({
    super.key,
    required this.isNotificationActive,
    required this.isSoundActive,
    required this.isMusicActive,
    required this.onNotificationChanged,
    required this.onSoundChanged,
    required this.onMusicChanged,
    required this.onLanguageTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final isSmall = width < 380;
    final isShort = height < 760;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isSmall ? 22 : 30,
          isShort ? 205 : 225,
          isSmall ? 22 : 30,
          150,
        ),
        child: SettingsCard(
          isNotificationActive: isNotificationActive,
          isSoundActive: isSoundActive,
          isMusicActive: isMusicActive,
          onNotificationChanged: onNotificationChanged,
          onSoundChanged: onSoundChanged,
          onMusicChanged: onMusicChanged,
          onLanguageTap: onLanguageTap,
        ),
      ),
    );
  }
}
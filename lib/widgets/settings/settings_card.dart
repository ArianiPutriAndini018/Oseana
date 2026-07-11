import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import 'settings_item.dart';
import 'settings_language_item.dart';

class SettingsCard extends StatelessWidget {
  final bool isNotificationActive;
  final bool isSoundActive;
  final bool isMusicActive;
  final ValueChanged<bool> onNotificationChanged;
  final ValueChanged<bool> onSoundChanged;
  final ValueChanged<bool> onMusicChanged;
  final VoidCallback onLanguageTap;

  const SettingsCard({
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
    final isSmall = width < 380;

    final titleHeight = isSmall ? 50.0 : 58.0;
    final titleWidth = isSmall ? 210.0 : 238.0;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: titleHeight / 2,
          ),
          padding: EdgeInsets.fromLTRB(
            isSmall ? 14 : 20,
            isSmall ? 48 : 56,
            isSmall ? 14 : 20,
            isSmall ? 22 : 28,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppRadius.radiusXXL,
            border: Border.all(
              color: AppColors.primary,
              width: 4,
            ),
          ),
          child: Column(
            children: [
              SettingsItem(
                icon: Icons.notifications_rounded,
                title: 'Notifikasi',
                isActive: isNotificationActive,
                onChanged: onNotificationChanged,
              ),

              SizedBox(height: isSmall ? 16 : 20),

              SettingsItem(
                icon: Icons.volume_up_rounded,
                title: 'Suara',
                isActive: isSoundActive,
                onChanged: onSoundChanged,
              ),

              SizedBox(height: isSmall ? 16 : 20),

              SettingsItem(
                icon: Icons.music_note_rounded,
                title: 'Musik',
                isActive: isMusicActive,
                onChanged: onMusicChanged,
              ),

              SizedBox(height: isSmall ? 16 : 20),

              SettingsLanguageItem(
                language: 'Indonesia',
                onTap: onLanguageTap,
              ),
            ],
          ),
        ),

        Positioned(
          top: 0,
          child: Container(
            width: titleWidth,
            height: titleHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0D75DE),
                  Color(0xFF004CB8),
                ],
              ),
              boxShadow: AppShadows.medium,
            ),
            child: Text(
              'Pengaturan',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.white,
                fontSize: isSmall ? 22 : 27,
                fontWeight: FontWeight.w900,
                height: 1,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
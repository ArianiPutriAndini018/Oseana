import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'profile_avatar.dart';
import 'profile_xp_progress.dart';

class ProfileMainInfo extends StatelessWidget {
  final String userName;
  final String avatar;
  final String level;
  final String title;
  final int xp;
  final int maxXp;
  final double xpProgressValue;
  final bool isSmall;
  final VoidCallback onEditProfile;

  const ProfileMainInfo({
    super.key,
    required this.userName,
    required this.avatar,
    required this.level,
    required this.title,
    required this.xp,
    required this.maxXp,
    required this.xpProgressValue,
    required this.isSmall,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.translate(
          offset: Offset(
            0,
            isSmall ? -14 : -16,
          ),
          child: ProfileAvatar(
            image: avatar,
            size: isSmall ? 90 : 106,
            onEditProfile: onEditProfile,
          ),
        ),
        SizedBox(width: isSmall ? 18 : 22),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontSize: isSmall ? 18 : 20,
                  fontWeight: FontWeight.w900,
                  height: 1,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: isSmall ? 7 : 8),
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: level,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontSize: isSmall ? 10 : 11.5,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                        TextSpan(
                          text: '  •  ',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primary,
                            fontSize: isSmall ? 10 : 11.5,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                        TextSpan(
                          text: title,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: const Color(0xFF6A6F8C),
                            fontSize: isSmall ? 10 : 11.5,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ),
              SizedBox(height: isSmall ? 18 : 22),
              Transform.translate(
                offset: Offset(
                  isSmall ? -28 : -32,
                  0,
                ),
                child: ProfileXpProgress(
                  xp: xp,
                  maxXp: maxXp,
                  progressValue: xpProgressValue,
                  isSmall: isSmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

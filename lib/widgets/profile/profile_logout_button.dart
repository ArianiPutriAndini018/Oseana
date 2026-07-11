import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';

class ProfileLogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ProfileLogoutButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 36 : 52,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadius.radiusXL,
        child: InkWell(
          onTap: onPressed,
          borderRadius: AppRadius.radiusXL,
          child: Ink(
            height: isSmall ? 54 : 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF066ADB),
                  Color(0xFF004DB7),
                ],
              ),
              borderRadius: AppRadius.radiusXL,
              boxShadow: AppShadows.medium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_rounded,
                  color: AppColors.white,
                  size: isSmall ? 26 : 30,
                ),
                SizedBox(width: isSmall ? 8 : 10),
                Text(
                  'Keluar',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.white,
                    fontSize: isSmall ? 16 : 18,
                    fontWeight: FontWeight.w900,
                    height: 1,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

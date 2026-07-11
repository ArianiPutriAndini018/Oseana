import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String image;
  final double size;
  final VoidCallback onEditProfile;

  const ProfileAvatar({
    super.key,
    required this.image,
    required this.size,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    final editSize = size * 0.34;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          child: Image.asset(
            image,
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: -2,
          right: -5,
          child: GestureDetector(
            onTap: onEditProfile,
            child: Container(
              width: editSize,
              height: editSize,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 3,
                ),
              ),
              child: Icon(
                Icons.edit_rounded,
                color: AppColors.white,
                size: editSize * 0.58,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

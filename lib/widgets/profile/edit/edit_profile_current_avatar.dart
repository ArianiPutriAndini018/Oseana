import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class EditProfileCurrentAvatar extends StatelessWidget {
  final String image;
  final double size;
  final VoidCallback onEdit;

  const EditProfileCurrentAvatar({
    super.key,
    required this.image,
    required this.size,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final editSize = size * 0.34;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox.square(
          dimension: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        Positioned(
          top: -2,
          right: -4,
          child: GestureDetector(
            onTap: onEdit,
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
                size: editSize * 0.56,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
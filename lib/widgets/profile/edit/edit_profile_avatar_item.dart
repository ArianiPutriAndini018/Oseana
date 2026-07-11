import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/profile_avatar_model.dart';

class EditProfileAvatarItem extends StatelessWidget {
  final ProfileAvatarModel avatar;
  final bool isSelected;
  final double size;
  final VoidCallback onTap;

  const EditProfileAvatarItem({
    super.key,
    required this.avatar,
    required this.isSelected,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageSize = isSelected ? size - 6 : size;

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(
                    color: AppColors.primary,
                    width: 3,
                  )
                : null,
          ),
          child: SizedBox.square(
            dimension: imageSize,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(avatar.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
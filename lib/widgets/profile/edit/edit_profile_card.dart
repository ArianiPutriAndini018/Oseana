import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_radius.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../models/profile_avatar_model.dart';
import 'edit_profile_avatar_grid.dart';
import 'edit_profile_current_avatar.dart';
import 'edit_profile_name_field.dart';

class EditProfileCard extends StatelessWidget {
  final TextEditingController nameController;
  final String selectedAvatar;
  final List<ProfileAvatarModel> avatars;
  final ValueChanged<String> onAvatarSelected;
  final VoidCallback onCurrentAvatarEdit;

  const EditProfileCard({
    super.key,
    required this.nameController,
    required this.selectedAvatar,
    required this.avatars,
    required this.onAvatarSelected,
    required this.onCurrentAvatarEdit,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final isSmall = width < 380;
    final isShort = height < 760;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isSmall ? 24 : 28,
        isShort ? 18 : 20,
        isSmall ? 24 : 28,
        isShort ? 24 : 28,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Avatar Saat Ini',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.primary,
              fontSize: isSmall ? 18 : 20,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),

          SizedBox(height: isShort ? 16 : 18),

          Center(
            child: EditProfileCurrentAvatar(
              image: selectedAvatar,
              size: isSmall ? 92 : 116,
              onEdit: onCurrentAvatarEdit,
            ),
          ),

          SizedBox(height: isShort ? 26 : 32),

          Text(
            'Nama',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.primary,
              fontSize: isSmall ? 14 : 16,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),

          SizedBox(height: isSmall ? 10 : 12),

          EditProfileNameField(
            controller: nameController,
          ),

          SizedBox(height: isShort ? 26 : 32),

          Text(
            'Pilih Avatar',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.primary,
              fontSize: isSmall ? 14 : 16,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),

          SizedBox(height: isShort ? 18 : 22),

          EditProfileAvatarGrid(
            avatars: avatars,
            selectedAvatar: selectedAvatar,
            onAvatarSelected: onAvatarSelected,
          ),
        ],
      ),
    );
  }
}
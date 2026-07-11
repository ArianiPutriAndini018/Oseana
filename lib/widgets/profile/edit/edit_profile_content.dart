import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../models/profile_avatar_model.dart';
import 'edit_profile_card.dart';
import 'edit_profile_save_button.dart';

class EditProfileContent extends StatelessWidget {
  final TextEditingController nameController;
  final String selectedAvatar;
  final List<ProfileAvatarModel> avatars;
  final bool isSaving;
  final ValueChanged<String> onAvatarSelected;
  final VoidCallback onCurrentAvatarEdit;
  final VoidCallback onSave;

  const EditProfileContent({
    super.key,
    required this.nameController,
    required this.selectedAvatar,
    required this.avatars,
    required this.isSaving,
    required this.onAvatarSelected,
    required this.onCurrentAvatarEdit,
    required this.onSave,
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
          isSmall ? 34 : 34,
          isShort ? 82 : 96,
          isSmall ? 34 : 34,
          190,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Edit Profil',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.blueDark,
                fontSize: isSmall ? 25 : 30,
                fontWeight: FontWeight.w900,
                height: 1,
                letterSpacing: 0.4,
              ),
            ),

            SizedBox(height: isShort ? 36 : 46),

            EditProfileCard(
              nameController: nameController,
              selectedAvatar: selectedAvatar,
              avatars: avatars,
              onAvatarSelected: onAvatarSelected,
              onCurrentAvatarEdit: onCurrentAvatarEdit,
            ),

            SizedBox(height: isSmall ? 22 : 26),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 18 : 22,
              ),
              child: EditProfileSaveButton(
                isLoading: isSaving,
                onPressed: onSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
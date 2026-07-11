import 'package:flutter/material.dart';

import '../../../models/profile_avatar_model.dart';
import 'edit_profile_avatar_item.dart';

class EditProfileAvatarGrid extends StatelessWidget {
  final List<ProfileAvatarModel> avatars;
  final String selectedAvatar;
  final ValueChanged<String> onAvatarSelected;

  const EditProfileAvatarGrid({
    super.key,
    required this.avatars,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final isSmall = width < 380;
    final isShort = height < 760;

    return LayoutBuilder(
      builder: (context, constraints) {
        final spacingX = isSmall ? 22.0 : 32.0;
        final spacingY = isShort ? 22.0 : 28.0;

        final availableWidth = constraints.maxWidth - (spacingX * 2);
        final avatarSize = (availableWidth / 3).clamp(62.0, 94.0).toDouble();

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: avatars.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: spacingX,
            mainAxisSpacing: spacingY,
            mainAxisExtent: avatarSize,
          ),
          itemBuilder: (context, index) {
            final avatar = avatars[index];

            return EditProfileAvatarItem(
              avatar: avatar,
              isSelected: avatar.image == selectedAvatar,
              size: avatarSize,
              onTap: () => onAvatarSelected(avatar.image),
            );
          },
        );
      },
    );
  }
}
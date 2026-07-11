import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/profile_menu_model.dart';

class ProfileMenuCard extends StatelessWidget {
  final List<ProfileMenuModel> menus;
  final ValueChanged<String> onMenuTap;

  const ProfileMenuCard({
    super.key,
    required this.menus,
    required this.onMenuTap,
  });

  static const Color _dividerColor = Color(0xFFD3E1F0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 18 : 24,
        vertical: isSmall ? 10 : 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: AppColors.primary,
          width: 3.5,
        ),
      ),
      child: Column(
        children: [
          for (int index = 0; index < menus.length; index++) ...[
            _ProfileMenuItem(
              menu: menus[index],
              isSmall: isSmall,
              onTap: () => onMenuTap(menus[index].id),
            ),
            if (index != menus.length - 1)
              const Divider(
                height: 1,
                thickness: 1.4,
                color: _dividerColor,
              ),
          ],
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final ProfileMenuModel menu;
  final bool isSmall;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.menu,
    required this.isSmall,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmall ? 66 : 76,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.radiusMD,
        child: Row(
          children: [
            _ProfileMenuIcon(
              menu: menu,
              size: isSmall ? 34 : 36,
            ),
            SizedBox(width: isSmall ? 16 : 20),
            Expanded(
              child: Text(
                menu.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontSize: isSmall ? 14 : 16,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuIcon extends StatelessWidget {
  final ProfileMenuModel menu;
  final double size;

  const _ProfileMenuIcon({
    required this.menu,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (menu.iconAsset != null) {
      return Image.asset(
        menu.iconAsset!,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            menu.fallbackIcon,
            color: AppColors.primary,
            size: size,
          );
        },
      );
    }

    return Icon(
      menu.fallbackIcon,
      color: AppColors.primary,
      size: size,
    );
  }
}

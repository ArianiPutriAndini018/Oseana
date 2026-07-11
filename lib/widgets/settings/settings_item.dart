import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'settings_toggle.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onChanged,
  });

  static const Color _borderColor = Color(0xFFD8D8D8);
  static const Color _activeColor = Color(0xFF12A83A);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return GestureDetector(
      onTap: () => onChanged(!isActive),
      child: Container(
        height: isSmall ? 62 : 70,
        padding: EdgeInsets.fromLTRB(
          isSmall ? 10 : 12,
          0,
          isSmall ? 8 : 10,
          0,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _borderColor,
            width: 2.2,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: isSmall ? 34 : 40,
              child: Icon(
                icon,
                color: AppColors.primary,
                size: isSmall ? 29 : 35,
              ),
            ),
            SizedBox(width: isSmall ? 10 : 12),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.visible,
                softWrap: false,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontSize: isSmall ? 12 : 14,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
            ),
            SizedBox(width: isSmall ? 4 : 6),
            Text(
              isActive ? 'Aktif' : 'Nonaktif',
              maxLines: 1,
              softWrap: false,
              style: AppTextStyles.bodySmall.copyWith(
                color: isActive ? _activeColor : AppColors.textGrey,
                fontSize: isSmall ? 8 : 12,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
            SizedBox(width: isSmall ? 5 : 7),
            SettingsToggle(
              value: isActive,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

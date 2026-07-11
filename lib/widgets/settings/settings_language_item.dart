import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class SettingsLanguageItem extends StatelessWidget {
  final String language;
  final VoidCallback onTap;

  const SettingsLanguageItem({
    super.key,
    required this.language,
    required this.onTap,
  });

  static const Color _borderColor = Color(0xFFD8D8D8);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isSmall ? 62 : 70,
        padding: EdgeInsets.fromLTRB(
          isSmall ? 12 : 16,
          0,
          isSmall ? 6 : 8,
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
                Icons.public_rounded,
                color: AppColors.primary,
                size: isSmall ? 28 : 34,
              ),
            ),
            SizedBox(width: isSmall ? 10 : 12),
            Expanded(
              child: Text(
                'Bahasa',
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.visible,
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
              language,
              maxLines: 1,
              softWrap: false,
              style: AppTextStyles.bodySmall.copyWith(
                color: const Color(0xFF59627A),
                fontSize: isSmall ? 8 : 12,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
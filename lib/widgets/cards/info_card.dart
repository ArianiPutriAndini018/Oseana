import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

class InfoCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.text,
    this.icon = Icons.info_rounded,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: AppSpacing.contentPadding,
      decoration: const BoxDecoration(
        color: AppColors.blueLight,
        borderRadius: AppRadius.radiusLG,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.secondary,
            size: 28,
          ),
          AppSpacing.w16,
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyles.captionBold,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) return card;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.radiusLG,
      child: card,
    );
  }
}

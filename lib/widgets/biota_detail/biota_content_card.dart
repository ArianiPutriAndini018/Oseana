import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/biota_model.dart';
import 'biota_content_tab.dart';

class BiotaContentCard extends StatelessWidget {
  final BiotaModel biota;
  final BiotaContentType selectedType;
  final ValueChanged<BiotaContentType> onTypeChanged;

  const BiotaContentCard({
    super.key,
    required this.biota,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    final content = biota.contentByType(selectedType);

    return Container(
      decoration: const BoxDecoration(
        borderRadius: AppRadius.radiusXXL,
        boxShadow: AppShadows.medium,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.radiusXXL,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              isSmall ? 12 : 16,
              isSmall ? 14 : 18,
              isSmall ? 12 : 16,
              isSmall ? 22 : 26,
            ),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.75),
              borderRadius: AppRadius.radiusXXL,
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.6),
                width: 1.5,
              ),
            ),
            child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final tabGap = isSmall ? 7.0 : 8.0;
              final minTabSize = isSmall ? 66.0 : 72.0;

              final fittedTabSize = (constraints.maxWidth - (tabGap * 4)) / 5;

              final tabSize =
                  fittedTabSize < minTabSize ? minTabSize : fittedTabSize;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    BiotaContentTab(
                      type: BiotaContentType.summary,
                      isSelected: selectedType == BiotaContentType.summary,
                      onTap: () => onTypeChanged(BiotaContentType.summary),
                      size: tabSize,
                    ),
                    SizedBox(width: tabGap),
                    BiotaContentTab(
                      type: BiotaContentType.habitat,
                      isSelected: selectedType == BiotaContentType.habitat,
                      onTap: () => onTypeChanged(BiotaContentType.habitat),
                      size: tabSize,
                    ),
                    SizedBox(width: tabGap),
                    BiotaContentTab(
                      type: BiotaContentType.threat,
                      isSelected: selectedType == BiotaContentType.threat,
                      onTap: () => onTypeChanged(BiotaContentType.threat),
                      size: tabSize,
                    ),
                    SizedBox(width: tabGap),
                    BiotaContentTab(
                      type: BiotaContentType.funFact,
                      isSelected: selectedType == BiotaContentType.funFact,
                      onTap: () => onTypeChanged(BiotaContentType.funFact),
                      size: tabSize,
                    ),
                    SizedBox(width: tabGap),
                    BiotaContentTab(
                      type: BiotaContentType.food,
                      isSelected: selectedType == BiotaContentType.food,
                      onTap: () => onTypeChanged(BiotaContentType.food),
                      size: tabSize,
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: isSmall ? 18 : 22),
          Text(
            selectedType.label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.primary,
              fontSize: isSmall ? 14 : 18,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
          SizedBox(height: isSmall ? 14 : 18),
          Text(
            content,
            textAlign: TextAlign.justify,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.primary,
              fontSize: isSmall ? 12 : 14,
              fontWeight: FontWeight.w400,
              height: 1.45,
            ),
          ),
        ],
            ),
          ),
        ),
      ),
    );
  }
}

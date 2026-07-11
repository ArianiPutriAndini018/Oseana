import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';

class QrScannerHintBadge extends StatelessWidget {
  final String text;

  const QrScannerHintBadge({
    super.key,
    this.text = 'Arahkan kamera ke\nQR panel pulau/kode',
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 10 : 12,
        vertical: isSmall ? 7 : 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: AppRadius.radiusLG,
        border: Border.all(
          color: AppColors.white.withOpacity(0.35),
          width: 1,
        ),
        boxShadow: AppShadows.whiteGlow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.qr_code_scanner_rounded,
            color: AppColors.white,
            size: isSmall ? 28 : 32,
          ),

          SizedBox(width: isSmall ? 8 : 10),

          Text(
            text,
            maxLines: 2,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white,
              fontSize: isSmall ? 12 : 13,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
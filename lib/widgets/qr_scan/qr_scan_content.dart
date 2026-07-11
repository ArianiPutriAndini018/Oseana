import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/island_checkpoint_model.dart';
import 'qr_scan_manual_section.dart';
import 'qr_scanner_camera_card.dart';

class QrScanContent extends StatelessWidget {
  final IslandCheckpointModel checkpoint;
  final MobileScannerController scannerController;
  final TextEditingController manualCodeController;
  final bool isHandlingCode;
  final void Function(BarcodeCapture capture) onQrDetected;
  final ValueChanged<String> onManualCodeSubmitted;
  final VoidCallback onOpenPressed;

  const QrScanContent({
    super.key,
    required this.checkpoint,
    required this.scannerController,
    required this.manualCodeController,
    required this.isHandlingCode,
    required this.onQrDetected,
    required this.onManualCodeSubmitted,
    required this.onOpenPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isSmall ? 20 : 24,
          78,
          isSmall ? 20 : 24,
          135,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'QR Scanner',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: isSmall ? 26 : 29,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                height: 1.1,
              ),
            ),

            const SizedBox(height: 28),

            QrScannerCameraCard(
              controller: scannerController,
              onDetect: onQrDetected,
              height: isSmall ? 360 : 395,
            ),

            const SizedBox(height: 30),

            QrScanManualSection(
              controller: manualCodeController,
              label: checkpoint.manualInputLabel,
              hintText: checkpoint.manualCodeHint,
              isLoading: isHandlingCode,
              onSubmitted: onManualCodeSubmitted,
              onOpenPressed: onOpenPressed,
            ),
          ],
        ),
      ),
    );
  }
}
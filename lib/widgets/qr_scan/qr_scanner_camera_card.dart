import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import 'qr_scanner_frame_painter.dart';
import 'qr_scanner_hint_badge.dart';

class QrScannerCameraCard extends StatelessWidget {
  final MobileScannerController controller;
  final void Function(BarcodeCapture capture) onDetect;
  final double height;

  const QrScannerCameraCard({
    super.key,
    required this.controller,
    required this.onDetect,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.black,
        borderRadius: AppRadius.radiusXXL,
        boxShadow: AppShadows.large,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.radiusXXL,
        child: Stack(
          fit: StackFit.expand,
          children: [
            MobileScanner(
              controller: controller,
              fit: BoxFit.cover,
              onDetect: onDetect,
            ),

            Container(
              color: AppColors.black.withOpacity(0.20),
            ),

            const CustomPaint(
              painter: QrScannerFramePainter(),
            ),

            const Positioned(
              top: 22,
              left: 0,
              right: 0,
              child: Center(
                child: QrScannerHintBadge(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
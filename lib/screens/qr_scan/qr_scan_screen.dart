import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../models/island_checkpoint_model.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../../widgets/qr_scan/qr_scan_content.dart';
import '../island_detail/island_detail_screen.dart';

class QrScanScreen extends StatefulWidget {
  final IslandCheckpointModel checkpoint;

  const QrScanScreen({
    super.key,
    required this.checkpoint,
  });

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  static const int _currentIndex = 1;

  late final MobileScannerController _scannerController;
  late final TextEditingController _manualCodeController;

  bool _isHandlingCode = false;

  @override
  void initState() {
    super.initState();

    _manualCodeController = TextEditingController();

    _scannerController = MobileScannerController(
      formats: const [
        BarcodeFormat.qrCode,
      ],
      detectionSpeed: DetectionSpeed.normal,
      detectionTimeoutMs: 100,
    );
  }

  @override
  void dispose() {
    _manualCodeController.dispose();
    _scannerController.dispose();

    super.dispose();
  }

  void _onQrDetected(BarcodeCapture capture) {
    if (_isHandlingCode) return;
    if (capture.barcodes.isEmpty) return;

    for (final barcode in capture.barcodes) {
      final qrValue = barcode.rawValue?.trim();

      if (qrValue == null || qrValue.isEmpty) continue;

      debugPrint('QR terbaca: $qrValue');

      _handleCode(qrValue);
      break;
    }
  }

  Future<void> _handleCode(String value) async {
    if (_isHandlingCode) return;

    final inputCode = value.trim().toUpperCase();
    final validCode = widget.checkpoint.checkpointCode.trim().toUpperCase();

    if (inputCode.isEmpty) {
      _showSnackBar(
        'Masukkan kode manual terlebih dahulu',
        AppColors.warning,
      );
      return;
    }

    setState(() {
      _isHandlingCode = true;
    });

    if (inputCode != validCode) {
      _showSnackBar(
        'QR atau kode manual tidak valid',
        AppColors.error,
      );

      await Future.delayed(
        const Duration(milliseconds: 1200),
      );

      if (!mounted) return;

      setState(() {
        _isHandlingCode = false;
      });

      return;
    }

    await _scannerController.stop();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => IslandDetailScreen(
          checkpoint: widget.checkpoint,
        ),
      ),
    );
  }

  void _onOpenPressed() {
    _handleCode(
      _manualCodeController.text,
    );
  }

  void _onBottomNavTap(int index) {
    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _currentIndex,
    );
  }

  void _showSnackBar(
    String message,
    Color backgroundColor,
  ) {
    if (!mounted) return;

    AppSnackBar.show(
      context,
      message,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      extendBody: true,
      body: Stack(
        children: [
          QrScanContent(
            checkpoint: widget.checkpoint,
            scannerController: _scannerController,
            manualCodeController: _manualCodeController,
            isHandlingCode: _isHandlingCode,
            onQrDetected: _onQrDetected,
            onManualCodeSubmitted: _handleCode,
            onOpenPressed: _onOpenPressed,
          ),
          const ScreenBackButton(),
          FloatingHomeBottomNav(
            currentIndex: _currentIndex,
            onTap: _onBottomNavTap,
          ),
        ],
      ),
    );
  }
}

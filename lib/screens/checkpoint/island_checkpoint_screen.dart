import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/ocean_page_route.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../data/checkpoint_data.dart';
import '../../models/island_checkpoint_model.dart';
import '../../models/island_model.dart';
import '../../models/learning_mode_type.dart';
import '../../widgets/checkpoint/island_checkpoint_content.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../island_detail/island_detail_screen.dart';
import '../qr_scan/qr_scan_screen.dart';

class IslandCheckpointScreen extends StatefulWidget {
  final IslandModel island;
  final LearningModeType learningMode;

  const IslandCheckpointScreen({
    super.key,
    required this.island,
    this.learningMode = LearningModeType.explore,
  });

  @override
  State<IslandCheckpointScreen> createState() {
    return _IslandCheckpointScreenState();
  }
}

class _IslandCheckpointScreenState
    extends State<IslandCheckpointScreen> {
  static const int _currentIndex = 1;

  late final TextEditingController _manualCodeController;

  bool get _isAquariumMode {
    return widget.learningMode == LearningModeType.aquarium;
  }

  IslandCheckpointModel get _checkpoint {
    return CheckpointData.getCheckpointByIslandId(
      widget.island.id,
    );
  }

  @override
  void initState() {
    super.initState();

    _manualCodeController = TextEditingController();

    if (widget.island.stars == 3) {
      CheckpointData.updateProgress(
        widget.island.id,
        1.0,
      );
    }
  }

  @override
  void dispose() {
    _manualCodeController.dispose();
    super.dispose();
  }

  void _openIslandDetail() {
    Navigator.push(
      context,
      OceanPageRoute(
        builder: (_) => IslandDetailScreen(
          checkpoint: _checkpoint,
          learningMode: widget.learningMode,
        ),
      ),
    );
  }

  void _onLearnPressed() {
    // Pengaman:
    // Aquarium Mode tidak boleh langsung belajar.
    if (_isAquariumMode) {
      _showSnackBar(
        'Scan QR atau masukkan kode terlebih dahulu',
        AppColors.warning,
      );
      return;
    }

    _openIslandDetail();
  }

  void _onScanQrPressed() {
    // Pengaman:
    // Explore Mode tidak boleh membuka scanner.
    if (!_isAquariumMode) {
      _showSnackBar(
        'Scan QR hanya tersedia pada Aquarium Mode',
        AppColors.warning,
      );
      return;
    }

    final checkpointCode =
        _checkpoint.checkpointCode.trim();

    if (checkpointCode.isEmpty) {
      _showSnackBar(
        'Kode checkpoint Pulau ${widget.island.name} belum tersedia',
        AppColors.warning,
      );
      return;
    }

    Navigator.push(
      context,
      OceanPageRoute(
        builder: (_) => QrScanScreen(
          checkpoint: _checkpoint,
          learningMode: widget.learningMode,
        ),
      ),
    );
  }

  void _handleManualCodeSubmit(
    String value,
  ) {
    // Explore Mode tidak dapat memakai kode manual.
    if (!_isAquariumMode) {
      _showSnackBar(
        'Kode manual hanya tersedia pada Aquarium Mode',
        AppColors.warning,
      );
      return;
    }

    final inputCode = value
        .trim()
        .toUpperCase();

    final validCode = _checkpoint
        .checkpointCode
        .trim()
        .toUpperCase();

    if (validCode.isEmpty) {
      _showSnackBar(
        'Kode checkpoint Pulau ${widget.island.name} belum tersedia',
        AppColors.warning,
      );
      return;
    }

    if (inputCode.isEmpty) {
      _showSnackBar(
        'Masukkan kode terlebih dahulu',
        AppColors.warning,
      );
      return;
    }

    if (inputCode != validCode) {
      _showSnackBar(
        'Kode tidak sesuai dengan Pulau ${widget.island.name}',
        AppColors.error,
      );
      return;
    }

    _manualCodeController.clear();

    _showSnackBar(
      'Kode Pulau ${widget.island.name} berhasil diverifikasi',
      AppColors.success,
    );

    _openIslandDetail();
  }

  void _onBottomNavTap(
    int index,
  ) {
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
    if (!mounted) {
      return;
    }

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
          IslandCheckpointContent(
            checkpoint: _checkpoint,
            isAquariumMode: _isAquariumMode,
            manualCodeController: _manualCodeController,
            onLearnPressed: _onLearnPressed,
            onScanQrPressed: _onScanQrPressed,
            onManualCodeSubmitted: _handleManualCodeSubmit,
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
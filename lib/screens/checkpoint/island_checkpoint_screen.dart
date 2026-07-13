import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
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
  State<IslandCheckpointScreen> createState() => _IslandCheckpointScreenState();
}

class _IslandCheckpointScreenState extends State<IslandCheckpointScreen> {
  static const int _currentIndex = 1;

  late final TextEditingController _manualCodeController;

  bool get _isAquariumMode {
    if (widget.island.stars == 3) {
      return false;
    }
    return widget.learningMode == LearningModeType.aquarium;
  }

  IslandCheckpointModel get _checkpoint {
    return CheckpointData.getCheckpointByIslandId(
      widget.island.name,
    );
  }

  @override
  void initState() {
    super.initState();

    _manualCodeController = TextEditingController();

    if (widget.island.stars == 3) {
      CheckpointData.updateProgress(widget.island.name, 1.0);
    }
  }

  @override
  void dispose() {
    _manualCodeController.dispose();
    super.dispose();
  }

  void _onLearnPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IslandDetailScreen(
          checkpoint: _checkpoint,
        ),
      ),
    );
  }

  void _onScanQrPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QrScanScreen(
          checkpoint: _checkpoint,
        ),
      ),
    );
  }

  void _handleManualCodeSubmit(String value) {
    final inputCode = value.trim().toUpperCase();
    final validCode = _checkpoint.checkpointCode.trim().toUpperCase();

    if (inputCode.isEmpty) {
      _showSnackBar(
        'Masukkan kode terlebih dahulu',
        AppColors.warning,
      );
      return;
    }

    if (inputCode != validCode) {
      _showSnackBar(
        'Kode tidak valid',
        AppColors.error,
      );
      return;
    }

    _showSnackBar(
      'Kode valid',
      AppColors.success,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IslandDetailScreen(
          checkpoint: _checkpoint,
        ),
      ),
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
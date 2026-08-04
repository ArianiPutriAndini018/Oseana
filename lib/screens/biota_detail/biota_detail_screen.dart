import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/ocean_page_route.dart';
import '../../core/services/auth_service.dart';
import '../../data/repositories/biota_repository.dart';
import '../../models/biota_model.dart';
import '../../models/island_checkpoint_model.dart';
import '../../models/learning_mode_type.dart';
import '../../widgets/biota_detail/biota_detail_content.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../biota_video/biota_video_screen.dart';

class BiotaDetailScreen extends StatefulWidget {
  final IslandCheckpointModel checkpoint;
  final BiotaModel biota;
  final LearningModeType learningMode;

  const BiotaDetailScreen({
    super.key,
    required this.checkpoint,
    required this.biota,
    this.learningMode = LearningModeType.explore,
  });

  @override
  State<BiotaDetailScreen> createState() {
    return _BiotaDetailScreenState();
  }
}

class _BiotaDetailScreenState
    extends State<BiotaDetailScreen> {
  static const int _currentIndex = 1;

  BiotaContentType _selectedType =
      BiotaContentType.summary;

  @override
  void initState() {
    super.initState();

    _markBiotaAsLearned();
  }

  Future<void> _markBiotaAsLearned() async {
    final user = AuthService().currentUser;

    if (user == null) {
      return;
    }

    await BiotaRepository().markBiotaAsLearned(
      user.id,
      widget.biota.id,
    );
  }

  void _onTypeChanged(
    BiotaContentType type,
  ) {
    setState(() {
      _selectedType = type;
    });
  }

  void _onVideoPressed() {
    if (widget.biota.videoUrl.trim().isEmpty) {
      _showSnackBar(
        'Video biota belum tersedia',
      );
      return;
    }

    Navigator.push(
      context,
      OceanPageRoute(
        builder: (_) => BiotaVideoScreen(
          checkpoint: widget.checkpoint,
          biota: widget.biota,
          learningMode: widget.learningMode,
        ),
      ),
    );
  }

  void _onLearnOtherPressed() {
    Navigator.pop(context);
  }

  void _onBottomNavTap(
    int index,
  ) {
    if (index == _currentIndex) {
      return;
    }

    if (index == 0) {
      Navigator.popUntil(
        context,
        (route) => route.isFirst,
      );
      return;
    }

    const labels = [
      'Beranda',
      'Peta',
      'Passport',
      'Misi',
      'Profil',
    ];

    _showSnackBar(
      '${labels[index]} belum dibuat',
    );
  }

  void _showSnackBar(
    String message,
  ) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.radiusLG,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBody: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.backgroundSplash,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          Positioned.fill(
            child: ColoredBox(
              color: Colors.white.withOpacity(
                0.12,
              ),
            ),
          ),

          BiotaDetailContent(
            biota: widget.biota,
            selectedType: _selectedType,
            onTypeChanged: _onTypeChanged,
            onVideoPressed: _onVideoPressed,
            onLearnOtherPressed: _onLearnOtherPressed,
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
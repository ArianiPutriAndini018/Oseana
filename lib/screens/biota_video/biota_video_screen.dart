import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../core/utils/youtube_video_id_helper.dart';
import '../../models/biota_model.dart';
import '../../models/island_checkpoint_model.dart';
import '../../widgets/backgrounds/animated_splash_background.dart';
import '../../widgets/biota_video/biota_video_content.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../quiz/quiz_screen.dart';
import '../../core/routes/ocean_page_route.dart';

class BiotaVideoScreen extends StatefulWidget {
  final IslandCheckpointModel checkpoint;
  final BiotaModel biota;

  const BiotaVideoScreen({
    super.key,
    required this.checkpoint,
    required this.biota,
  });

  @override
  State<BiotaVideoScreen> createState() => _BiotaVideoScreenState();
}

class _BiotaVideoScreenState extends State<BiotaVideoScreen> {
  static const int _currentIndex = 1;

  YoutubePlayerController? _youtubeController;

  bool get _hasVideo {
    return _youtubeController != null;
  }

  @override
  void initState() {
    super.initState();

    _initializeYoutubePlayer();
  }

  void _initializeYoutubePlayer() {
    final videoId = YoutubeVideoIdHelper.resolve(
      widget.biota.videoUrl,
    );

    if (videoId == null) return;

    _youtubeController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        mute: false,
        enableCaption: true,
        showControls: true,
        showFullscreenButton: true,
        playsInline: true,
        strictRelatedVideos: true,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController?.close();

    super.dispose();
  }

  void _onWatchVideoPressed() {
    if (!_hasVideo) {
      _showSnackBar('Video biota belum tersedia');
      return;
    }

    _youtubeController?.playVideo();
  }

  void _onLearnOtherPressed() {
    Navigator.pop(context);
  }

  void _onQuizPressed() {
    Navigator.push(
      context,
      OceanPageRoute(
        builder: (_) => QuizScreen(checkpoint: widget.checkpoint),
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

  void _showSnackBar(String message) {
    if (!mounted) return;

    AppSnackBar.show(
      context,
      message,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBody: true,
      body: Stack(
        children: [
          const AnimatedSplashBackground(),
          BiotaVideoContent(
            biota: widget.biota,
            youtubeController: _youtubeController,
            onWatchVideoPressed: _onWatchVideoPressed,
            onLearnOtherPressed: _onLearnOtherPressed,
            onQuizPressed: _onQuizPressed,
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

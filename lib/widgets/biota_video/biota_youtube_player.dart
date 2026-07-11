import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/constants/app_colors.dart';
import 'video_placeholder.dart';

class BiotaYoutubePlayer extends StatelessWidget {
  final YoutubePlayerController? controller;

  const BiotaYoutubePlayer({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return const VideoPlaceholder();
    }

    return YoutubePlayer(
      controller: controller!,
      aspectRatio: 16 / 9,
      backgroundColor: AppColors.black,
    );
  }
}

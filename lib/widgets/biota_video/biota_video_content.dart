import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../models/biota_model.dart';
import 'biota_video_actions.dart';
import 'biota_video_header.dart';
import 'biota_youtube_player.dart';
import 'floating_video_card.dart';

class BiotaVideoContent extends StatelessWidget {
  final BiotaModel biota;
  final YoutubePlayerController? youtubeController;
  final VoidCallback onWatchVideoPressed;
  final VoidCallback onLearnOtherPressed;
  final VoidCallback onQuizPressed;

  const BiotaVideoContent({
    super.key,
    required this.biota,
    required this.youtubeController,
    required this.onWatchVideoPressed,
    required this.onLearnOtherPressed,
    required this.onQuizPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isSmall ? 22 : 24,
          88,
          isSmall ? 22 : 24,
          132,
        ),
        child: Column(
          children: [
            BiotaVideoHeader(
              biota: biota,
            ),
            SizedBox(height: isSmall ? 38 : 42),
            FloatingVideoCard(
              child: BiotaYoutubePlayer(
                controller: youtubeController,
              ),
            ),
            SizedBox(height: isSmall ? 46 : 54),
            BiotaVideoActions(
              onWatchVideoPressed: onWatchVideoPressed,
              onLearnOtherPressed: onLearnOtherPressed,
              onQuizPressed: onQuizPressed,
            ),
          ],
        ),
      ),
    );
  }
}

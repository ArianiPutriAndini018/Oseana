import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoIdHelper {
  YoutubeVideoIdHelper._();

  static String? resolve(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) return null;

    final videoId = YoutubePlayerController.convertUrlToId(trimmedValue);

    if (videoId != null && videoId.isNotEmpty) {
      return videoId;
    }

    final isRawVideoId = RegExp(
      r'^[a-zA-Z0-9_-]{11}$',
    ).hasMatch(trimmedValue);

    if (isRawVideoId) {
      return trimmedValue;
    }

    return null;
  }
}

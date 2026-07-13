import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoIdHelper {
  YoutubeVideoIdHelper._();

  static String? resolve(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) return null;

    final regex = RegExp(
      r'.*(?:youtu.be/|v/|u/\w/|embed/|watch\?v=|\&v=)([^#\&\?]*).*',
    );
    final match = regex.firstMatch(trimmedValue);
    if (match != null && match.groupCount >= 1) {
      final id = match.group(1);
      if (id != null && id.length == 11) {
        return id;
      }
    }

    try {
      final videoId = YoutubePlayerController.convertUrlToId(trimmedValue);
      if (videoId != null && videoId.isNotEmpty) {
        return videoId;
      }
    } catch (_) {}

    final isRawVideoId = RegExp(
      r'^[a-zA-Z0-9_-]{11}$',
    ).hasMatch(trimmedValue);

    if (isRawVideoId) {
      return trimmedValue;
    }

    return null;
  }
}

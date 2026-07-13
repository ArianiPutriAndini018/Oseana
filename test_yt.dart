import 'lib/core/utils/youtube_video_id_helper.dart';

void main() {
  final url = 'https://youtu.be/5mkVld0FpvQ?si=10yk7Mzh_Pu2Y6hb';
  final id = YoutubeVideoIdHelper.resolve(url);
  print('Video ID: $id');
}

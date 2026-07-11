import '../core/constants/app_images.dart';
import '../models/mission_model.dart';

class MissionData {
  MissionData._();

  static const int userXp = 200;

  static const int completedMissionCount = 1;
  static const int totalMissionCount = 9;

  static const int completedMissionXp = 5;
  static const int totalMissionXp = 45;

  static const List<MissionModel> missions = [
    MissionModel(
      id: 'reduce_plastic',
      title: 'Kurangi Plastik Sekali Pakai',
      description: 'Gunakan barang pakai ulang dan kurangi sampah plastik.',
      image: AppImages.missionPlasticBag,
      xpReward: 5,
      isCompleted: true,
      order: 1,
    ),
    MissionModel(
      id: 'bring_bottle',
      title: 'Bawa Botol Minum Sendiri',
      description: 'Biasakan membawa botol minum saat beraktivitas.',
      image: AppImages.missionBottle,
      xpReward: 5,
      isCompleted: false,
      order: 2,
    ),
    MissionModel(
      id: 'throw_trash',
      title: 'Buang Sampah pada Tempatnya',
      description:
          'Jaga kebersihan lingkungan dengan membuang sampah dengan benar.',
      image: AppImages.missionTrashBin,
      xpReward: 5,
      isCompleted: false,
      order: 3,
    ),
    MissionModel(
      id: 'dont_touch_biota',
      title: 'Jangan Sentuh Biota Laut',
      description:
          'Amati biota laut tanpa menyentuh atau mengganggu habitatnya.',
      image: AppImages.missionStarfish,
      xpReward: 5,
      isCompleted: false,
      order: 4,
    ),
    MissionModel(
      id: 'share_ocean_message',
      title: 'Bagikan Pesan Peduli Laut',
      description:
          'Ajak orang lain menjaga laut dengan membagikan pesan positif.',
      image: AppImages.missionMegaphone,
      xpReward: 5,
      isCompleted: false,
      order: 5,
    ),
  ];

  static List<MissionModel> get orderedMissions {
    final result = [...missions];

    result.sort((a, b) => a.order.compareTo(b.order));

    return result;
  }

  static List<MissionModel> get previewMissions {
    return orderedMissions.take(5).toList();
  }
}

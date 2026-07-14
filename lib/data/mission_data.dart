import '../core/constants/app_images.dart';
import '../models/mission_model.dart';
import 'repositories/mission_repository.dart';

class MissionData {
  MissionData._();

  static const int userXp = 200;

  static const int completedMissionCount = 1;
  static const int totalMissionCount = 9;

  static const int completedMissionXp = 5;
  static const int totalMissionXp = 45;

  static Future<List<MissionModel>> loadAllMissions() async {
    try {
      return await MissionRepository().getAllMissions();
    } catch (e) {
      return missions; // Fallback
    }
  }

  static const List<MissionModel> missions = [
    MissionModel(
      id: 'reduce_plastic',
      title: 'Kurangi Plastik Sekali Pakai',
      description: 'Gunakan barang pakai ulang dan kurangi sampah plastik.',
      image: AppImages.missionPlasticBag,
      xpReward: 5,
      category: 'plastik',
      isCompleted: false,
      order: 1,
    ),
    MissionModel(
      id: 'bring_bottle',
      title: 'Bawa Botol Minum Sendiri',
      description: 'Biasakan membawa botol minum saat beraktivitas.',
      image: AppImages.missionBottle,
      xpReward: 5,
      category: 'plastik',
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
      category: 'umum',
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
      category: 'umum',
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
      category: 'umum',
      isCompleted: false,
      order: 5,
    ),
    MissionModel(
      id: 'pilah_sampah',
      title: 'Pilah Sampah Sederhana',
      description: 'Pilah sampah dengan benar agar tidak mencemari laut dan merusak ekosistem.',
      image: AppImages.missionSelectiveTrash,
      xpReward: 5,
      category: 'umum',
      isCompleted: false,
      order: 6,
    ),
    MissionModel(
      id: 'kurangi_sampah',
      title: 'Kurangi Sampah di Sekitar',
      description: 'Bersihkan lingkungan sekitar agar sampah tidak terbawa ke laut.',
      image: AppImages.missionLessTrash,
      xpReward: 5,
      category: 'umum',
      isCompleted: false,
      order: 7,
    ),
    MissionModel(
      id: 'tas_pakai_ulang',
      title: 'Gunakan Tas Pakai Ulang',
      description: 'Kurangi penggunaan plastik sekali pakai dengan membawa tas sendiri',
      image: AppImages.missionReuseBag,
      xpReward: 5,
      category: 'plastik',
      isCompleted: false,
      order: 8,
    ),
    MissionModel(
      id: 'tolak_sedotan',
      title: 'Tolak Sedotan Plastik',
      description: 'Hindari sedotan plastik untuk mengurangi sampah yang mencemari laut',
      image: AppImages.missionPlasticStraw,
      xpReward: 5,
      category: 'plastik',
      isCompleted: false,
      order: 9,
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

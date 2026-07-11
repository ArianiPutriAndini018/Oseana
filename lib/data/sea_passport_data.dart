import '../core/constants/app_images.dart';
import '../models/sea_passport_reward_model.dart';
import '../models/sea_passport_stamp_model.dart';
import 'profile_data.dart';

class SeaPassportData {
  SeaPassportData._();

  static const String userName = ProfileData.userName;
  static const String avatar = ProfileData.avatar;
  static const String level = ProfileData.level;
  static const String title = ProfileData.title;

  static const int xp = 15;
  static const int completedIslandCount = 1;
  static const int totalIslandCount = 7;

  static double get learningProgressValue {
    if (totalIslandCount <= 0) return 0;
    return completedIslandCount / totalIslandCount;
  }

  static int get learningProgressPercent {
    return (learningProgressValue * 100).round();
  }

  static const List<SeaPassportStampModel> stamps = [
    SeaPassportStampModel(
      id: 'ntt',
      name: 'NTT',
      image: AppImages.passportStampNtt,
      isUnlocked: true,
      order: 1,
    ),
    SeaPassportStampModel(
      id: 'ntb',
      name: 'NTB',
      isUnlocked: false,
      order: 2,
    ),
    SeaPassportStampModel(
      id: 'papua',
      name: 'Papua',
      isUnlocked: false,
      order: 3,
    ),
    SeaPassportStampModel(
      id: 'jawa',
      name: 'Jawa',
      isUnlocked: false,
      order: 4,
    ),
    SeaPassportStampModel(
      id: 'sumatra',
      name: 'Sumatra',
      isUnlocked: false,
      order: 5,
    ),
    SeaPassportStampModel(
      id: 'sulawesi',
      name: 'Sulawesi',
      isUnlocked: false,
      order: 6,
    ),
    SeaPassportStampModel(
      id: 'kalimantan',
      name: 'Kalimantan',
      isUnlocked: false,
      order: 7,
    ),
  ];

  static const List<SeaPassportRewardModel> rewards = [
    SeaPassportRewardModel(
      id: 'penjelajah_pemula',
      title: 'Penjelajah Pemula',
      description: 'Selesai 1 pulau',
      image: AppImages.rewardPenjelajahPemula,
      xpReward: 5,
      isUnlocked: true,
      order: 1,
    ),
    SeaPassportRewardModel(
      id: 'pemula_kuis',
      title: 'Pemula Kuis',
      description: 'Lulus kuis pertama',
      image: AppImages.rewardPemulaKuis,
      xpReward: 5,
      isUnlocked: true,
      order: 2,
    ),
    SeaPassportRewardModel(
      id: 'master_kuis',
      title: 'Master Kuis',
      description: 'Dapat 3 bintang sekali main',
      image: AppImages.rewardMasterKuis,
      xpReward: 5,
      isUnlocked: true,
      order: 3,
    ),
  ];

  static List<SeaPassportRewardModel> get unlockedRewards {
    final result = rewards.where((reward) => reward.isUnlocked).toList();

    result.sort((a, b) => a.order.compareTo(b.order));

    return result;
  }

  static List<SeaPassportStampModel> get orderedStamps {
    final result = [...stamps];

    result.sort((a, b) => a.order.compareTo(b.order));

    return result;
  }
}

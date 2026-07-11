import '../core/constants/app_images.dart';
import '../models/island_model.dart';

class IslandData {
  IslandData._();

  static const List<IslandModel> islands = [
    IslandModel(
      name: 'Sumatra',
      image: AppImages.islandSumatra,
      status: IslandStatus.locked,
      leftFactor: -0.05,
      topFactor: 0.12,
      widthFactor: 0.50,
    ),
    IslandModel(
      name: 'Jawa',
      image: AppImages.islandJawa,
      status: IslandStatus.locked,
      leftFactor: -0.03,
      topFactor: 0.48,
      widthFactor: 0.48,
    ),
    IslandModel(
      name: 'Kalimantan',
      image: AppImages.islandKalimantan,
      status: IslandStatus.locked,
      leftFactor: 0.36,
      topFactor: 0.01,
      widthFactor: 0.40,
    ),
    IslandModel(
      name: 'Sulawesi',
      image: AppImages.islandSulawesi,
      status: IslandStatus.locked,
      leftFactor: 0.64,
      topFactor: 0.20,
      widthFactor: 0.40,
    ),
    IslandModel(
      name: 'Papua',
      image: AppImages.islandPapua,
      status: IslandStatus.locked,
      leftFactor: 0.52,
      topFactor: 0.55,
      widthFactor: 0.52,
    ),
    IslandModel(
      name: 'NTB',
      image: AppImages.islandNtb,
      status: IslandStatus.current,
      leftFactor: -0.02,
      topFactor: 0.67,
      widthFactor: 0.48,
    ),
    IslandModel(
      name: 'NTT',
      image: AppImages.islandNtt,
      status: IslandStatus.completed,
      leftFactor: 0.40,
      topFactor: 0.80,
      widthFactor: 0.60,
      stars: 3,
    ),
  ];
}

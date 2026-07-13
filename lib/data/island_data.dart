import '../core/constants/app_images.dart';
import '../models/island_model.dart';

class IslandData {
  IslandData._();

  static const List<IslandModel> islands = [
    IslandModel(
      id: 'sumatera',
      name: 'Sumatra',
      image: AppImages.islandSumatra,
      status: IslandStatus.locked,
      leftFactor: -0.05,
      topFactor: 0.12,
      widthFactor: 0.50,
    ),
    IslandModel(
      id: 'jawa',
      name: 'Jawa',
      image: AppImages.islandJawa,
      status: IslandStatus.locked,
      leftFactor: -0.03,
      topFactor: 0.48,
      widthFactor: 0.48,
    ),
    IslandModel(
      id: 'kalimantan',
      name: 'Kalimantan',
      image: AppImages.islandKalimantan,
      status: IslandStatus.locked,
      leftFactor: 0.36,
      topFactor: 0.01,
      widthFactor: 0.40,
    ),
    IslandModel(
      id: 'sulawesi',
      name: 'Sulawesi',
      image: AppImages.islandSulawesi,
      status: IslandStatus.locked,
      leftFactor: 0.64,
      topFactor: 0.20,
      widthFactor: 0.40,
    ),
    IslandModel(
      id: 'papua',
      name: 'Papua',
      image: AppImages.islandPapua,
      status: IslandStatus.locked,
      leftFactor: 0.52,
      topFactor: 0.55,
      widthFactor: 0.52,
    ),
    IslandModel(
      id: 'ntb',
      name: 'NTB',
      image: AppImages.islandNtb,
      status: IslandStatus.locked,
      leftFactor: -0.02,
      topFactor: 0.67,
      widthFactor: 0.48,
    ),
    IslandModel(
      id: 'ntt',
      name: 'NTT',
      image: AppImages.islandNtt,
      status: IslandStatus.current,
      leftFactor: 0.40,
      topFactor: 0.80,
      widthFactor: 0.60,
      stars: 0,
    ),
  ];
}

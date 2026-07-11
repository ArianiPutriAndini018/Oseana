enum IslandStatus {
  completed,
  current,
  locked,
}

class IslandModel {
  final String name;
  final String image;
  final IslandStatus status;
  final double leftFactor;
  final double topFactor;
  final double widthFactor;

  final int stars;

  const IslandModel({
    required this.name,
    required this.image,
    required this.status,
    required this.leftFactor,
    required this.topFactor,
    required this.widthFactor,
    this.stars = 0,
  });
}

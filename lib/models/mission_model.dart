class MissionModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final int xpReward;
  final bool isCompleted;
  final int order;

  const MissionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.xpReward,
    required this.isCompleted,
    required this.order,
  });

  MissionModel copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    int? xpReward,
    bool? isCompleted,
    int? order,
  }) {
    return MissionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      xpReward: xpReward ?? this.xpReward,
      isCompleted: isCompleted ?? this.isCompleted,
      order: order ?? this.order,
    );
  }
}

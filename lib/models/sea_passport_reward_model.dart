class SeaPassportRewardModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final int xpReward;
  final bool isUnlocked;
  final int order;

  const SeaPassportRewardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.xpReward,
    required this.isUnlocked,
    required this.order,
  });

  SeaPassportRewardModel copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    int? xpReward,
    bool? isUnlocked,
    int? order,
  }) {
    return SeaPassportRewardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      xpReward: xpReward ?? this.xpReward,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      order: order ?? this.order,
    );
  }

  factory SeaPassportRewardModel.fromJson(Map<String, dynamic> json) {
    return SeaPassportRewardModel(
      id: json['slug']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      xpReward: json['xp_reward'] as int? ?? 0,
      isUnlocked: json['is_unlocked'] == true,
      order: json['order_index'] as int? ?? 0,
    );
  }
}

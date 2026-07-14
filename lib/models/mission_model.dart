class MissionModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final int xpReward;
  final String category;
  final bool isCompleted;
  final int order;

  const MissionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.xpReward,
    required this.category,
    required this.isCompleted,
    required this.order,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json, {bool isCompleted = false}) {
    return MissionModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      xpReward: (json['xp'] as num?)?.toInt() ?? 0,
      category: json['category']?.toString() ?? 'umum',
      order: (json['order_index'] as num?)?.toInt() ?? 0,
      isCompleted: isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'xp': xpReward,
      'category': category,
      'order_index': order,
    };
  }

  MissionModel copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    int? xpReward,
    String? category,
    bool? isCompleted,
    int? order,
  }) {
    return MissionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      xpReward: xpReward ?? this.xpReward,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      order: order ?? this.order,
    );
  }
}

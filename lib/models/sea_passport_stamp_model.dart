class SeaPassportStampModel {
  final String id;
  final String name;
  final String? image;
  final bool isUnlocked;
  final int order;

  const SeaPassportStampModel({
    required this.id,
    required this.name,
    this.image,
    required this.isUnlocked,
    required this.order,
  });

  bool get hasImage {
    return image != null && image!.isNotEmpty;
  }

  SeaPassportStampModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? isUnlocked,
    int? order,
  }) {
    return SeaPassportStampModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      order: order ?? this.order,
    );
  }
}

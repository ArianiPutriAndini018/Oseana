class BiotaModel {
  final String id;
  final String islandId;

  final String name;
  final String scientificName;
  final String image;
  final String summary;
  final String habitat;
  final String threat;
  final String funFact;
  final String food;
  final String videoUrl;
  final bool isLearned;
  final int order;

  const BiotaModel({
    required this.id,
    required this.islandId,
    required this.name,
    required this.scientificName,
    required this.image,
    this.summary = '',
    this.habitat = '',
    this.threat = '',
    this.funFact = '',
    this.food = '',
    this.videoUrl = '',
    this.isLearned = false,
    this.order = 0,
  });

  factory BiotaModel.fromJson(Map<String, dynamic> json) {
    return BiotaModel(
      id: json['id'].toString(),
      islandId:
          json['islandId']?.toString() ?? json['island_id']?.toString() ?? '',
      name: json['name'] ?? '',
      scientificName: json['scientificName'] ??
          json['scientific_name'] ??
          json['latinName'] ??
          json['latin_name'] ??
          '',
      image: (json['image']?.toString() ?? '').trim().replaceAll('"', ''),
      summary:
          json['summary'] ?? json['ringkasan'] ?? json['description'] ?? '',
      habitat: json['habitat'] ?? '',
      threat: json['threat'] ?? json['ancaman'] ?? '',
      funFact: json['funFact'] ?? json['fun_fact'] ?? '',
      food: json['food'] ?? json['pakan'] ?? '',
      videoUrl: json['videoUrl'] ?? json['video_url'] ?? '',
      isLearned: _asBool(
        json['isLearned'] ?? json['is_learned'],
      ),
      order: _asInt(json['order']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'islandId': islandId,
      'name': name,
      'scientificName': scientificName,
      'image': image,
      'summary': summary,
      'habitat': habitat,
      'threat': threat,
      'funFact': funFact,
      'food': food,
      'videoUrl': videoUrl,
      'isLearned': isLearned,
      'order': order,
    };
  }

  BiotaModel copyWith({
    String? id,
    String? islandId,
    String? name,
    String? scientificName,
    String? image,
    String? summary,
    String? habitat,
    String? threat,
    String? funFact,
    String? food,
    String? videoUrl,
    bool? isLearned,
    int? order,
  }) {
    return BiotaModel(
      id: id ?? this.id,
      islandId: islandId ?? this.islandId,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      image: image ?? this.image,
      summary: summary ?? this.summary,
      habitat: habitat ?? this.habitat,
      threat: threat ?? this.threat,
      funFact: funFact ?? this.funFact,
      food: food ?? this.food,
      videoUrl: videoUrl ?? this.videoUrl,
      isLearned: isLearned ?? this.isLearned,
      order: order ?? this.order,
    );
  }

  String contentByType(BiotaContentType type) {
    switch (type) {
      case BiotaContentType.summary:
        return summary;
      case BiotaContentType.habitat:
        return habitat;
      case BiotaContentType.threat:
        return threat;
      case BiotaContentType.funFact:
        return funFact;
      case BiotaContentType.food:
        return food;
    }
  }

  static bool _asBool(dynamic value) {
    if (value is bool) return value;

    if (value is num) {
      return value == 1;
    }

    if (value is String) {
      final normalized = value.toLowerCase().trim();

      return normalized == 'true' ||
          normalized == '1' ||
          normalized == 'yes' ||
          normalized == 'learned';
    }

    return false;
  }

  static int _asInt(dynamic value) {
    if (value is int) return value;

    if (value is num) {
      return value.toInt();
    }

    if (value is String) {
      return int.tryParse(value) ?? 0;
    }

    return 0;
  }
}

enum BiotaContentType {
  summary,
  habitat,
  threat,
  funFact,
  food,
}

extension BiotaContentTypeExtension on BiotaContentType {
  String get label {
    switch (this) {
      case BiotaContentType.summary:
        return 'Ringkasan';
      case BiotaContentType.habitat:
        return 'Habitat';
      case BiotaContentType.threat:
        return 'Ancaman';
      case BiotaContentType.funFact:
        return 'Fun Fact';
      case BiotaContentType.food:
        return 'Pakan';
    }
  }
}

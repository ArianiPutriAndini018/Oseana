class UserProfileModel {
  final String id;
  final String username;
  final String avatar;
  final int levelNumber;
  final String title;
  final int xp;
  final int maxXp;

  const UserProfileModel({
    required this.id,
    required this.username,
    required this.avatar,
    required this.levelNumber,
    required this.title,
    required this.xp,
    required this.maxXp,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id']?.toString() ?? '',
      username: json['username']?.toString() ?? 'Penjelajah',
      avatar: json['avatar']?.toString() ?? '',
      levelNumber: _asInt(json['level_number']),
      title: json['title']?.toString() ?? 'Pemula',
      xp: _asInt(json['xp']),
      maxXp: _asInt(json['max_xp'], defaultValue: 100),
    );
  }

  static int _asInt(dynamic value, {int defaultValue = 0}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }
}

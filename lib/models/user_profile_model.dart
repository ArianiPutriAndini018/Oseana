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

  factory UserProfileModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserProfileModel(
      id: json['id']?.toString() ?? '',
      username:
          json['username']?.toString() ??
              'Penjelajah',
      avatar:
          json['avatar']?.toString() ?? '',
      levelNumber: _asInt(
        json['level_number'],
        defaultValue: 1,
      ),
      title:
          json['title']?.toString() ??
              'Penjelajah Pemula',
      xp: _asInt(
        json['xp'],
        defaultValue: 0,
      ),
      maxXp: _asInt(
        json['max_xp'],
        defaultValue: 180,
      ),
    );
  }

  static int _asInt(
    dynamic value, {
    int defaultValue = 0,
  }) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    if (value is String) {
      return int.tryParse(value) ??
          defaultValue;
    }

    return defaultValue;
  }
}
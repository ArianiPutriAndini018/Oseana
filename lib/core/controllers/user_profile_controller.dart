import 'package:flutter/material.dart';

import '../../data/profile_data.dart';
import '../../data/repositories/biota_repository.dart';
import '../services/auth_service.dart';

class UserProfileController extends ChangeNotifier {
  UserProfileController._()
      : _userName = ProfileData.userName,
        _avatar = ProfileData.avatar {
    _loadStats();
  }

  static final UserProfileController instance = UserProfileController._();

  String _userName;
  String _avatar;

  int _xp = ProfileData.xp;
  int _maxXp = ProfileData.maxXp;
  String _level = ProfileData.level;
  String _title = ProfileData.title;
  List<ProfileStatModel> _topStats = ProfileData.orderedTopStats;
  List<ProfileStatModel> _bottomStats = ProfileData.orderedBottomStats;

  Future<void> _loadStats() async {
    final user = AuthService().currentUser;
    if (user != null) {
      // Load real profile data
      try {
        final profile = await ProfileRepository().getProfile(user.id);
        if (profile != null) {
          _xp = profile.xp;
          _maxXp = profile.maxXp;
          _level = 'Level ${profile.levelNumber}';
          _title = profile.title;
          _userName = profile.username;
          if (profile.avatar.isNotEmpty) _avatar = profile.avatar;
        }
      } catch (e) {
        print('Error loading profile: $e');
      }

      // Load Biotas Count
      try {
        final learnedBiotas = await BiotaRepository().getLearnedBiotasCount(user.id);
        final topIndex = _topStats.indexWhere((s) => s.id == 'biota_learned');
        if (topIndex != -1) {
          _topStats[topIndex] = _topStats[topIndex].copyWith(value: '$learnedBiotas/21');
        }
      } catch (e) {
        print('Error loading learned biotas: $e');
      }

      notifyListeners();
    }
  }

  String get userName => _userName;
  String get avatar => _avatar;
  int get xp => _xp;
  int get maxXp => _maxXp;
  String get level => _level;
  String get title => _title;
  List<ProfileStatModel> get topStats => _topStats;
  List<ProfileStatModel> get bottomStats => _bottomStats;

  double get xpProgressValue => _maxXp <= 0 ? 0 : _xp / _maxXp;

  void updateProfile({
    required String userName,
    required String avatar,
  }) {
    _userName = userName;
    _avatar = avatar;

    notifyListeners();
  }

  void resetGuestProfile() {
    _userName = 'Guest';
    _avatar = ProfileData.avatar;

    notifyListeners();
  }
}
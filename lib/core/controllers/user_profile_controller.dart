import 'package:flutter/material.dart';

import '../../data/profile_data.dart';
import '../../data/repositories/biota_repository.dart';
import '../../data/repositories/mission_repository.dart';
import '../../data/repositories/passport_repository.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/repositories/quiz_repository.dart';
import '../../models/profile_stat_model.dart';
import '../services/auth_service.dart';

class UserProfileController extends ChangeNotifier {
  UserProfileController._()
      : _userName = ProfileData.userName,
        _avatar = ProfileData.avatar {
    loadStats();
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

  Future<void> loadStats() async {
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

      // Load Stars
      try {
        final Map<String, dynamic> starsMap = await QuizRepository().getUserStars(user.id);
        int totalStars = 0;
        for (final star in starsMap.values) {
          totalStars += star as int;
        }
        final starIndex = _topStats.indexWhere((s) => s.id == 'total_stars');
        if (starIndex != -1) {
          _topStats[starIndex] = _topStats[starIndex].copyWith(value: '$totalStars/21');
        }
      } catch (e) {
        print('Error loading stars: $e');
      }

      // Load Stamps (Islands learned & stamps collected)
      try {
        final stamps = await PassportRepository().getStamps(user.id);
        final unlockedStampsCount = stamps.where((s) => s.isUnlocked).length;
        
        final islandIndex = _topStats.indexWhere((s) => s.id == 'islands_learned');
        if (islandIndex != -1) {
          _topStats[islandIndex] = _topStats[islandIndex].copyWith(value: '$unlockedStampsCount/7');
        }

        final stampIndex = _bottomStats.indexWhere((s) => s.id == 'stamps_collected');
        if (stampIndex != -1) {
          _bottomStats[stampIndex] = _bottomStats[stampIndex].copyWith(value: '$unlockedStampsCount/9');
        }
      } catch (e) {
        print('Error loading stamps: $e');
      }

      // Load Missions Done
      try {
        final completedMissions = await MissionRepository().getCompletedMissionIds(user.id);
        final missionIndex = _topStats.indexWhere((s) => s.id == 'missions_done');
        if (missionIndex != -1) {
          // Total missions available in MissionData is 9
          _topStats[missionIndex] = _topStats[missionIndex].copyWith(value: '${completedMissions.length}/9');
        }
      } catch (e) {
        print('Error loading missions done: $e');
      }

      // Load Badges Earned
      try {
        final rewards = await PassportRepository().getRewards(user.id);
        final unlockedCount = rewards.where((r) => r.isUnlocked).length;
            
        final badgeIndex = _bottomStats.indexWhere((s) => s.id == 'badges_earned');
        if (badgeIndex != -1) {
          _bottomStats[badgeIndex] = _bottomStats[badgeIndex].copyWith(value: '$unlockedCount/16');
        }
      } catch (e) {
        print('Error loading badges earned: $e');
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
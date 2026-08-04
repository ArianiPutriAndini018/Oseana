import 'dart:async';

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
        _avatar = ProfileData.avatar,
        _topStats = List<ProfileStatModel>.from(
          ProfileData.orderedTopStats,
        ),
        _bottomStats = List<ProfileStatModel>.from(
          ProfileData.orderedBottomStats,
        ) {
    unawaited(
      loadStats(),
    );
  }

  static final UserProfileController instance =
      UserProfileController._();

  static const int _maximumXp = 180;
  static const int _totalIslands = 7;
  static const int _totalStars = 21;
  static const int _totalBiotas = 21;
  static const int _totalMissions = 15;
  static const int _totalBadges = 16;
  static const int _totalStamps = 7;

  String _userName;
  String _avatar;

  int _xp = 0;
  int _maxXp = _maximumXp;
  int _levelNumber = 1;

  String _level = 'Level 1';
  String _title = 'Penjelajah Pemula';

  List<ProfileStatModel> _topStats;
  List<ProfileStatModel> _bottomStats;

  Future<void> loadStats() async {
    final user = AuthService().currentUser;

    if (user == null) {
      resetGuestProfile();
      return;
    }

    _resetStatistics();

    await _loadProfile(
      user.id,
    );

    await _loadBiotaStats(
      user.id,
    );

    await _loadStarStats(
      user.id,
    );

    await _loadStampStats(
      user.id,
    );

    await _loadMissionStats(
      user.id,
    );

    await _loadBadgeStats(
      user.id,
    );

    notifyListeners();
  }

  Future<void> _loadProfile(
    String userId,
  ) async {
    try {
      final profile = await ProfileRepository()
          .getProfile(
        userId,
      );

      if (profile == null) {
        _xp = 0;
        _maxXp = _maximumXp;
        _levelNumber = 1;
        _level = 'Level 1';
        _title = 'Penjelajah Pemula';
        return;
      }

      _xp = ProfileRepository.normalizeXp(
        profile.xp,
      );

      _maxXp = _maximumXp;

      _levelNumber =
          ProfileRepository.calculateLevelNumber(
        _xp,
      );

      _level = 'Level $_levelNumber';

      _title =
          ProfileRepository.calculateLevelTitle(
        _xp,
      );

      _userName = profile.username;

      if (profile.avatar.isNotEmpty) {
        _avatar = profile.avatar;
      }
    } catch (e) {
      debugPrint(
        'Error loading profile: $e',
      );
    }
  }

  Future<void> _loadBiotaStats(
    String userId,
  ) async {
    try {
      final learnedBiotas = await BiotaRepository()
          .getLearnedBiotasCount(
        userId,
      );

      final validCount = learnedBiotas.clamp(
        0,
        _totalBiotas,
      ).toInt();

      _updateTopStat(
        id: 'biota_learned',
        value: '$validCount/$_totalBiotas',
      );
    } catch (e) {
      debugPrint(
        'Error loading learned biotas: $e',
      );
    }
  }

  Future<void> _loadStarStats(
    String userId,
  ) async {
    try {
      final starsMap = await QuizRepository()
          .getUserStars(
        userId,
      );

      var totalStars = 0;

      for (final stars in starsMap.values) {
        totalStars += stars.clamp(
          0,
          3,
        ).toInt();
      }

      final validTotal = totalStars.clamp(
        0,
        _totalStars,
      ).toInt();

      _updateTopStat(
        id: 'total_stars',
        value: '$validTotal/$_totalStars',
      );
    } catch (e) {
      debugPrint(
        'Error loading stars: $e',
      );
    }
  }

  Future<void> _loadStampStats(
    String userId,
  ) async {
    try {
      final stamps = await PassportRepository()
          .getStamps(
        userId,
      );

      final unlockedIds = stamps
          .where(
            (stamp) => stamp.isUnlocked,
          )
          .map(
            (stamp) => _normalizeIslandId(
              stamp.id,
            ),
          )
          .where(
            (id) => id.isNotEmpty,
          )
          .toSet();

      final unlockedCount = unlockedIds.length.clamp(
        0,
        _totalStamps,
      ).toInt();

      _updateTopStat(
        id: 'islands_learned',
        value: '$unlockedCount/$_totalIslands',
      );

      _updateBottomStat(
        id: 'stamps_collected',
        value: '$unlockedCount/$_totalStamps',
      );
    } catch (e) {
      debugPrint(
        'Error loading stamps: $e',
      );
    }
  }

  Future<void> _loadMissionStats(
    String userId,
  ) async {
    try {
      final completedMissionIds =
          await MissionRepository()
              .getCompletedMissionIds(
        userId,
      );

      final completedCount =
          completedMissionIds.length.clamp(
        0,
        _totalMissions,
      ).toInt();

      _updateTopStat(
        id: 'missions_done',
        value: '$completedCount/$_totalMissions',
      );
    } catch (e) {
      debugPrint(
        'Error loading missions done: $e',
      );
    }
  }

  Future<void> _loadBadgeStats(
    String userId,
  ) async {
    try {
      final rewards = await PassportRepository()
          .getRewards(
        userId,
      );

      final unlockedCount = rewards
          .where(
            (reward) => reward.isUnlocked,
          )
          .length
          .clamp(
            0,
            _totalBadges,
          )
          .toInt();

      _updateBottomStat(
        id: 'badges_earned',
        value: '$unlockedCount/$_totalBadges',
      );
    } catch (e) {
      debugPrint(
        'Error loading badges earned: $e',
      );
    }
  }

  void _resetStatistics() {
    _topStats = List<ProfileStatModel>.from(
      ProfileData.orderedTopStats,
    );

    _bottomStats = List<ProfileStatModel>.from(
      ProfileData.orderedBottomStats,
    );
  }

  void _updateTopStat({
    required String id,
    required String value,
  }) {
    final index = _topStats.indexWhere(
      (stat) => stat.id == id,
    );

    if (index == -1) {
      return;
    }

    _topStats[index] = _topStats[index].copyWith(
      value: value,
    );
  }

  void _updateBottomStat({
    required String id,
    required String value,
  }) {
    final index = _bottomStats.indexWhere(
      (stat) => stat.id == id,
    );

    if (index == -1) {
      return;
    }

    _bottomStats[index] =
        _bottomStats[index].copyWith(
      value: value,
    );
  }

  String _normalizeIslandId(
    String value,
  ) {
    final normalized = value
        .trim()
        .toLowerCase();

    if (normalized == 'sumatra') {
      return 'sumatera';
    }

    return normalized;
  }

  String get userName => _userName;

  String get avatar => _avatar;

  int get xp => _xp;

  int get maxXp => _maxXp;

  int get levelNumber => _levelNumber;

  String get level => _level;

  String get title => _title;

  List<ProfileStatModel> get topStats {
    return List<ProfileStatModel>.unmodifiable(
      _topStats,
    );
  }

  List<ProfileStatModel> get bottomStats {
    return List<ProfileStatModel>.unmodifiable(
      _bottomStats,
    );
  }

  double get xpProgressValue {
    if (_maxXp <= 0) {
      return 0;
    }

    return (_xp / _maxXp).clamp(
      0.0,
      1.0,
    ).toDouble();
  }

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

    _xp = 0;
    _maxXp = _maximumXp;
    _levelNumber = 1;

    _level = 'Level 1';
    _title = 'Penjelajah Pemula';

    _resetStatistics();

    notifyListeners();
  }
}
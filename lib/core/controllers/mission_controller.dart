import 'package:flutter/material.dart';
import '../../models/mission_model.dart';
import '../../data/mission_data.dart';
import '../../core/services/auth_service.dart';
import '../../core/controllers/user_profile_controller.dart';
import '../../data/repositories/mission_repository.dart';
import '../../data/repositories/badge_unlock_service.dart';

class MissionController extends ChangeNotifier {
  MissionController._() {
    loadMissions();
  }

  static final MissionController instance = MissionController._();

  List<MissionModel> _missions = [];
  bool _isLoading = true;
  bool _isCompletingMission = false;

  bool get isLoading => _isLoading;
  bool get isCompletingMission => _isCompletingMission;

  List<MissionModel> get missions => _missions;
  
  List<MissionModel> get orderedMissions {
    final result = _missions.where((m) => !m.isCompleted).toList();
    result.sort((a, b) => a.order.compareTo(b.order));
    return result;
  }

  List<MissionModel> get previewMissions {
    return orderedMissions.take(5).toList();
  }

  int get totalMissionCount => _missions.length;
  
  int get completedMissionCount => _missions.where((m) => m.isCompleted).length;

  int get totalMissionXp => _missions.fold(0, (sum, item) => sum + item.xpReward);

  int get completedMissionXp => _missions
      .where((m) => m.isCompleted)
      .fold(0, (sum, item) => sum + item.xpReward);

  Future<void> loadMissions() async {
    _isLoading = true;
    notifyListeners();

    try {
      final repository = MissionRepository();
      List<MissionModel> loadedMissions = await MissionData.loadAllMissions();

      final currentUser = AuthService().currentUser;
      Set<String> completedIds = {};

      if (currentUser != null) {
        completedIds = await repository.getCompletedMissionIds(currentUser.id);
      }

      _missions = loadedMissions.map((m) {
        return m.copyWith(isCompleted: completedIds.contains(m.id));
      }).toList();

    } catch (e) {
      print('Error in loadMissions: $e');
      _missions = MissionData.missions; // Ultimate fallback
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Map<String, String>>> completeMission(String missionId) async {
    if (_isCompletingMission) return [];
    
    final missionIndex = _missions.indexWhere((m) => m.id == missionId);
    if (missionIndex == -1 || _missions[missionIndex].isCompleted) return [];

    final currentUser = AuthService().currentUser;
    if (currentUser == null) return []; // Guest cannot complete missions

    _isCompletingMission = true;
    notifyListeners();

    List<Map<String, String>> newBadges = [];

    try {
      final mission = _missions[missionIndex];
      
      // Persist to Supabase first!
      await MissionRepository().completeMission(currentUser.id, mission.id);

      // If successful, update local state
      _missions[missionIndex] = mission.copyWith(isCompleted: true);

      // Check for unlocked badges
      newBadges = await BadgeUnlockService().checkAndUnlockBadges(currentUser.id);

      // Refresh profile stats (XP, level, missions done)
      UserProfileController.instance.loadStats();

    } catch (e) {
      print('Failed to complete mission: $e');
      // DON'T update state if it fails
    } finally {
      _isCompletingMission = false;
      notifyListeners();
    }
    
    return newBadges;
  }
}


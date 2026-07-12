import 'package:flutter/material.dart';
import '../../models/mission_model.dart';
import '../../data/mission_data.dart';
import '../../core/services/auth_service.dart';
import '../../data/repositories/profile_repository.dart';
import 'user_profile_controller.dart';

class MissionController extends ChangeNotifier {
  MissionController._() {
    // Initialize missions from MissionData constants, making them mutable
    _missions = MissionData.initialMissions.map((m) => 
      MissionModel(
        id: m.id,
        title: m.title,
        description: m.description,
        image: m.image,
        xpReward: m.xpReward,
        isCompleted: m.isCompleted,
        order: m.order,
      )
    ).toList();
  }

  static final MissionController instance = MissionController._();

  late List<MissionModel> _missions;

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

  bool _isCompletingMission = false;
  bool get isCompletingMission => _isCompletingMission;

  Future<void> completeMission(String missionId) async {
    if (_isCompletingMission) return;
    
    final missionIndex = _missions.indexWhere((m) => m.id == missionId);
    if (missionIndex == -1 || _missions[missionIndex].isCompleted) return;

    _isCompletingMission = true;
    notifyListeners();

    try {
      final mission = _missions[missionIndex];
      
      // Update local state first for instant feedback
      _missions[missionIndex] = MissionModel(
        id: mission.id,
        title: mission.title,
        description: mission.description,
        image: mission.image,
        xpReward: mission.xpReward,
        isCompleted: true,
        order: mission.order,
      );
      
      // Update User Profile Controller XP
      UserProfileController.instance.addXp(mission.xpReward);

      // Persist to Supabase if logged in
      final currentUser = AuthService().currentUser;
      if (currentUser != null) {
        await ProfileRepository().addXp(currentUser.id, mission.xpReward);
      }
    } finally {
      _isCompletingMission = false;
      notifyListeners();
    }
  }
}

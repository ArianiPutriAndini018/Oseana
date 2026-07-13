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

  Future<void> _loadStats() async {
    final user = AuthService().currentUser;
    if (user != null) {
      final learnedBiotas = await BiotaRepository().getLearnedBiotasCount(user.id);
      
      final index = ProfileData.topStats.indexWhere((s) => s.id == 'biota_learned');
      if (index != -1) {
        final stat = ProfileData.topStats[index];
        ProfileData.topStats[index] = stat.copyWith(value: '$learnedBiotas/21');
        notifyListeners();
      }
    }
  }

  String get userName => _userName;
  String get avatar => _avatar;

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
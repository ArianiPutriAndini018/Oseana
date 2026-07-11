import 'package:flutter/material.dart';

import '../../data/profile_data.dart';

class UserProfileController extends ChangeNotifier {
  UserProfileController._()
      : _userName = ProfileData.userName,
        _avatar = ProfileData.avatar;

  static final UserProfileController instance = UserProfileController._();

  String _userName;
  String _avatar;

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
}
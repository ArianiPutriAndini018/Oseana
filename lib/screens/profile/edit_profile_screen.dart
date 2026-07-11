import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/controllers/user_profile_controller.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../data/profile_avatar_data.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../../widgets/profile/edit/edit_profile_content.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static const int _bottomNavIndex = 4;

  late final TextEditingController _nameController;

  String _selectedAvatar = ProfileAvatarData.defaultAvatar;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    final profileController = UserProfileController.instance;

    _nameController = TextEditingController(
      text: profileController.userName,
    );

    _selectedAvatar = profileController.avatar.isEmpty
        ? ProfileAvatarData.defaultAvatar
        : profileController.avatar;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.profile,
      (route) => false,
    );
  }

  void _handleBottomNavTap(int index) {
    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _bottomNavIndex,
    );
  }

  void _handleAvatarSelected(String avatar) {
    setState(() {
      _selectedAvatar = avatar;
    });
  }

  void _handleCurrentAvatarEdit() {
    FocusScope.of(context).unfocus();

    AppSnackBar.show(
      context,
      'Pilih avatar di bawah',
      backgroundColor: AppColors.primary,
    );
  }

  Future<void> _handleSave() async {
    if (_isSaving) return;

    FocusScope.of(context).unfocus();

    final name = _nameController.text.trim();

    if (name.isEmpty) {
      AppSnackBar.show(
        context,
        'Nama tidak boleh kosong',
        backgroundColor: Colors.redAccent,
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    UserProfileController.instance.updateProfile(
      userName: name,
      avatar: _selectedAvatar,
    );

    setState(() {
      _isSaving = false;
    });

    AppSnackBar.show(
      context,
      'Profil berhasil disimpan',
      backgroundColor: AppColors.primary,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          EditProfileContent(
            nameController: _nameController,
            selectedAvatar: _selectedAvatar,
            avatars: ProfileAvatarData.avatars,
            isSaving: _isSaving,
            onAvatarSelected: _handleAvatarSelected,
            onCurrentAvatarEdit: _handleCurrentAvatarEdit,
            onSave: _handleSave,
          ),

          ScreenBackButton(
            onPressed: _handleBack,
          ),

          FloatingHomeBottomNav(
            currentIndex: _bottomNavIndex,
            onTap: _handleBottomNavTap,
          ),
        ],
      ),
    );
  }
}
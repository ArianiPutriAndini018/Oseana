import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../data/checkpoint_data.dart';
import '../../data/island_data.dart';
import '../../data/mission_data.dart';
import '../../data/profile_data.dart';
import '../../data/sea_passport_data.dart';
import '../../widgets/auth/welcome_content.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _goToGuest(BuildContext context) {
    ProfileData.resetForGuest();
    MissionData.resetForGuest();
    IslandData.resetForGuest();
    CheckpointData.resetForGuest();
    SeaPassportData.resetForGuest();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  void _goToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: WelcomeContent(
        onGuestPressed: () {
          _goToGuest(context);
        },
        onLoginPressed: () {
          _goToLogin(context);
        },
        onRegisterPressed: () {
          _goToRegister(context);
        },
      ),
    );
  }
}

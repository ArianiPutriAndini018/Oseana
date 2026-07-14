import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/controllers/user_profile_controller.dart';
import '../../core/services/auth_service.dart';
import '../../data/checkpoint_data.dart';
import '../../widgets/auth/welcome_content.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import '../../core/routes/ocean_page_route.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _goToGuest(BuildContext context) async {
    try {
      await AuthService().signOut();
    } catch (_) {}

    UserProfileController.instance.resetGuestProfile();
    CheckpointData.resetGuestProgress();

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      OceanPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      OceanPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  void _goToRegister(BuildContext context) {
    Navigator.push(
      context,
      OceanPageRoute(
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

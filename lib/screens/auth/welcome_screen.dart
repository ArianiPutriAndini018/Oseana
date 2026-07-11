import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/auth/welcome_content.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _goToGuest(BuildContext context) {
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

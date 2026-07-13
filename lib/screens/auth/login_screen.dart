import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/auth/login_content.dart';
import '../../widgets/navigation/screen_back_button.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _login() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  void _forgotPassword() {
    // TODO: Forgot password
  }

  void _goToRegister() {
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
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            child: LoginContent(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
              onLogin: _login,
              onForgotPassword: _forgotPassword,
              onGoToRegister: _goToRegister,
            ),
          ),
          const ScreenBackButton(
            left: AppSpacing.md,
            topOffset: AppSpacing.md,
          ),
        ],
      ),
    );
  }
}

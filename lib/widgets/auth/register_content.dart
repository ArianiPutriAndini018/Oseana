import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../cards/auth_card.dart';
import 'register_form.dart';

class RegisterContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onRegister;
  final VoidCallback onGoToLogin;

  const RegisterContent({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegister,
    required this.onGoToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: AppSpacing.pagePadding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  constraints.maxHeight - AppSpacing.pagePadding.vertical,
            ),
            child: Center(
              child: AuthCard(
                child: RegisterForm(
                  formKey: formKey,
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  onRegister: onRegister,
                  onGoToLogin: onGoToLogin,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

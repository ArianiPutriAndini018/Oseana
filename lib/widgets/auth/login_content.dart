import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../cards/auth_card.dart';
import 'login_form.dart';

class LoginContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;
  final VoidCallback onGoToRegister;

  const LoginContent({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.onForgotPassword,
    required this.onGoToRegister,
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
                child: LoginForm(
                  formKey: formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                  onLogin: onLogin,
                  onForgotPassword: onForgotPassword,
                  onGoToRegister: onGoToRegister,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

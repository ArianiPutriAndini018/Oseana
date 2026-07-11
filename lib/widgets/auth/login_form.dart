import 'package:flutter/material.dart';

import '../../core/constants/app_icons.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../auth/auth_redirect.dart';
import '../buttons/primary_button.dart';
import '../custom_textfield.dart';
import '../text/gradient_text.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;
  final VoidCallback onGoToRegister;

  const LoginForm({
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
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GradientText(
            text: 'Login',
            textAlign: TextAlign.center,
            style: AppTextStyles.headingXL,
          ),
          AppSpacing.h48,
          CustomTextField(
            controller: emailController,
            hintText: 'Masukkan email / nama lengkap',
            prefixIcon: AppIcons.user,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: _validateEmail,
          ),
          const SizedBox(height: 22),
          CustomTextField(
            controller: passwordController,
            hintText: 'Masukkan password',
            prefixIcon: AppIcons.lock,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: _validatePassword,
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onForgotPassword,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Lupa Password?',
                style: AppTextStyles.link.copyWith(
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          AppSpacing.h32,
          PrimaryButton(
            text: 'Masuk',
            onPressed: onLogin,
          ),
          AppSpacing.h40,
          AuthRedirect(
            text: 'Belum punya akun?',
            actionText: 'Daftar di sini',
            onTap: onGoToRegister,
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }

    return null;
  }
}

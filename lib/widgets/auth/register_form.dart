import 'package:flutter/material.dart';

import '../../core/constants/app_icons.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../auth/auth_redirect.dart';
import '../buttons/primary_button.dart';
import '../custom_textfield.dart';
import '../text/gradient_text.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onRegister;
  final VoidCallback onGoToLogin;

  const RegisterForm({
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
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GradientText(
            text: 'Daftar',
            style: AppTextStyles.headingXL,
            textAlign: TextAlign.center,
          ),
          AppSpacing.h48,
          CustomTextField(
            controller: nameController,
            hintText: 'Masukkan nama lengkap',
            prefixIcon: AppIcons.user,
            textInputAction: TextInputAction.next,
            validator: _validateName,
          ),
          const SizedBox(height: 22),
          CustomTextField(
            controller: emailController,
            hintText: 'Masukkan email',
            prefixIcon: AppIcons.email,
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
            textInputAction: TextInputAction.next,
            validator: _validatePassword,
          ),
          const SizedBox(height: 22),
          CustomTextField(
            controller: confirmPasswordController,
            hintText: 'Masukkan ulang password',
            prefixIcon: AppIcons.lock,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: _validateConfirmPassword,
          ),
          AppSpacing.h40,
          PrimaryButton(
            text: 'Daftar',
            onPressed: onRegister,
          ),
          AppSpacing.h40,
          AuthRedirect(
            text: 'Sudah punya akun?',
            actionText: 'Login di sini',
            onTap: onGoToLogin,
          ),
        ],
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama lengkap tidak boleh kosong';
    }

    return null;
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

    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }

    if (value != passwordController.text) {
      return 'Password tidak sama';
    }

    return null;
  }
}

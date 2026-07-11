import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';
import '../cards/info_card.dart';

class WelcomeActions extends StatelessWidget {
  final VoidCallback onGuestPressed;
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  const WelcomeActions({
    super.key,
    required this.onGuestPressed,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          text: 'Masuk sebagai Guest',
          onPressed: onGuestPressed,
        ),
        AppSpacing.h16,
        SecondaryButton(
          text: 'Login',
          onPressed: onLoginPressed,
        ),
        AppSpacing.h16,
        SecondaryButton(
          text: 'Daftar',
          onPressed: onRegisterPressed,
        ),
        AppSpacing.h24,
        const InfoCard(
          text: 'Kamu bisa lanjut sebagai Guest tanpa perlu daftar akun.',
        ),
      ],
    );
  }
}

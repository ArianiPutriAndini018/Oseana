import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import 'welcome_actions.dart';
import 'welcome_header.dart';

class WelcomeContent extends StatelessWidget {
  final VoidCallback onGuestPressed;
  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;

  const WelcomeContent({
    super.key,
    required this.onGuestPressed,
    required this.onLoginPressed,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          children: [
            const WelcomeHeader(),
            AppSpacing.h32,
            WelcomeActions(
              onGuestPressed: onGuestPressed,
              onLoginPressed: onLoginPressed,
              onRegisterPressed: onRegisterPressed,
            ),
            AppSpacing.h32,
          ],
        ),
      ),
    );
  }
}

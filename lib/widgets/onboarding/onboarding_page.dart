import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel page;

  const OnboardingPage({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.08),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: AppColors.secondary,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 35),
          Expanded(
            child: Center(
              child: Image.asset(
                page.image,
                width: size.width * 0.92,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

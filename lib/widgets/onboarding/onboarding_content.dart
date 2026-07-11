import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../models/onboarding_model.dart';
import '../buttons/onboarding_button.dart';
import '../indicator/page_indicator.dart';
import 'onboarding_page.dart';

class OnboardingContent extends StatelessWidget {
  final PageController pageController;
  final List<OnboardingModel> pages;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onNextPressed;

  const OnboardingContent({
    super.key,
    required this.pageController,
    required this.pages,
    required this.currentPage,
    required this.onPageChanged,
    required this.onNextPressed,
  });

  bool get _isLastPage {
    return currentPage == pages.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: pages.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return OnboardingPage(
                page: pages[index],
              );
            },
          ),
        ),
        AppSpacing.h24,
        PageIndicator(
          controller: pageController,
          count: pages.length,
        ),
        AppSpacing.h32,
        OnboardingButton(
          text: _isLastPage ? 'Mulai' : 'Lanjut',
          onPressed: onNextPressed,
        ),
        AppSpacing.h32,
      ],
    );
  }
}

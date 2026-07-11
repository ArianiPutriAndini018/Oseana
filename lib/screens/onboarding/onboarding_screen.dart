import 'package:flutter/material.dart';

import '../../core/constants/app_duration.dart';
import '../../core/constants/app_spacing.dart';
import '../../data/onboarding_data.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../../widgets/onboarding/onboarding_content.dart';
import '../auth/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  int get _lastPageIndex {
    return OnboardingData.pages.length - 1;
  }

  bool get _canGoBack {
    return _currentPage > 0;
  }

  bool get _isLastPage {
    return _currentPage == _lastPageIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _nextPage() {
    if (_isLastPage) {
      _goToWelcome();
      return;
    }

    _pageController.nextPage(
      duration: AppDuration.pageTransition,
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    if (!_canGoBack) return;

    _pageController.previousPage(
      duration: AppDuration.pageTransition,
      curve: Curves.easeInOut,
    );
  }

  void _goToWelcome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            OnboardingContent(
              pageController: _pageController,
              pages: OnboardingData.pages,
              currentPage: _currentPage,
              onPageChanged: _onPageChanged,
              onNextPressed: _nextPage,
            ),
            if (_canGoBack)
              ScreenBackButton(
                left: AppSpacing.md,
                topOffset: AppSpacing.md,
                onPressed: _previousPage,
              ),
          ],
        ),
      ),
    );
  }
}

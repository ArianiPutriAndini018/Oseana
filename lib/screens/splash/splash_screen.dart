import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_duration.dart';
import '../../core/controllers/audio_controller.dart';
import '../../widgets/backgrounds/animated_splash_background.dart';
import '../../widgets/splash/splash_bubble_overlay.dart';
import '../../widgets/splash/splash_content.dart';
import '../../widgets/splash/splash_loading_bar.dart';
import '../onboarding/onboarding_screen.dart';
import '../../core/routes/ocean_page_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0;
  Timer? _loadingTimer;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    unawaited(
      AudioController.instance.playSplashUnderwaterOnce(),
    );

    _startLoading();
  }

  void _startLoading() {
    _loadingTimer = Timer.periodic(
      AppDuration.splashLoading,
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          _progress = (_progress + 0.01).clamp(0.0, 1.0);
        });

        if (_progress >= 1 && !_hasNavigated) {
          _hasNavigated = true;
          timer.cancel();

          unawaited(
            Future.delayed(
              AppDuration.splashDelay,
              _goToOnboarding,
            ),
          );
        }
      },
    );
  }

  Future<void> _goToOnboarding() async {
    if (!mounted) return;

    await AudioController.instance.playAppBacksound();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      OceanPageRoute(
        builder: (_) => const OnboardingScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedSplashBackground(),
          const Positioned.fill(
            child: SplashBubbleOverlay(),
          ),
          const SplashContent(),
          SplashLoadingBar(
            progress: _progress,
          ),
        ],
      ),
    );
  }
}

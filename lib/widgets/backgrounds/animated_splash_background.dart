import 'package:flutter/material.dart';

import '../../core/constants/app_duration.dart';
import '../../core/constants/app_images.dart';

class AnimatedSplashBackground extends StatefulWidget {
  const AnimatedSplashBackground({super.key});

  @override
  State<AnimatedSplashBackground> createState() =>
      _AnimatedSplashBackgroundState();
}

class _AnimatedSplashBackgroundState extends State<AnimatedSplashBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: AppDuration.splashAnimation,
    )..repeat(reverse: true);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.01),
      end: const Offset(0, 0.01),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.03,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            AppImages.backgroundSplash,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

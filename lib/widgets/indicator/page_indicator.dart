import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constants/app_colors.dart';

class PageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const PageIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: const ScaleEffect(
        dotWidth: 17,
        dotHeight: 17,
        spacing: 8,
        activeDotColor: AppColors.primary,
        dotColor: AppColors.border,
      ),
    );
  }
}

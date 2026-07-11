import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_spacing.dart';
import 'home_banner.dart';
import 'learning_mode_section.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(26, 18, 26, 135),
        child: Column(
          children: [
            SvgPicture.asset(
              AppImages.logo,
              width: size.width * 0.42,
              fit: BoxFit.contain,
            ),
            AppSpacing.h24,
            const HomeBanner(),
            AppSpacing.h24,
            const LearningModeSection(),
          ],
        ),
      ),
    );
  }
}

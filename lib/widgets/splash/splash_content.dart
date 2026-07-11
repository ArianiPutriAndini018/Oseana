import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/app_spacing.dart';
import '../../widgets/text/stroke_text.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
        ),
        child: Column(
          children: [
            SizedBox(height: size.height * .05),

            SvgPicture.asset(
              AppImages.logo,
              width: size.width * .9,
              fit: BoxFit.contain,
            ),

            AppSpacing.h16,

            const StrokeText(
              text: 'Sea Passport\nJelajah Biota Laut Indonesia',
              fontSize: 20,
            ),

            AppSpacing.h16,

            Expanded(
              child: Center(
                child: Image.asset(
                  AppImages.dolphinSplash,
                  width: size.width * 1.05,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
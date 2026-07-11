import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../text/gradient_text.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        AppSpacing.h32,
        GradientText(
          text: 'Selamat datang di',
          textAlign: TextAlign.center,
          style: AppTextStyles.headingLarge,
          colors: const [
            AppColors.blueBright,
            AppColors.blueDark,
          ],
          stops: const [0.27, 0.78],
        ),
        SvgPicture.asset(
          AppImages.logo,
          width: size.width * .55,
          fit: BoxFit.contain,
        ),
        AppSpacing.h40,
        Text(
          'Pilih cara masuk ke aplikasi\n'
          'sebagai Guest, Login,\n'
          'atau Daftar akun baru.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyHighlight,
        ),
      ],
    );
  }
}

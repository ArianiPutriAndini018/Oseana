import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';

class AboutOseanaScreen extends StatelessWidget {
  const AboutOseanaScreen({super.key});

  static const int _bottomNavIndex = 4;

  void _handleBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.profile,
      (route) => false,
    );
  }

  void _handleBottomNavTap(BuildContext context, int index) {
    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _bottomNavIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const _AboutContent(),
          ScreenBackButton(
            onPressed: () => _handleBack(context),
          ),
          FloatingHomeBottomNav(
            currentIndex: _bottomNavIndex,
            onTap: (index) => _handleBottomNavTap(context, index),
          ),
        ],
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isSmall ? 22 : 26,
          isSmall ? 92 : 104,
          isSmall ? 22 : 26,
          150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tentang Oseana Quest',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.blueDark,
                fontSize: isSmall ? 22 : 26,
                fontWeight: FontWeight.w900,
                height: 1.1,
                letterSpacing: 0.3,
              ),
            ),
            SizedBox(height: isSmall ? 30 : 36),
            Container(
              padding: EdgeInsets.fromLTRB(
                isSmall ? 18 : 22,
                isSmall ? 22 : 26,
                isSmall ? 18 : 22,
                isSmall ? 22 : 26,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: AppRadius.radiusXXL,
                border: Border.all(
                  color: AppColors.primary,
                  width: 3.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _AboutSection(
                    icon: Icons.waves_rounded,
                    title: 'Oseana Quest',
                    body:
                        'Oseana Quest adalah aplikasi edukasi laut Indonesia yang mengajak pengguna belajar melalui peta pulau, biota laut, kuis, misi, dan Sea Passport.',
                    isSmall: isSmall,
                  ),
                  SizedBox(height: isSmall ? 20 : 24),
                  _AboutSection(
                    icon: Icons.flag_rounded,
                    title: 'Tujuan Aplikasi',
                    body:
                        'Aplikasi ini dibuat untuk membantu pengguna mengenal kekayaan biota laut Indonesia dengan cara yang lebih interaktif dan menyenangkan.',
                    isSmall: isSmall,
                  ),
                  SizedBox(height: isSmall ? 20 : 24),
                  _AboutSection(
                    icon: Icons.public_rounded,
                    title: 'Fokus SDGs 14',
                    body:
                        'Oseana Quest mendukung pembelajaran tentang kehidupan bawah laut melalui tema konservasi, kepedulian lingkungan, dan eksplorasi biota laut.',
                    isSmall: isSmall,
                  ),
                  SizedBox(height: isSmall ? 20 : 24),
                  _AboutInfoBox(
                    isSmall: isSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final bool isSmall;

  const _AboutSection({
    required this.icon,
    required this.title,
    required this.body,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: isSmall ? 42 : 48,
          height: isSmall ? 42 : 48,
          decoration: const BoxDecoration(
            color: Color(0xFFEAF5FF),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: isSmall ? 24 : 28,
          ),
        ),
        SizedBox(width: isSmall ? 12 : 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontSize: isSmall ? 15 : 17,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              SizedBox(height: isSmall ? 8 : 10),
              Text(
                body,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textGrey,
                  fontSize: isSmall ? 12 : 13,
                  fontWeight: FontWeight.w600,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AboutInfoBox extends StatelessWidget {
  final bool isSmall;

  const _AboutInfoBox({
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        isSmall ? 14 : 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF4FAFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFDCE8F4),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          _InfoRow(
            label: 'Versi',
            value: '1.0.0',
            isSmall: isSmall,
          ),
          SizedBox(height: isSmall ? 10 : 12),
          _InfoRow(
            label: 'Platform',
            value: 'Mobile App',
            isSmall: isSmall,
          ),
          SizedBox(height: isSmall ? 10 : 12),
          _InfoRow(
            label: 'Tema',
            value: 'Edukasi Laut Indonesia',
            isSmall: isSmall,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isSmall;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textGrey,
            fontSize: isSmall ? 12 : 13,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 12 : 13,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
      ],
    );
  }
}

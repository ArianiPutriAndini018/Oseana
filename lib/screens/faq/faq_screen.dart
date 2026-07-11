import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

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
          const _FaqContent(),
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

class _FaqContent extends StatelessWidget {
  const _FaqContent();

  static const List<_FaqItemData> _items = [
    _FaqItemData(
      question: 'Apa itu Oseana Quest?',
      answer:
          'Oseana Quest adalah aplikasi edukasi interaktif untuk mengenalkan biota laut Indonesia melalui peta, misi, kuis, dan Sea Passport.',
    ),
    _FaqItemData(
      question: 'Apa itu Sea Passport?',
      answer:
          'Sea Passport adalah halaman progres belajar pengguna. Di sana pengguna bisa melihat stamp pulau, reward, XP, dan perkembangan eksplorasi.',
    ),
    _FaqItemData(
      question: 'Bagaimana cara membuka stamp pulau?',
      answer:
          'Stamp pulau akan terbuka setelah pengguna menyelesaikan pembelajaran dan berhasil menyelesaikan kuis pada pulau tersebut.',
    ),
    _FaqItemData(
      question: 'Bagaimana cara mendapatkan bintang?',
      answer:
          'Bintang didapat dari hasil kuis. Semakin banyak jawaban benar, semakin banyak bintang yang diperoleh.',
    ),
    _FaqItemData(
      question: 'Kenapa ada pulau yang masih terkunci?',
      answer:
          'Pulau terkunci karena pengguna perlu menyelesaikan pulau sebelumnya terlebih dahulu.',
    ),
    _FaqItemData(
      question: 'Apakah aplikasi ini perlu internet?',
      answer:
          'Untuk versi awal, beberapa data masih bisa dibuat lokal. Jika nanti sudah terhubung API, internet akan dibutuhkan untuk menyimpan progres pengguna.',
    ),
  ];

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
              'Bantuan & FAQ',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.blueDark,
                fontSize: isSmall ? 24 : 28,
                fontWeight: FontWeight.w900,
                height: 1,
                letterSpacing: 0.4,
              ),
            ),
            SizedBox(height: isSmall ? 30 : 36),
            Container(
              padding: EdgeInsets.all(
                isSmall ? 16 : 20,
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
                children: [
                  for (int index = 0; index < _items.length; index++) ...[
                    _FaqItem(
                      data: _items[index],
                      isSmall: isSmall,
                    ),
                    if (index != _items.length - 1)
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFDCE8F4),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final _FaqItemData data;
  final bool isSmall;

  const _FaqItem({
    required this.data,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.only(
          left: isSmall ? 2 : 4,
          right: isSmall ? 2 : 4,
          bottom: isSmall ? 14 : 16,
        ),
        iconColor: AppColors.primary,
        collapsedIconColor: AppColors.primary,
        title: Text(
          data.question,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 14 : 16,
            fontWeight: FontWeight.w900,
            height: 1.2,
          ),
        ),
        children: [
          Text(
            data.answer,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textGrey,
              fontSize: isSmall ? 12 : 13,
              fontWeight: FontWeight.w600,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqItemData {
  final String question;
  final String answer;

  const _FaqItemData({
    required this.question,
    required this.answer,
  });
}

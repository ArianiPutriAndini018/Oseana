import '../core/constants/app_images.dart';
import '../models/onboarding_model.dart';

class OnboardingData {
  OnboardingData._();

  static const pages = [
    OnboardingModel(
      title: 'Jelajahi biota laut\nIndonesia melalui\npetualangan pulau!',
      image: AppImages.onboard1,
    ),
    OnboardingModel(
      title:
          'Scan QR atau\npilih pulau, baca\nbiodata biota,\nlalu kerjakan quiz!',
      image: AppImages.onboard2,
    ),
    OnboardingModel(
      title:
          'Kumpulkan stamp,\ndapatkan XP, badge,\ndan selesaikan misi\ndi Sea Passport!',
      image: AppImages.onboard3,
    ),
  ];
}

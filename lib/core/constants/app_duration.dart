class AppDuration {
  AppDuration._();

  // =========================================================
  // General Animation
  // =========================================================

  static const veryFast = Duration(milliseconds: 100);
  static const fast = Duration(milliseconds: 200);
  static const normal = Duration(milliseconds: 300);
  static const medium = Duration(milliseconds: 500);
  static const slow = Duration(milliseconds: 800);
  static const verySlow = Duration(milliseconds: 1200);

  // =========================================================
  // Page Transition
  // =========================================================

  static const pageTransition = Duration(milliseconds: 350);

  // =========================================================
  // Button Animation
  // =========================================================

  static const buttonAnimation = Duration(milliseconds: 150);

  // =========================================================
  // PageView Animation
  // =========================================================

  static const pageView = Duration(milliseconds: 350);

  // =========================================================
  // Dialog / BottomSheet
  // =========================================================

  static const dialog = Duration(milliseconds: 250);

  // =========================================================
  // Snackbar
  // =========================================================

  static const snackbar = Duration(seconds: 3);

  // =========================================================
  // Splash Screen
  // =========================================================

  static const splashAnimation = Duration(seconds: 6);
  static const splashLoading = Duration(milliseconds: 30);
  static const splashDelay = Duration(milliseconds: 300);
}
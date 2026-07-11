import 'package:flutter/widgets.dart';

class AppSpacing {
  AppSpacing._();

  // ===== Space =====
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 40.0;
  static const double xxxl = 48.0;
  static const double huge = 64.0;

  // ===== Padding =====
  static const EdgeInsets screenPadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 20);

  static const EdgeInsets pagePadding =
      EdgeInsets.symmetric(horizontal: 28, vertical: 20);

  static const EdgeInsets contentPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 16);

  // ===== Margin =====
  static const EdgeInsets cardMargin =
      EdgeInsets.symmetric(horizontal: 20, vertical: 12);

  // ===== Common SizedBox =====
  static const SizedBox h4 = SizedBox(height: xs);
  static const SizedBox h8 = SizedBox(height: sm);
  static const SizedBox h16 = SizedBox(height: md);
  static const SizedBox h24 = SizedBox(height: lg);
  static const SizedBox h32 = SizedBox(height: xl);
  static const SizedBox h40 = SizedBox(height: xxl);
  static const SizedBox h48 = SizedBox(height: xxxl);
  static const SizedBox h64 = SizedBox(height: huge);

  static const SizedBox w4 = SizedBox(width: xs);
  static const SizedBox w8 = SizedBox(width: sm);
  static const SizedBox w16 = SizedBox(width: md);
  static const SizedBox w24 = SizedBox(width: lg);
  static const SizedBox w32 = SizedBox(width: xl);
  static const SizedBox w12 = SizedBox(width: 12);
  static const SizedBox h12 = SizedBox(height: 12);
}
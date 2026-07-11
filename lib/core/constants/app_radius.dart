import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 30.0;
  static const double card = 34.0;
  static const double circular = 999.0;
  static const BorderRadius radiusXS = BorderRadius.all(Radius.circular(xs));

  static const BorderRadius radiusSM = BorderRadius.all(Radius.circular(sm));

  static const BorderRadius radiusMD = BorderRadius.all(Radius.circular(md));

  static const BorderRadius radiusLG = BorderRadius.all(Radius.circular(lg));

  static const BorderRadius radiusXL = BorderRadius.all(Radius.circular(xl));

  static const BorderRadius radiusXXL = BorderRadius.all(Radius.circular(xxl));

  static const BorderRadius radiusXXXL =
      BorderRadius.all(Radius.circular(xxxl));

  static const BorderRadius cardRadius =
      BorderRadius.all(Radius.circular(card));

  static const BorderRadius pill = BorderRadius.all(Radius.circular(circular));
  static const BorderRadius button = radiusLG;
  static const BorderRadius textField = radiusXL;
  static const BorderRadius dialog = radiusXL;
  static const BorderRadius bottomSheet = radiusXXL;
}

import 'package:flutter/widgets.dart';

class ResponsiveUtil {
  static late double screenWidth;
  static late double screenHeight;
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;

  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double heightMultiplier;
  static late double widthMultiplier;

  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockSizeHorizontal = screenWidth / 100;
    _blockSizeVertical = screenHeight / 100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;
  }

  static double scale(double value) {
    // Basic scaling based on a reference width of 390
    return value * (screenWidth / 390);
  }

  static double scaleHeight(double value) {
    // Basic scaling based on a reference height of 844
    return value * (screenHeight / 844);
  }
}

extension ResponsiveExtension on num {
  double get rw => ResponsiveUtil.scale(this.toDouble());
  double get rh => ResponsiveUtil.scaleHeight(this.toDouble());
  double get rsp => ResponsiveUtil.scale(this.toDouble()); // for fonts
}

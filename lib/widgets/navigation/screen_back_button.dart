import 'package:flutter/material.dart';

import '../buttons/app_back_button.dart';

class ScreenBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double left;
  final double topOffset;

  const ScreenBackButton({
    super.key,
    this.onPressed,
    this.left = 22,
    this.topOffset = 18,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Positioned(
      left: left,
      top: topPadding + topOffset,
      child: AppBackButton(
        onPressed: onPressed,
      ),
    );
  }
}

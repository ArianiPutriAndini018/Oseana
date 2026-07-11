import 'package:flutter/material.dart';

import '../home/home_bottom_nav_bar.dart';

class FloatingHomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double left;
  final double right;
  final double bottom;

  const FloatingHomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.left = 24,
    this.right = 24,
    this.bottom = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      right: right,
      bottom: bottom,
      child: SafeArea(
        top: false,
        child: HomeBottomNavBar(
          currentIndex: currentIndex,
          onTap: onTap,
        ),
      ),
    );
  }
}

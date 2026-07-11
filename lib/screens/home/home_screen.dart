import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../widgets/home/home_content.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../map/map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int _currentIndex = 0;

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return;

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const MapScreen(),
        ),
      );
      return;
    }

    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      extendBody: true,
      body: Stack(
        children: [
          const HomeContent(),
          FloatingHomeBottomNav(
            currentIndex: _currentIndex,
            onTap: _onBottomNavTap,
          ),
        ],
      ),
    );
  }
}

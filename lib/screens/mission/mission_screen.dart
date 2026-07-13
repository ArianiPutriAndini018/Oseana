import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../data/mission_data.dart';
import '../../data/profile_data.dart';
import '../../models/mission_model.dart';
import '../../widgets/mission/mission_content.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';
import '../home/home_screen.dart';

class MissionScreen extends StatefulWidget {
  final bool openedFromBottomNav;

  const MissionScreen({
    super.key,
    this.openedFromBottomNav = false,
  });

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  static const int _bottomNavIndex = 3;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _handleBack(BuildContext context) {
    if (widget.openedFromBottomNav) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
        (route) => false,
      );
      return;
    }

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
      (route) => false,
    );
  }

  void _onBottomNavTap(BuildContext context, int index) {
    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _bottomNavIndex,
    );
  }

  void _handleMissionComplete(MissionModel mission) {
    setState(() {
      MissionData.missions = MissionData.missions.map((m) {
        if (m.id == mission.id) {
          return m.copyWith(isCompleted: true);
        }
        return m;
      }).toList();

      ProfileData.xp += mission.xpReward;
      MissionData.userXp += mission.xpReward;
      MissionData.completedMissionCount++;
    });

    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _handleBack(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        extendBody: true,
        body: Stack(
          children: [
            MissionContent(
              onMissionComplete: _handleMissionComplete,
            ),
            ScreenBackButton(
              onPressed: () => _handleBack(context),
            ),
            FloatingHomeBottomNav(
              currentIndex: _bottomNavIndex,
              onTap: (index) => _onBottomNavTap(context, index),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.05,
                numberOfParticles: 20,
                maxBlastForce: 100,
                minBlastForce: 80,
                gravity: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../data/mission_data.dart';
import '../../data/profile_data.dart';
import '../../models/mission_model.dart';
import '../../widgets/mission/mission_list_section.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';

class MissionListScreen extends StatefulWidget {
  const MissionListScreen({super.key});

  @override
  State<MissionListScreen> createState() => _MissionListScreenState();
}

class _MissionListScreenState extends State<MissionListScreen> {
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
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return;
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.mission,
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
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Scaffold(
      backgroundColor: AppColors.surface,
      extendBody: true,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                isSmall ? 18 : 24,
                isSmall ? 92 : 104,
                isSmall ? 18 : 24,
                150,
              ),
              child: MissionListSection(
                missions: MissionData.missions.where((m) => !m.isCompleted).toList(),
                onMissionComplete: _handleMissionComplete,
              ),
            ),
          ),

          ScreenBackButton(
            onPressed: () => _handleBack(context),
          ),

          FloatingHomeBottomNav(
            currentIndex: _bottomNavIndex,
            onTap: (index) => _handleBottomNavTap(
              context,
              index,
            ),
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
    );
  }
}
import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../data/mission_data.dart';
import '../buttons/primary_button.dart';
import 'mission_about_card.dart';
import 'mission_header.dart';
import 'mission_list_section.dart';

class MissionContent extends StatelessWidget {
  final VoidCallback? onViewAllPressed;

  const MissionContent({
    super.key,
    this.onViewAllPressed,
  });

  void _handleViewAllPressed(BuildContext context) {
    if (onViewAllPressed != null) {
      onViewAllPressed!();
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.missionList,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isSmall ? 20 : 22,
          isSmall ? 20 : 24,
          isSmall ? 20 : 22,
          135,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MissionHeader(
              userXp: MissionData.userXp,
            ),
            SizedBox(height: isSmall ? 18 : 22),
            const MissionAboutCard(
              completedMissionCount: MissionData.completedMissionCount,
              totalMissionCount: MissionData.totalMissionCount,
              completedMissionXp: MissionData.completedMissionXp,
              totalMissionXp: MissionData.totalMissionXp,
            ),
            SizedBox(height: isSmall ? 20 : 24),
            MissionListSection(
              missions: MissionData.previewMissions,
            ),
            SizedBox(height: isSmall ? 20 : 24),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 18 : 22,
              ),
              child: PrimaryButton(
                text: 'Lihat Semua Misi',
                onPressed: () => _handleViewAllPressed(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

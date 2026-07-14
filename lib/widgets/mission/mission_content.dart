import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/routes/app_routes.dart';
import '../../core/controllers/mission_controller.dart';
import '../../core/controllers/user_profile_controller.dart';
import '../buttons/primary_button.dart';
import 'mission_about_card.dart';
import 'mission_header.dart';
import 'mission_list_section.dart';

import '../../models/mission_model.dart';

class MissionContent extends StatefulWidget {
  final VoidCallback? onViewAllPressed;

  const MissionContent({
    super.key,
    this.onViewAllPressed,
  });

  @override
  State<MissionContent> createState() => _MissionContentState();
}

class _MissionContentState extends State<MissionContent> {

  void _handleViewAllPressed(BuildContext context) {
    if (widget.onViewAllPressed != null) {
      widget.onViewAllPressed!();
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.missionList,
    );
  }

  void _showFloatingXp(int xp, BuildContext buttonContext) {
    final RenderBox? renderBox = buttonContext.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    
    final position = renderBox.localToGlobal(Offset.zero);
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeOutCubic,
          onEnd: () {
            entry.remove();
          },
          builder: (context, value, child) {
            return Positioned(
              left: position.dx + 20,
              top: position.dy - (value * 80),
              child: Opacity(
                opacity: 1.0 - value,
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    '+$xp XP',
                    style: const TextStyle(
                      color: Color(0xFF048E75),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    overlay.insert(entry);
  }

  void _onMissionDone(MissionModel mission, BuildContext buttonContext) async {
    final controller = MissionController.instance;
    final newBadges = await controller.completeMission(mission.id);
    
    if (!buttonContext.mounted) return;

    // Asumsikan completeMission berhasil karena error tertangkap di controller dan gagal tidak mengubah state UI
    _showFloatingXp(mission.xpReward, buttonContext);

    if (newBadges.isNotEmpty) {
      for (final title in newBadges) {
        AppSnackBar.show(
          buttonContext,
          'Badge baru terbuka: $title',
          backgroundColor: AppColors.success,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return AnimatedBuilder(
      animation: Listenable.merge([
        MissionController.instance,
        UserProfileController.instance,
      ]),
      builder: (context, _) {
        final missionController = MissionController.instance;
        final profileController = UserProfileController.instance;

        if (missionController.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

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
                MissionHeader(
                  userXp: profileController.xp,
                ),
                SizedBox(height: isSmall ? 18 : 22),
                MissionAboutCard(
                  completedMissionCount: missionController.completedMissionCount,
                  totalMissionCount: missionController.totalMissionCount,
                  completedMissionXp: missionController.completedMissionXp,
                  totalMissionXp: missionController.totalMissionXp,
                ),
                SizedBox(height: isSmall ? 20 : 24),
                MissionListSection(
                  missions: missionController.previewMissions,
                  onMissionDone: _onMissionDone,
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
      },
    );
  }
}

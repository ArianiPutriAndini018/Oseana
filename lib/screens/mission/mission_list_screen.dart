import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../core/controllers/mission_controller.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../widgets/mission/mission_list_section.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/navigation/screen_back_button.dart';

class MissionListScreen extends StatelessWidget {
  const MissionListScreen({super.key});

  static const int _bottomNavIndex = 3;

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Scaffold(
      backgroundColor: AppColors.surface,
      extendBody: true,
      body: Stack(
        children: [
          SizedBox.expand(
            child: SafeArea(
              bottom: false,
              child: AnimatedBuilder(
                animation: MissionController.instance,
                builder: (context, _) {
                  final controller = MissionController.instance;

                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      isSmall ? 18 : 24,
                      isSmall ? 92 : 104,
                      isSmall ? 18 : 24,
                      150,
                    ),
                    child: MissionListSection(
                      missions: controller.orderedMissions,
                      onMissionDone: (mission, btnContext) async {
                        final newBadges = await controller.completeMission(mission.id);
                        if (btnContext.mounted && newBadges.isNotEmpty) {
                          for (final title in newBadges) {
                            AppSnackBar.show(
                              btnContext,
                              'Badge baru terbuka: $title',
                              backgroundColor: AppColors.success,
                            );
                          }
                        }
                      },
                    ),
                  );
                }
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
        ],
      ),
    );
  }
}
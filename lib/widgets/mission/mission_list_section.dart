import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/mission_model.dart';
import 'mission_item_card.dart';

class MissionListSection extends StatefulWidget {
  final List<MissionModel> missions;
  final void Function(MissionModel mission, BuildContext buttonContext)? onMissionDone;

  const MissionListSection({
    super.key,
    required this.missions,
    this.onMissionDone,
  });

  @override
  State<MissionListSection> createState() => _MissionListSectionState();
}

class _MissionListSectionState extends State<MissionListSection> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<MissionModel> _localMissions;

  @override
  void initState() {
    super.initState();
    _localMissions = List.from(widget.missions);
  }

  void _handleMissionDone(MissionModel mission, BuildContext buttonContext) {
    if (widget.onMissionDone != null) {
      widget.onMissionDone!(mission, buttonContext);
    }
    
    final index = _localMissions.indexOf(mission);
    if (index == -1) return;

    final removedMission = _localMissions.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedItem(removedMission, animation),
      duration: const Duration(milliseconds: 400),
    );
  }

  Widget _buildRemovedItem(MissionModel mission, Animation<double> animation) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 0.0,
      child: FadeTransition(
        opacity: animation,
        child: Padding(
          padding: EdgeInsets.only(bottom: isSmall ? 10 : 12),
          child: MissionItemCard(
            mission: mission,
            isSmall: isSmall,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daftar Misi',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.blueDark,
            fontSize: isSmall ? 20 : 23,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
        SizedBox(height: isSmall ? 12 : 14),
        if (_localMissions.isEmpty)
          _EmptyMissionMessage(isSmall: isSmall)
        else
          AnimatedList(
            key: _listKey,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            initialItemCount: _localMissions.length,
            itemBuilder: (context, index, animation) {
              final mission = _localMissions[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index != _localMissions.length - 1 ? (isSmall ? 10 : 12) : 0,
                ),
                child: MissionItemCard(
                  mission: mission,
                  isSmall: isSmall,
                  onDonePressed: (buttonContext) => _handleMissionDone(mission, buttonContext),
                ),
              );
            },
          ),
      ],
    );
  }
}

class _EmptyMissionMessage extends StatelessWidget {
  final bool isSmall;

  const _EmptyMissionMessage({
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 14 : 16,
        vertical: isSmall ? 18 : 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFD9D9D9),
          width: 2,
        ),
      ),
      child: Text(
        'Belum ada misi tersedia.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textGrey,
          fontSize: isSmall ? 12 : 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

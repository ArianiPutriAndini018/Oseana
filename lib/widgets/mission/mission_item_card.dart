import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/mission_model.dart';

class MissionItemCard extends StatelessWidget {
  final MissionModel mission;
  final bool isSmall;
  final VoidCallback? onDonePressed;

  const MissionItemCard({
    super.key,
    required this.mission,
    required this.isSmall,
    this.onDonePressed,
  });

  static const Color _borderColor = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isSmall ? 10 : 12,
        isSmall ? 10 : 12,
        isSmall ? 8 : 10,
        isSmall ? 10 : 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: _borderColor,
          width: 2,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _MissionIcon(
            image: mission.image,
            isSmall: isSmall,
          ),
          SizedBox(width: isSmall ? 10 : 12),
          Expanded(
            child: _MissionInfo(
              title: mission.title,
              description: mission.description,
              isSmall: isSmall,
            ),
          ),
          SizedBox(width: isSmall ? 6 : 8),
          _MissionActionColumn(
            xpReward: mission.xpReward,
            isCompleted: mission.isCompleted,
            isSmall: isSmall,
            onPressed: onDonePressed,
          ),
        ],
      ),
    );
  }
}

class _MissionIcon extends StatelessWidget {
  final String image;
  final bool isSmall;

  const _MissionIcon({
    required this.image,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final size = isSmall ? 72.0 : 82.0;

    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Transform.scale(
          scale: 1.14,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _MissionInfo extends StatelessWidget {
  final String title;
  final String description;
  final bool isSmall;

  const _MissionInfo({
    required this.title,
    required this.description,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: isSmall ? 1 : 2,
        bottom: isSmall ? 1 : 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            softWrap: true,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.blueDark,
              fontSize: isSmall ? 11.8 : 13.2,
              fontWeight: FontWeight.w900,
              height: 1.08,
            ),
          ),
          SizedBox(height: isSmall ? 5 : 6),
          Text(
            description,
            softWrap: true,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textGrey,
              fontSize: isSmall ? 8.2 : 9.2,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionActionColumn extends StatelessWidget {
  final int xpReward;
  final bool isCompleted;
  final bool isSmall;
  final VoidCallback? onPressed;

  const _MissionActionColumn({
    required this.xpReward,
    required this.isCompleted,
    required this.isSmall,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmall ? 70 : 76,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MissionXpBadge(
            xpReward: xpReward,
            isSmall: isSmall,
          ),
          SizedBox(height: isSmall ? 7 : 8),
          _MissionDoneButton(
            isCompleted: isCompleted,
            isSmall: isSmall,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class _MissionXpBadge extends StatelessWidget {
  final int xpReward;
  final bool isSmall;

  const _MissionXpBadge({
    required this.xpReward,
    required this.isSmall,
  });

  static const Color _borderColor = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isSmall ? 62 : 68,
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 5 : 6,
        vertical: isSmall ? 4 : 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusMD,
        border: Border.all(
          color: _borderColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.missionXpIcon,
            width: isSmall ? 14 : 16,
            height: isSmall ? 14 : 16,
            fit: BoxFit.contain,
          ),
          SizedBox(width: isSmall ? 2 : 3),
          Text(
            '$xpReward XP',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.blueDark,
              fontSize: isSmall ? 8.8 : 9.8,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionDoneButton extends StatelessWidget {
  final bool isCompleted;
  final bool isSmall;
  final VoidCallback? onPressed;

  const _MissionDoneButton({
    required this.isCompleted,
    required this.isSmall,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmall ? 66 : 72,
      height: isSmall ? 30 : 32,
      child: Material(
        color: AppColors.white,
        borderRadius: AppRadius.radiusMD,
        child: InkWell(
          borderRadius: AppRadius.radiusMD,
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppRadius.radiusMD,
              border: Border.all(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            child: Text(
              'Sudah\ndilakukan',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.primary,
                fontSize: isSmall ? 8 : 8.6,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

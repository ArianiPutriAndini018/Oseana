import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/sea_passport_reward_model.dart';

class SeaPassportRewardItem extends StatelessWidget {
  final SeaPassportRewardModel reward;
  final bool isSmall;

  const SeaPassportRewardItem({
    super.key,
    required this.reward,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmall ? 92 : 104,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            reward.image,
            width: isSmall ? 68 : 78,
            height: isSmall ? 68 : 78,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return SizedBox(
                width: isSmall ? 68 : 78,
                height: isSmall ? 68 : 78,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.image_not_supported_outlined,
                size: isSmall ? 68 : 78,
                color: Colors.grey,
              );
            },
          ),
          SizedBox(height: isSmall ? 3 : 4),
          Text(
            reward.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.blueDark,
              fontSize: isSmall ? 8.8 : 9.8,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          SizedBox(height: isSmall ? 1 : 2),
          SizedBox(
            height: isSmall ? 19 : 21,
            child: Text(
              reward.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textGrey,
                fontSize: isSmall ? 8 : 8.8,
                fontWeight: FontWeight.w700,
                height: 1.05,
              ),
            ),
          ),
          SizedBox(height: isSmall ? 4 : 5),
          _RewardXpBadge(
            xpReward: reward.xpReward,
            isSmall: isSmall,
          ),
        ],
      ),
    );
  }
}

class _RewardXpBadge extends StatelessWidget {
  final int xpReward;
  final bool isSmall;

  const _RewardXpBadge({
    required this.xpReward,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 6 : 7,
        vertical: isSmall ? 2 : 3,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFD8F8D8),
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImages.passportXpIcon,
            width: isSmall ? 10 : 11,
            height: isSmall ? 10 : 11,
            fit: BoxFit.contain,
          ),
          SizedBox(width: isSmall ? 2 : 3),
          Text(
            '+$xpReward XP',
            style: AppTextStyles.caption.copyWith(
              color: const Color(0xFF18A84A),
              fontSize: isSmall ? 8 : 8.8,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

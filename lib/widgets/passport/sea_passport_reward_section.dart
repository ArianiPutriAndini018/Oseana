import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/sea_passport_reward_model.dart';
import 'sea_passport_reward_item.dart';

class SeaPassportRewardSection extends StatelessWidget {
  final List<SeaPassportRewardModel> rewards;

  const SeaPassportRewardSection({
    super.key,
    required this.rewards,
  });

  static const Color _borderColor = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isSmall ? 10 : 12,
        isSmall ? 8 : 10,
        isSmall ? 10 : 12,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Badge & Reward',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.blueDark,
              fontSize: isSmall ? 14 : 16,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          SizedBox(height: isSmall ? 6 : 8),
          if (rewards.isEmpty)
            _EmptyRewardMessage(isSmall: isSmall)
          else
            SizedBox(
              height: isSmall ? 134 : 144,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: rewards.length,
                separatorBuilder: (context, index) {
                  return SizedBox(width: isSmall ? 8 : 10);
                },
                itemBuilder: (context, index) {
                  return SeaPassportRewardItem(
                    reward: rewards[index],
                    isSmall: isSmall,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyRewardMessage extends StatelessWidget {
  final bool isSmall;

  const _EmptyRewardMessage({
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isSmall ? 18 : 20,
      ),
      child: Text(
        'Belum ada badge yang terbuka.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textGrey,
          fontSize: isSmall ? 11 : 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

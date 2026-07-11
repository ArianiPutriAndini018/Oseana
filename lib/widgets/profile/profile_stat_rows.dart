import 'package:flutter/material.dart';

import '../../models/profile_stat_model.dart';
import 'profile_stat_item.dart';

class ProfileTopStatsRow extends StatelessWidget {
  final List<ProfileStatModel> stats;
  final bool isSmall;

  const ProfileTopStatsRow({
    super.key,
    required this.stats,
    required this.isSmall,
  });

  static const Color _dividerColor = Color(0xFFD3E1F0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmall ? 98 : 112,
      child: Row(
        children: [
          for (int index = 0; index < stats.length; index++) ...[
            Expanded(
              child: ProfileStatItem(
                stat: stats[index],
                isSmall: isSmall,
              ),
            ),
            if (index != stats.length - 1)
              Container(
                width: 1.4,
                height: isSmall ? 70 : 82,
                color: _dividerColor,
              ),
          ],
        ],
      ),
    );
  }
}

class ProfileBottomStatsRow extends StatelessWidget {
  final List<ProfileStatModel> stats;
  final bool isSmall;

  const ProfileBottomStatsRow({
    super.key,
    required this.stats,
    required this.isSmall,
  });

  static const Color _dividerColor = Color(0xFFD3E1F0);

  @override
  Widget build(BuildContext context) {
    if (stats.length < 2) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: isSmall ? 92 : 104,
      child: Row(
        children: [
          Expanded(
            child: ProfileStatItem(
              stat: stats[0],
              isSmall: isSmall,
              isWide: true,
            ),
          ),
          Container(
            width: 1.4,
            height: isSmall ? 70 : 82,
            color: _dividerColor,
          ),
          Expanded(
            child: ProfileStatItem(
              stat: stats[1],
              isSmall: isSmall,
              isWide: true,
            ),
          ),
        ],
      ),
    );
  }
}

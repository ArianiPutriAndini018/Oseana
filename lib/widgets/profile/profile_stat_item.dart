import 'package:flutter/material.dart';

import '../../models/profile_stat_model.dart';
import 'profile_stat_compact_item.dart';
import 'profile_stat_wide_item.dart';

class ProfileStatItem extends StatelessWidget {
  final ProfileStatModel stat;
  final bool isSmall;
  final bool isWide;

  const ProfileStatItem({
    super.key,
    required this.stat,
    required this.isSmall,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isWide) {
      return ProfileStatWideItem(
        stat: stat,
        isSmall: isSmall,
      );
    }

    return ProfileStatCompactItem(
      stat: stat,
      isSmall: isSmall,
    );
  }
}

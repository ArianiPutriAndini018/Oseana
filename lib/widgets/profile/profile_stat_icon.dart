import 'package:flutter/material.dart';

import '../../models/profile_stat_model.dart';

class ProfileStatIcon extends StatelessWidget {
  final ProfileStatModel stat;
  final double size;

  const ProfileStatIcon({
    super.key,
    required this.stat,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final iconAsset = stat.iconAsset;

    if (iconAsset != null) {
      return Image.asset(
        iconAsset,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            stat.fallbackIcon,
            color: stat.fallbackIconColor,
            size: size,
          );
        },
      );
    }

    return Icon(
      stat.fallbackIcon,
      color: stat.fallbackIconColor,
      size: size,
    );
  }
}

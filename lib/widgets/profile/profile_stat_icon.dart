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
    final bool isZeroStar = stat.id == 'total_stars' && stat.value.startsWith('0/');

    if (iconAsset != null) {
      Widget image = Image.asset(
        iconAsset,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            stat.fallbackIcon,
            color: isZeroStar ? Colors.grey : stat.fallbackIconColor,
            size: size,
          );
        },
      );

      if (isZeroStar) {
        return ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Colors.grey,
            BlendMode.srcIn,
          ),
          child: image,
        );
      }

      return image;
    }

    return Icon(
      stat.fallbackIcon,
      color: isZeroStar ? Colors.grey : stat.fallbackIconColor,
      size: size,
    );
  }
}

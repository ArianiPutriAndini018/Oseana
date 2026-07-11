import 'package:flutter/material.dart';

import '../../core/constants/app_radius.dart';

class MissionStatDivider extends StatelessWidget {
  final bool isSmall;

  const MissionStatDivider({
    super.key,
    required this.isSmall,
  });

  static const Color _dividerColor = Color(0xFFDCE8F4);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: isSmall ? 56 : 64,
      margin: EdgeInsets.symmetric(
        horizontal: isSmall ? 5 : 7,
      ),
      decoration: const BoxDecoration(
        color: _dividerColor,
        borderRadius: AppRadius.pill,
      ),
    );
  }
}
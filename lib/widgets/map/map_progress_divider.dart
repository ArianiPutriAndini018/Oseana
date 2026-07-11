import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class MapProgressDivider extends StatelessWidget {
  const MapProgressDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: double.infinity,
      color: AppColors.border,
    );
  }
}

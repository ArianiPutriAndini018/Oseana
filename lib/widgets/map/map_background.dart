import 'package:flutter/material.dart';

import '../../core/constants/app_images.dart';

class MapBackground extends StatelessWidget {
  const MapBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        AppImages.mapBackground,
        fit: BoxFit.cover,
      ),
    );
  }
}

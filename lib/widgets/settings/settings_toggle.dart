import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class SettingsToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  static const Color _activeColor = Color(0xFF12A83A);
  static const Color _inactiveColor = Color(0xFFD8D8D8);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    final toggleWidth = isSmall ? 42.0 : 50.0;
    final toggleHeight = isSmall ? 25.0 : 30.0;
    final thumbSize = isSmall ? 19.0 : 24.0;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: toggleWidth,
        height: toggleHeight,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: value ? _activeColor : _inactiveColor,
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: thumbSize,
            height: thumbSize,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
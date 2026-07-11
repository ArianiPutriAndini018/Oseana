import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class EditProfileNameField extends StatelessWidget {
  final TextEditingController controller;

  const EditProfileNameField({
    super.key,
    required this.controller,
  });

  static const Color _borderColor = Color(0xFFD3D3D3);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return TextField(
      controller: controller,
      textInputAction: TextInputAction.done,
      cursorColor: AppColors.primary,
      style: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.primary,
        fontSize: isSmall ? 12 : 14,
        fontWeight: FontWeight.w900,
        height: 1,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(
          isSmall ? 18 : 20,
          isSmall ? 15 : 17,
          isSmall ? 8 : 10,
          isSmall ? 15 : 17,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            right: isSmall ? 16 : 18,
          ),
          child: Icon(
            Icons.edit_rounded,
            color: AppColors.primary,
            size: isSmall ? 20 : 22,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(
            color: _borderColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(
            color: _borderColor,
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(
            color: _borderColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
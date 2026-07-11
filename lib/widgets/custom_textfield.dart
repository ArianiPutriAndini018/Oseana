import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_icons.dart';
import '../core/constants/app_radius.dart';
import '../core/constants/app_spacing.dart';
import '../core/constants/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final bool enabled;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      obscureText: widget.isPassword && _obscureText,
      cursorColor: AppColors.primary,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.secondary,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.hint,

        filled: true,
        fillColor: AppColors.surface,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md + AppSpacing.sm,
          vertical: 18,
        ),

        prefixIcon: _buildPrefixIcon(),

        prefixIconConstraints: const BoxConstraints(
          minWidth: 56,
          minHeight: 56,
        ),

        suffixIcon: widget.isPassword ? _buildSuffixIcon() : null,

        enabledBorder: _border(AppColors.border, 2.5),

        focusedBorder: _border(AppColors.primary, 2.5),

        errorBorder: _border(AppColors.error, 2),

        focusedErrorBorder: _border(AppColors.error, 2),
      ),
    );
  }

  Widget _buildPrefixIcon() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: SvgPicture.asset(
        widget.prefixIcon,
        width: 22,
        height: 24,
        colorFilter: const ColorFilter.mode(
          AppColors.textSecondary,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return IconButton(
      splashRadius: 20,
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      icon: SvgPicture.asset(
        _obscureText ? AppIcons.eyeOff : AppIcons.eye,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          AppColors.textSecondary,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  OutlineInputBorder _border(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: AppRadius.radiusXXL,
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}
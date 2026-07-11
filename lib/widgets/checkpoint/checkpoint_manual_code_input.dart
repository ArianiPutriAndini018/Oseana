import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_text_styles.dart';

class CheckpointManualCodeInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final bool showClearButton;

  const CheckpointManualCodeInput({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.onSubmitted,
    this.enabled = true,
    this.showClearButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ManualInputDivider(
          label: label,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56,
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  onSubmitted: onSubmitted,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  cursorColor: AppColors.primary,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                    letterSpacing: 1.2,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      letterSpacing: 1.2,
                    ),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 15,
                    ),
                    suffixIcon: showClearButton
                        ? ValueListenableBuilder<TextEditingValue>(
                            valueListenable: controller,
                            builder: (context, value, _) {
                              if (value.text.isEmpty) {
                                return const SizedBox.shrink();
                              }

                              return IconButton(
                                onPressed: () {
                                  controller.clear();
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  size: 30,
                                  color: AppColors.primary,
                                ),
                              );
                            },
                          )
                        : null,
                    enabledBorder: _border(AppColors.primary),
                    focusedBorder: _border(AppColors.primary),
                    disabledBorder: _border(AppColors.primary),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              height: 56,
              width: 56,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  borderRadius: AppRadius.radiusXL,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0045B1),
                      Color(0xFF035FCB),
                    ],
                    stops: [0.30, 0.67],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (onSubmitted != null && controller.text.isNotEmpty) {
                      onSubmitted!(controller.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    disabledForegroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.radiusXL,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: AppRadius.radiusXL,
      borderSide: BorderSide(
        color: color,
        width: 2.8,
      ),
    );
  }
}

class _ManualInputDivider extends StatelessWidget {
  final String label;

  const _ManualInputDivider({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.primary,
            thickness: 1.5,
            endIndent: 12,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
            letterSpacing: 0.5,
            height: 1,
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.primary,
            thickness: 1.5,
            indent: 12,
          ),
        ),
      ],
    );
  }
}

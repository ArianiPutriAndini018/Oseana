import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class EditProfileSaveButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const EditProfileSaveButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Opacity(
        opacity: isLoading ? 0.75 : 1,
        child: Container(
          height: isSmall ? 56 : 62,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D75DE),
                Color(0xFF004CB8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: isLoading
              ? const SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.white,
                  ),
                )
              : Text(
                  'Simpan',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.white,
                    fontSize: isSmall ? 14 : 18,
                    fontWeight: FontWeight.w900,
                    height: 1,
                    letterSpacing: 1.2,
                  ),
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_text_styles.dart';

class QuizOptionTile extends StatelessWidget {
  final String letter;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback? onTap;

  const QuizOptionTile({
    super.key,
    required this.letter,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    required this.onTap,
  });

  bool get _showCorrectIcon {
    return showResult && isSelected && isCorrect;
  }

  bool get _showWrongIcon {
    return showResult && isSelected && !isCorrect;
  }

  Color get _borderColor {
    if (_showWrongIcon) return AppColors.error;
    if (isSelected) return AppColors.primary;
    return AppColors.primary.withOpacity(0.55);
  }

  Color get _backgroundColor {
    if (_showWrongIcon) return AppColors.error.withOpacity(0.05);
    if (isSelected) return AppColors.blueSoft.withOpacity(0.18);
    return AppColors.white;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.radiusMD,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: isSmall ? 40 : 44,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 8 : 10,
            vertical: isSmall ? 6 : 7,
          ),
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: AppRadius.radiusMD,
            border: Border.all(
              color: _borderColor,
              width: isSelected ? 1.4 : 1,
            ),
          ),
          child: Row(
            children: [
              _OptionLetterBadge(
                letter: letter,
                isSmall: isSmall,
              ),

              SizedBox(width: isSmall ? 8 : 9),

              Expanded(
                child: Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primary,
                    fontSize: isSmall ? 11.5 : 12.5,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ),

              if (_showCorrectIcon) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: isSmall ? 20 : 22,
                ),
              ],

              if (_showWrongIcon) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.cancel_rounded,
                  color: AppColors.error,
                  size: isSmall ? 20 : 22,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionLetterBadge extends StatelessWidget {
  final String letter;
  final bool isSmall;

  const _OptionLetterBadge({
    required this.letter,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final size = isSmall ? 24.0 : 26.0;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.blueSoft.withOpacity(0.18),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.45),
          width: 1,
        ),
      ),
      child: Text(
        letter,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontSize: isSmall ? 11 : 12,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

class QuizResultActionButtons extends StatelessWidget {
  final bool isSmall;
  final String primaryButtonText;
  final VoidCallback onPrimaryPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  const QuizResultActionButtons({
    super.key,
    required this.isSmall,
    required this.primaryButtonText,
    required this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
  });

  bool get _hasSecondaryButton {
    return secondaryButtonText != null && onSecondaryPressed != null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 28 : 34,
          ),
          child: PrimaryButton(
            text: primaryButtonText,
            onPressed: onPrimaryPressed,
          ),
        ),

        if (_hasSecondaryButton) ...[
          SizedBox(height: isSmall ? 12 : 14),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 28 : 34,
            ),
            child: SecondaryButton(
              text: secondaryButtonText!,
              onPressed: onSecondaryPressed,
            ),
          ),
        ],
      ],
    );
  }
}
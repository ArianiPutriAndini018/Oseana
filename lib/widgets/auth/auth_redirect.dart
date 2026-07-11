import 'package:flutter/material.dart';

import '../../core/constants/app_text_styles.dart';

class AuthRedirect extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const AuthRedirect({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: AppTextStyles.bodySmall,
          textAlign: TextAlign.center,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            actionText,
            style: AppTextStyles.link,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

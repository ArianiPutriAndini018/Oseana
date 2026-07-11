import 'package:flutter/material.dart';

import '../buttons/primary_button.dart';
import '../checkpoint/checkpoint_manual_code_input.dart';

class QrScanManualSection extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isLoading;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback onOpenPressed;

  const QrScanManualSection({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.onOpenPressed,
    this.isLoading = false,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckpointManualCodeInput(
          controller: controller,
          label: label,
          hintText: hintText,
          onSubmitted: onSubmitted,
        ),
        const SizedBox(height: 22),
        PrimaryButton(
          text: 'Buka',
          onPressed: isLoading ? null : onOpenPressed,
        ),
      ],
    );
  }
}
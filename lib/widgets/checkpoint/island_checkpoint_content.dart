import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/island_checkpoint_model.dart';
import '../buttons/primary_button.dart';
import '../cards/info_card.dart';
import 'checkpoint_banner.dart';
import 'checkpoint_biota_grid.dart';
import 'checkpoint_manual_code_input.dart';
import 'checkpoint_progress_card.dart';

class IslandCheckpointContent extends StatelessWidget {
  final IslandCheckpointModel checkpoint;
  final TextEditingController manualCodeController;
  final VoidCallback onScanQrPressed;
  final ValueChanged<String> onManualCodeSubmitted;

  const IslandCheckpointContent({
    super.key,
    required this.checkpoint,
    required this.manualCodeController,
    required this.onScanQrPressed,
    required this.onManualCodeSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isSmall ? 20 : 24,
          78,
          isSmall ? 20 : 24,
          135,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              checkpoint.title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLarge.copyWith(
                fontSize: isSmall ? 24 : 27,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 22),
            CheckpointBanner(
              image: checkpoint.bannerImage,
              height: isSmall ? 138 : 142,
            ),
            const SizedBox(height: 22),
            CheckpointProgressCard(
              title: checkpoint.progressTitle,
              progress: checkpoint.progress,
            ),
            const SizedBox(height: 24),
            CheckpointBiotaGrid(
              biotas: checkpoint.biotas,
              title: checkpoint.biotaSectionTitle,
            ),
            const SizedBox(height: 26),
            PrimaryButton(
              text: checkpoint.scanButtonText,
              icon: Icons.qr_code_scanner_rounded,
              onPressed: onScanQrPressed,
            ),
            const SizedBox(height: 28),
            CheckpointManualCodeInput(
              controller: manualCodeController,
              label: checkpoint.manualInputLabel,
              hintText: checkpoint.manualCodeHint,
              onSubmitted: onManualCodeSubmitted,
            ),
            const SizedBox(height: 18),
            InfoCard(
              text: checkpoint.infoText,
              icon: Icons.info_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

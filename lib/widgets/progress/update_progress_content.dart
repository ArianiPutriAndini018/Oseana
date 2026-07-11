import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_images.dart';
import '../../models/island_checkpoint_model.dart';
import '../buttons/primary_button.dart';
import 'update_progress_card.dart';

class UpdateProgressContent extends StatelessWidget {
  final IslandCheckpointModel checkpoint;
  final VoidCallback onContinuePressed;

  const UpdateProgressContent({
    super.key,
    required this.checkpoint,
    required this.onContinuePressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isSmall ? 20 : 22,
          isSmall ? 38 : 44,
          isSmall ? 20 : 22,
          135,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              AppImages.logo,
              width: isSmall ? 150 : 164,
              fit: BoxFit.contain,
            ),

            SizedBox(height: isSmall ? 48 : 52),

            UpdateProgressCard(
              checkpoint: checkpoint,
            ),

            SizedBox(height: isSmall ? 32 : 36),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 28 : 34,
              ),
              child: PrimaryButton(
                text: 'Lanjut ke Sea Passport',
                onPressed: onContinuePressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
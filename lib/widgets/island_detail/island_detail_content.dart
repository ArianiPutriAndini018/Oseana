import 'package:flutter/material.dart';

import '../../models/biota_model.dart';
import '../../models/island_checkpoint_model.dart';
import '../buttons/primary_button.dart';
import 'island_biota_list.dart';
import 'island_detail_header.dart';
import 'island_detail_info_card.dart';

class IslandDetailContent extends StatelessWidget {
  final IslandCheckpointModel checkpoint;
  final ValueChanged<BiotaModel> onBiotaTap;
  final VoidCallback onQuizPressed;

  const IslandDetailContent({
    super.key,
    required this.checkpoint,
    required this.onBiotaTap,
    required this.onQuizPressed,
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
            IslandDetailHeader(
              checkpoint: checkpoint,
            ),
            const SizedBox(height: 28),
            IslandDetailInfoCard(
              checkpoint: checkpoint,
            ),
            const SizedBox(height: 26),
            IslandBiotaList(
              biotas: checkpoint.biotas,
              onBiotaTap: onBiotaTap,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 38 : 46,
              ),
              child: PrimaryButton(
                text: checkpoint.quizButtonText,
                onPressed: onQuizPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

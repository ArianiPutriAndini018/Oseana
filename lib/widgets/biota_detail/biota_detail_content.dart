import 'package:flutter/material.dart';

import '../../models/biota_model.dart';
import 'biota_content_card.dart';
import 'biota_detail_actions.dart';
import 'biota_header.dart';
import 'biota_image_card.dart';

class BiotaDetailContent extends StatelessWidget {
  final BiotaModel biota;
  final BiotaContentType selectedType;
  final ValueChanged<BiotaContentType> onTypeChanged;
  final VoidCallback onVideoPressed;
  final VoidCallback onLearnOtherPressed;

  const BiotaDetailContent({
    super.key,
    required this.biota,
    required this.selectedType,
    required this.onTypeChanged,
    required this.onVideoPressed,
    required this.onLearnOtherPressed,
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
            BiotaHeader(
              biota: biota,
            ),
            const SizedBox(height: 28),
            BiotaImageCard(
              biota: biota,
              width: isSmall ? 240 : 270,
              height: isSmall ? 135 : 150,
            ),
            const SizedBox(height: 28),
            BiotaContentCard(
              biota: biota,
              selectedType: selectedType,
              onTypeChanged: onTypeChanged,
            ),
            const SizedBox(height: 28),
            BiotaDetailActions(
              onVideoPressed: onVideoPressed,
              onLearnOtherPressed: onLearnOtherPressed,
            ),
          ],
        ),
      ),
    );
  }
}

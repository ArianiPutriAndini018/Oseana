import 'package:flutter/material.dart';

import '../buttons/secondary_button.dart';

class BiotaDetailActions extends StatelessWidget {
  final VoidCallback onVideoPressed;
  final VoidCallback onLearnOtherPressed;

  const BiotaDetailActions({
    super.key,
    required this.onVideoPressed,
    required this.onLearnOtherPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 20 : 30,
      ),
      child: Column(
        children: [
          VideoSecondaryButton(
            text: 'Lihat Video',
            onPressed: onVideoPressed,
          ),
          const SizedBox(height: 22),
          SecondaryButton(
            text: 'Pelajari Biota Lain',
            onPressed: onLearnOtherPressed,
          ),
        ],
      ),
    );
  }
}

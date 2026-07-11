import 'package:flutter/material.dart';

import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

class BiotaVideoActions extends StatelessWidget {
  final VoidCallback onWatchVideoPressed;
  final VoidCallback onLearnOtherPressed;
  final VoidCallback onQuizPressed;

  const BiotaVideoActions({
    super.key,
    required this.onWatchVideoPressed,
    required this.onLearnOtherPressed,
    required this.onQuizPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 42 : 46,
      ),
      child: Column(
        children: [
          VideoSecondaryButton(
            text: 'Tonton Video',
            onPressed: onWatchVideoPressed,
          ),
          const SizedBox(height: 18),
          PrimaryButton(
            text: 'Pelajari Biota Lain',
            onPressed: onLearnOtherPressed,
          ),
          const SizedBox(height: 18),
          PrimaryButton(
            text: 'Mulai Quiz',
            onPressed: onQuizPressed,
          ),
        ],
      ),
    );
  }
}

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_images.dart';
import '../../models/island_checkpoint_model.dart';
import '../buttons/primary_button.dart';
import 'stamp_unlocked_card.dart';

class StampUnlockedContent extends StatefulWidget {
  final IslandCheckpointModel checkpoint;
  final VoidCallback onSeaPassportPressed;

  const StampUnlockedContent({
    super.key,
    required this.checkpoint,
    required this.onSeaPassportPressed,
  });

  @override
  State<StampUnlockedContent> createState() => _StampUnlockedContentState();
}

class _StampUnlockedContentState extends State<StampUnlockedContent>
    with TickerProviderStateMixin {
  late final AnimationController _stampController;
  late final AnimationController _idleController;
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _stampController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );

    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    _stampController.addStatusListener(_handleStampStatus);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _confettiController.play();
      _stampController.forward();
    });
  }

  void _handleStampStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      _idleController.repeat();
    }
  }

  @override
  void dispose() {
    _stampController.removeStatusListener(_handleStampStatus);
    _stampController.dispose();
    _idleController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

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
            SizedBox(height: isSmall ? 42 : 46),
            StampUnlockedCard(
              isSmall: isSmall,
              stampAnimation: _stampController,
              idleAnimation: _idleController,
              confettiController: _confettiController,
            ),
            SizedBox(height: isSmall ? 26 : 30),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 28 : 34,
              ),
              child: PrimaryButton(
                text: 'Lanjut ke Sea Passport',
                onPressed: widget.onSeaPassportPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

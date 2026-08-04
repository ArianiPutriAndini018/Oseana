import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/island_data.dart';
import '../../data/repositories/passport_repository.dart';
import '../../models/island_checkpoint_model.dart';
import '../../models/sea_passport_stamp_model.dart';
import 'quiz_result_dashed_divider.dart';
import 'quiz_result_score_label.dart';
import 'quiz_result_star_row.dart';
import 'quiz_result_xp_reward_line.dart';

class QuizResultSuccessContent extends StatefulWidget {
  final IslandCheckpointModel checkpoint;
  final int scorePercentage;
  final int xpReward;
  final Color scoreColor;
  final bool isSmall;

  const QuizResultSuccessContent({
    super.key,
    required this.checkpoint,
    required this.scorePercentage,
    required this.xpReward,
    required this.scoreColor,
    required this.isSmall,
  });

  @override
  State<QuizResultSuccessContent> createState() => _QuizResultSuccessContentState();
}

class _QuizResultSuccessContentState extends State<QuizResultSuccessContent> {
  String? _stampImageUrl;
  bool _isLoadingStamp = true;

  @override
  void initState() {
    super.initState();
    _loadStamp();
  }

  Future<void> _loadStamp() async {
    try {
      final stamps = await PassportRepository().getStamps(null);
      final stamp = stamps.firstWhere(
        (s) => s.id.toLowerCase() == widget.checkpoint.islandId.toLowerCase(),
        orElse: () => const SeaPassportStampModel(id: '', name: '', isUnlocked: false, order: 0),
      );
      if (mounted) {
        setState(() {
          _stampImageUrl = stamp.image;
          _isLoadingStamp = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingStamp = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final islandName = IslandData.islands.firstWhere(
      (i) => i.id.toLowerCase() == widget.checkpoint.islandId.toLowerCase(),
      orElse: () => IslandData.islands.first,
    ).name;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Selamat!',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: widget.scoreColor,
            fontSize: widget.isSmall ? 28 : 31,
            fontWeight: FontWeight.w900,
            height: 1,
            letterSpacing: 1.2,
          ),
        ),

        SizedBox(height: widget.isSmall ? 8 : 10),

        Text(
          'Kamu lulus kuis Pulau $islandName',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primary,
            fontSize: widget.isSmall ? 13.5 : 15,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: 0.7,
          ),
        ),

        SizedBox(height: widget.isSmall ? 12 : 14),

        const QuizResultScoreLabel(),

        SizedBox(height: widget.isSmall ? 12 : 14),

        Text(
          '${widget.scorePercentage}/100',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLarge.copyWith(
            color: widget.scoreColor,
            fontSize: widget.isSmall ? 32 : 40,
            fontWeight: FontWeight.w900,
            height: 1,
            letterSpacing: 1.2,
          ),
        ),

        SizedBox(height: widget.isSmall ? 18 : 20),

        const QuizResultStarRow(
          score: 3,
          totalCount: 3,
        ),

        SizedBox(height: widget.isSmall ? 10 : 12),

        QuizResultXpRewardLine(
          xpReward: widget.xpReward,
          isSmall: widget.isSmall,
        ),

        SizedBox(height: widget.isSmall ? 12 : 14),

        const QuizResultDashedDivider(),

        SizedBox(height: widget.isSmall ? 9 : 10),

        Text(
          'Stamp Pulau $islandName\nterbuka dan tersimpan\ndi Sea Passport!',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.primary,
            fontSize: widget.isSmall ? 12 : 13,
            fontWeight: FontWeight.w800,
            height: 1.25,
            letterSpacing: 0.6,
          ),
        ),

        SizedBox(height: widget.isSmall ? 10 : 12),

        if (_isLoadingStamp)
          SizedBox(
            width: widget.isSmall ? 100 : 110,
            height: widget.isSmall ? 100 : 110,
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          )
        else if (_stampImageUrl != null && _stampImageUrl!.startsWith('http'))
          Image.network(
            _stampImageUrl!,
            width: widget.isSmall ? 100 : 110,
            height: widget.isSmall ? 100 : 110,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported_outlined, size: widget.isSmall ? 100 : 110, color: Colors.grey),
          )
        else if (_stampImageUrl != null)
          Image.asset(
            _stampImageUrl!,
            width: widget.isSmall ? 100 : 110,
            height: widget.isSmall ? 100 : 110,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported_outlined, size: widget.isSmall ? 100 : 110, color: Colors.grey),
          )
        else
          Image.asset(
            AppImages.quizStampNtt,
            width: widget.isSmall ? 100 : 110,
            fit: BoxFit.contain,
          ),
      ],
    );
  }
}
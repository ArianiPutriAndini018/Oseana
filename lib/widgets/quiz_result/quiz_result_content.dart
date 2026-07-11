import 'package:flutter/material.dart';

import '../quiz/quiz_header.dart';
import 'quiz_result_card.dart';

class QuizResultContent extends StatelessWidget {
  final String title;
  final int score;
  final int totalCount;
  final int xpReward;
  final VoidCallback onPassportPressed;
  final VoidCallback onRetryPressed;
  final VoidCallback onBackToMapPressed;

  const QuizResultContent({
    super.key,
    required this.title,
    required this.score,
    required this.totalCount,
    this.xpReward = 15,
    required this.onPassportPressed,
    required this.onRetryPressed,
    required this.onBackToMapPressed,
  });

  bool get _isPerfectScore {
    return totalCount > 0 && score == totalCount;
  }

  String get _primaryButtonText {
    if (_isPerfectScore) return 'Lihat Sea Passport';
    return 'Coba Lagi';
  }

  VoidCallback get _primaryAction {
    if (_isPerfectScore) return onPassportPressed;
    return onRetryPressed;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          isSmall ? 18 : 20,
          isSmall ? 28 : 34,
          isSmall ? 18 : 20,
          135,
        ),
        child: Column(
          children: [
            const QuizHeader(),

            SizedBox(height: isSmall ? 46 : 52),

            QuizResultCard(
              title: title,
              score: score,
              totalCount: totalCount,
              xpReward: xpReward,
              isPerfectScore: _isPerfectScore,
              primaryButtonText: _primaryButtonText,
              onPrimaryPressed: _primaryAction,
              secondaryButtonText: 'Kembali ke Peta',
              onSecondaryPressed: onBackToMapPressed,
            ),
          ],
        ),
      ),
    );
  }
}
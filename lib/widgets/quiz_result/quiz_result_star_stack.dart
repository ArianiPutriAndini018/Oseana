import 'package:flutter/material.dart';

import 'quiz_result_animated_star.dart';

class QuizResultStarStack extends StatelessWidget {
  final bool isSmall;
  final double gap;
  final List<QuizResultStarData> stars;

  const QuizResultStarStack({
    super.key,
    required this.isSmall,
    required this.gap,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    final leftStar = stars[0];
    final centerStar = stars[1];
    final rightStar = stars[2];

    final rowWidth = leftStar.size + centerStar.size + rightStar.size + gap * 2;
    final rowHeight = centerStar.size + 18;

    const leftX = 0.0;
    final centerX = leftStar.size + gap;
    final rightX = centerX + centerStar.size + gap;

    return Transform.translate(
      offset: Offset(0, isSmall ? -4 : -6),
      child: SizedBox(
        width: rowWidth,
        height: rowHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _PositionedStar(
              left: leftX,
              top: _topOffset(leftStar.size, rowHeight, 0),
              star: leftStar,
            ),
            _PositionedStar(
              left: centerX,
              top: _topOffset(centerStar.size, rowHeight, 1),
              star: centerStar,
            ),
            _PositionedStar(
              left: rightX,
              top: _topOffset(rightStar.size, rowHeight, 2),
              star: rightStar,
            ),
          ],
        ),
      ),
    );
  }

  double _topOffset(
    double starSize,
    double rowHeight,
    int index,
  ) {
    final baseTop = (rowHeight - starSize) / 2;

    if (index == 1) {
      return baseTop - (isSmall ? 4 : 5);
    }

    return baseTop + (isSmall ? 3 : 4);
  }
}

class _PositionedStar extends StatelessWidget {
  final double left;
  final double top;
  final QuizResultStarData star;

  const _PositionedStar({
    required this.left,
    required this.top,
    required this.star,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: QuizResultAnimatedStar(
        asset: star.asset,
        size: star.size,
        yOffset: star.yOffset,
        fallAnimation: star.fallAnimation,
        scaleAnimation: star.scaleAnimation,
        fadeAnimation: star.fadeAnimation,
        settleWiggleAnimation: star.settleWiggleAnimation,
        idleWiggleAnimation: star.idleWiggleAnimation,
        idlePhase: star.idlePhase,
      ),
    );
  }
}

class QuizResultStarData {
  final String asset;
  final double size;
  final double yOffset;
  final Animation<double> fallAnimation;
  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;
  final Animation<double> settleWiggleAnimation;
  final Animation<double> idleWiggleAnimation;
  final double idlePhase;

  const QuizResultStarData({
    required this.asset,
    required this.size,
    required this.yOffset,
    required this.fallAnimation,
    required this.scaleAnimation,
    required this.fadeAnimation,
    required this.settleWiggleAnimation,
    required this.idleWiggleAnimation,
    required this.idlePhase,
  });
}
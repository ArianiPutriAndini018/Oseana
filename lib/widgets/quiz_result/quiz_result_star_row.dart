import 'package:flutter/material.dart';

import '../../core/constants/app_images.dart';
import 'quiz_result_star_stack.dart';

class QuizResultStarRow extends StatefulWidget {
  final int score;
  final int totalCount;

  const QuizResultStarRow({
    super.key,
    required this.score,
    required this.totalCount,
  });

  @override
  State<QuizResultStarRow> createState() => _QuizResultStarRowState();
}

class _QuizResultStarRowState extends State<QuizResultStarRow>
    with TickerProviderStateMixin {
  late final AnimationController _dropController;
  late final AnimationController _settleWiggleController;
  late final AnimationController _idleWiggleController;

  int get _earnedStarCount {
    if (widget.totalCount <= 0 || widget.score <= 0) return 0;

    final earnedStars = ((widget.score / widget.totalCount) * 3).ceil();
    return earnedStars.clamp(0, 3).toInt();
  }

  @override
  void initState() {
    super.initState();

    _dropController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
    );

    _settleWiggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 760),
    );

    _idleWiggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _dropController.addStatusListener(_handleDropStatus);
    _settleWiggleController.addStatusListener(_handleSettleStatus);

    _dropController.forward();
  }

  void _handleDropStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      _settleWiggleController.forward(from: 0);
    }
  }

  void _handleSettleStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      _idleWiggleController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant QuizResultStarRow oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.score != widget.score ||
        oldWidget.totalCount != widget.totalCount) {
      _restartAnimation();
    }
  }

  void _restartAnimation() {
    _idleWiggleController
      ..stop()
      ..reset();

    _settleWiggleController.reset();

    _dropController
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _dropController.removeStatusListener(_handleDropStatus);
    _settleWiggleController.removeStatusListener(_handleSettleStatus);

    _dropController.dispose();
    _settleWiggleController.dispose();
    _idleWiggleController.dispose();

    super.dispose();
  }

  String _starAsset(int index) {
    return index < _earnedStarCount
        ? AppImages.resultStarOn
        : AppImages.resultStarOff;
  }

  double _starSize(int index, bool isSmall) {
    return isSmall ? 84 : 92;
  }

  double _starYOffset(int index, bool isSmall) {
    if (index == 1) {
      return isSmall ? 0 : 2;
    }

    return isSmall ? 4 : 5;
  }

  double _starGap(bool isSmall) {
    return isSmall ? -20 : -24;
  }

  Animation<double> _dropAnimation(int index, Curve curve) {
    final begin = index * 0.16;
    final end = begin + 0.50;

    return CurvedAnimation(
      parent: _dropController,
      curve: Interval(
        begin,
        end > 1 ? 1.0 : end,
        curve: curve,
      ),
    );
  }

  Animation<double> _settleWiggleAnimation(int index) {
    final begin = index * 0.05;
    final end = begin + 0.82;

    return CurvedAnimation(
      parent: _settleWiggleController,
      curve: Interval(
        begin,
        end > 1 ? 1.0 : end,
        curve: Curves.easeOut,
      ),
    );
  }

  double _idlePhase(int index) {
    if (index == 0) return 0;
    if (index == 1) return 1.35;
    return 2.7;
  }

  QuizResultStarData _starData(int index, bool isSmall) {
    return QuizResultStarData(
      asset: _starAsset(index),
      size: _starSize(index, isSmall),
      yOffset: _starYOffset(index, isSmall),
      fallAnimation: _dropAnimation(index, Curves.easeOutBack),
      scaleAnimation: _dropAnimation(index, Curves.elasticOut),
      fadeAnimation: _dropAnimation(index, Curves.easeOut),
      settleWiggleAnimation: _settleWiggleAnimation(index),
      idleWiggleAnimation: _idleWiggleController,
      idlePhase: _idlePhase(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return QuizResultStarStack(
      isSmall: isSmall,
      gap: _starGap(isSmall),
      stars: [
        _starData(0, isSmall),
        _starData(1, isSmall),
        _starData(2, isSmall),
      ],
    );
  }
}
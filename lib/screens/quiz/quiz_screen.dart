import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/controllers/audio_controller.dart';
import '../../core/utils/app_snack_bar.dart';
import '../../core/utils/home_bottom_nav_action.dart';
import '../../data/checkpoint_data.dart';
import '../../data/quiz_data.dart';
import '../../data/repositories/quiz_repository.dart';
import '../../data/sea_passport_data.dart';
import '../../core/services/auth_service.dart';
import '../../models/island_checkpoint_model.dart';
import '../../models/quiz_question_model.dart';
import '../../widgets/backgrounds/animated_splash_background.dart';
import '../../widgets/navigation/floating_home_bottom_nav.dart';
import '../../widgets/quiz/quiz_content.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  final IslandCheckpointModel checkpoint;

  const QuizScreen({
    super.key,
    required this.checkpoint,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const int _bottomNavIndex = 1;

  late final List<QuizQuestionModel> _questions;

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;

  bool _showResult = false;
  bool _isFinishing = false;

  QuizQuestionModel get _currentQuestion {
    return _questions[_currentQuestionIndex];
  }

  bool get _isLastQuestion {
    return _currentQuestionIndex == _questions.length - 1;
  }

  bool get _canContinue {
    return _selectedAnswerIndex != null && _showResult;
  }

  String get _buttonText {
    if (_isLastQuestion) return 'Selesai';
    return 'Selanjutnya';
  }

  String get _quizTitle {
    return 'Kuis ${widget.checkpoint.title}';
  }

  bool get _isPerfectScore {
    return _score == _questions.length;
  }

  @override
  void initState() {
    super.initState();

    _questions = QuizData.findByIslandId(widget.checkpoint.islandId);

    unawaited(
      AudioController.instance.playQuizMusic(),
    );
  }

  void _onOptionSelected(int index) {
    if (_showResult || _isFinishing) return;

    final isCorrect = _currentQuestion.isCorrect(index);

    setState(() {
      _selectedAnswerIndex = index;
      _showResult = true;

      if (isCorrect) {
        _score++;
      }
    });
  }

  void _onNextPressed() {
    if (_isFinishing) return;

    if (!_canContinue) {
      AppSnackBar.show(
        context,
        'Pilih jawaban terlebih dahulu',
        backgroundColor: AppColors.warning,
      );
      return;
    }

    if (_isLastQuestion) {
      _finishQuiz();
      return;
    }

    _goToNextQuestion();
  }

  void _goToNextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswerIndex = null;
      _showResult = false;
    });
  }

  Future<void> _finishQuiz() async {
    if (_isFinishing) return;

    setState(() {
      _isFinishing = true;
    });

    if (_isPerfectScore) {
      unawaited(
        AudioController.instance.playPerfectStarSound(),
      );
    } else {
      unawaited(
        AudioController.instance.playNormalStarSound(),
      );
    }

    // Update local UI states
    CheckpointData.updateProgress(widget.checkpoint.islandId, 1.0);
    SeaPassportData.unlockStamp(widget.checkpoint.islandId);

    // Save result to database
    final user = AuthService().currentUser;
    if (user != null) {
      final totalCount = _questions.length;
      final scorePercentage = totalCount > 0 ? (_score / totalCount * 100).toInt() : 0;
      
      int stars = 0;
      if (_score == totalCount) {
        stars = 3;
      } else if (_score >= (totalCount / 2)) {
        stars = 2;
      } else if (_score > 0) {
        stars = 1;
      }

      try {
        await QuizRepository().saveQuizResult(
          userId: user.id,
          islandId: widget.checkpoint.islandId,
          score: scorePercentage,
          correctAnswers: _score,
          stars: stars,
          xpEarned: 15,
        );
      } catch (e) {
        if (!mounted) return;
        AppSnackBar.show(
          context,
          'Error DB: ${e.toString().replaceAll('Exception: ', '')}',
          backgroundColor: AppColors.error,
        );
        setState(() {
          _isFinishing = false;
        });
        return; // Hentikan navigasi ke result screen jika gagal simpan
      }
    }

    final updatedCheckpoint = CheckpointData.getCheckpointByIslandId(widget.checkpoint.islandId);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => QuizResultScreen(
          checkpoint: updatedCheckpoint,
          score: _score,
          totalCount: _questions.length,
        ),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (_isFinishing) return;

    HomeBottomNavAction.handle(
      context: context,
      index: index,
      currentIndex: _bottomNavIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      extendBody: true,
      body: Stack(
        children: [
          const AnimatedSplashBackground(),
          if (_questions.isEmpty)
            const _QuizEmptyState()
          else
            QuizContent(
              title: _quizTitle,
              question: _currentQuestion,
              currentIndex: _currentQuestionIndex,
              totalCount: _questions.length,
              selectedAnswerIndex: _selectedAnswerIndex,
              showResult: _showResult,
              canContinue: _canContinue,
              buttonText: _buttonText,
              onOptionSelected: _onOptionSelected,
              onNextPressed: _onNextPressed,
            ),
          FloatingHomeBottomNav(
            currentIndex: _bottomNavIndex,
            onTap: _onBottomNavTap,
          ),
        ],
      ),
    );
  }
}

class _QuizEmptyState extends StatelessWidget {
  const _QuizEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Text(
          'Quiz belum tersedia',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

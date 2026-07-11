import 'package:flutter/material.dart';

import '../../models/quiz_question_model.dart';
import 'quiz_card.dart';
import 'quiz_header.dart';

class QuizContent extends StatelessWidget {
  final String title;
  final QuizQuestionModel question;
  final int currentIndex;
  final int totalCount;
  final int? selectedAnswerIndex;
  final bool showResult;
  final bool canContinue;
  final String buttonText;
  final ValueChanged<int> onOptionSelected;
  final VoidCallback? onNextPressed;

  const QuizContent({
    super.key,
    required this.title,
    required this.question,
    required this.currentIndex,
    required this.totalCount,
    required this.selectedAnswerIndex,
    required this.showResult,
    required this.canContinue,
    required this.buttonText,
    required this.onOptionSelected,
    required this.onNextPressed,
  });

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

            SizedBox(height: isSmall ? 45 : 50),

            QuizCard(
              title: title,
              question: question,
              currentIndex: currentIndex,
              totalCount: totalCount,
              selectedAnswerIndex: selectedAnswerIndex,
              showResult: showResult,
              canContinue: canContinue,
              buttonText: buttonText,
              onOptionSelected: onOptionSelected,
              onNextPressed: onNextPressed,
            ),
          ],
        ),
      ),
    );
  }
}
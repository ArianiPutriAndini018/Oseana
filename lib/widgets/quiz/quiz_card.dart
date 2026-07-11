import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/quiz_question_model.dart';
import '../buttons/primary_button.dart';
import 'quiz_option_tile.dart';
import 'quiz_progress_divider.dart';
import 'quiz_title_badge.dart';

class QuizCard extends StatelessWidget {
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

  const QuizCard({
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

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: isSmall ? 500 : 515,
          ),
          padding: EdgeInsets.fromLTRB(
            isSmall ? 14 : 16,
            isSmall ? 31 : 34,
            isSmall ? 14 : 16,
            isSmall ? 26 : 30,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppRadius.radiusXXL,
            border: Border.all(
              color: AppColors.primary,
              width: 1.8,
            ),
            boxShadow: AppShadows.medium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pertanyaan ${currentIndex + 1} dari $totalCount Soal',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontSize: isSmall ? 14.5 : 16,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),

              SizedBox(height: isSmall ? 14 : 15),

              Text(
                question.question,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontSize: isSmall ? 13 : 14,
                  fontWeight: FontWeight.w800,
                  height: 1.35,
                ),
              ),

              SizedBox(height: isSmall ? 14 : 16),

              ...List.generate(
                question.options.length,
                (index) {
                  final isSelected = selectedAnswerIndex == index;
                  final isCorrect = question.isCorrect(index);

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == question.options.length - 1 ? 0 : 12,
                    ),
                    child: QuizOptionTile(
                      letter: question.optionLetter(index),
                      text: question.options[index],
                      isSelected: isSelected,
                      isCorrect: isCorrect,
                      showResult: showResult,
                      onTap: showResult ? null : () => onOptionSelected(index),
                    ),
                  );
                },
              ),

              SizedBox(height: isSmall ? 26 : 30),

              QuizProgressDivider(
                currentIndex: currentIndex,
                totalCount: totalCount,
              ),

              SizedBox(height: isSmall ? 50 : 56),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 28 : 32,
                ),
                child: PrimaryButton(
                  text: buttonText,
                  onPressed: canContinue ? onNextPressed : null,
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: isSmall ? -27 : -29,
          child: QuizTitleBadge(title: title),
        ),
      ],
    );
  }
}
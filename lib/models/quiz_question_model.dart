class QuizQuestionModel {
  final String id;
  final String islandId;
  final String? biotaId;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final int order;

  const QuizQuestionModel({
    required this.id,
    required this.islandId,
    this.biotaId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    this.explanation = '',
    required this.order,
  });

  bool get hasOptions {
    return options.isNotEmpty;
  }

  bool get hasValidCorrectAnswer {
    return correctAnswerIndex >= 0 && correctAnswerIndex < options.length;
  }

  int get totalOptions {
    return options.length;
  }

  String get correctAnswer {
    if (!hasValidCorrectAnswer) return '';
    return options[correctAnswerIndex];
  }

  bool isCorrect(int selectedIndex) {
    return hasValidCorrectAnswer && selectedIndex == correctAnswerIndex;
  }

  bool isWrong(int selectedIndex) {
    return hasValidCorrectAnswer && selectedIndex != correctAnswerIndex;
  }

  String optionLetter(int index) {
    const letters = ['A', 'B', 'C', 'D'];

    if (index < 0 || index >= letters.length) {
      return '';
    }

    return letters[index];
  }

  QuizQuestionModel copyWith({
    String? id,
    String? islandId,
    String? biotaId,
    String? question,
    List<String>? options,
    int? correctAnswerIndex,
    String? explanation,
    int? order,
  }) {
    return QuizQuestionModel(
      id: id ?? this.id,
      islandId: islandId ?? this.islandId,
      biotaId: biotaId ?? this.biotaId,
      question: question ?? this.question,
      options: options ?? this.options,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      explanation: explanation ?? this.explanation,
      order: order ?? this.order,
    );
  }

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      id: json['id']?.toString() ?? '',
      islandId:
          json['islandId']?.toString() ?? json['island_id']?.toString() ?? '',
      biotaId: json['biotaId']?.toString() ?? json['biota_id']?.toString(),
      question: json['question']?.toString() ?? '',
      options: (json['options'] as List<dynamic>? ?? [])
          .map((option) => option.toString())
          .toList(),
      correctAnswerIndex: int.tryParse(
            json['correctAnswerIndex']?.toString() ??
                json['correct_answer_index']?.toString() ??
                '',
          ) ??
          0,
      explanation: json['explanation']?.toString() ?? '',
      order: int.tryParse(json['order']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'islandId': islandId,
      'biotaId': biotaId,
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
      'order': order,
    };
  }
}

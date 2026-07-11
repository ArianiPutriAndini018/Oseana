import '../models/quiz_question_model.dart';

class QuizData {
  QuizData._();

  static const List<QuizQuestionModel> nttQuestions = [
    QuizQuestionModel(
      id: 'ntt_q1',
      islandId: 'ntt',
      biotaId: 'komodo_damselfish',
      order: 1,
      question:
          'Mengapa Komodo Damselfish penting bagi ekosistem terumbu karang?',
      options: [
        'Menjadi predator utama hiu',
        'Mengendalikan pertumbuhan alga di terumbu karang',
        'Menghasilkan pasir putih di pantai',
        'Membersihkan sampah plastik di laut',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Komodo Damselfish membantu menjaga keseimbangan alga di sekitar terumbu karang.',
    ),
    QuizQuestionModel(
      id: 'ntt_q2',
      islandId: 'ntt',
      biotaId: 'pari_manta',
      order: 2,
      question: 'Apa kebiasaan makan Pari Manta yang membantu ekosistem laut?',
      options: [
        'Memakan plankton kecil di perairan',
        'Memakan karang keras',
        'Memakan telur penyu',
        'Memakan lamun hingga habis',
      ],
      correctAnswerIndex: 0,
      explanation:
          'Pari Manta merupakan pemakan plankton dan berperan dalam rantai makanan laut.',
    ),
    QuizQuestionModel(
      id: 'ntt_q3',
      islandId: 'ntt',
      biotaId: 'penyu_hijau',
      order: 3,
      question: 'Mengapa Penyu Hijau penting bagi padang lamun?',
      options: [
        'Membuat air laut menjadi asin',
        'Menjaga lamun tetap tumbuh sehat',
        'Mengubah karang menjadi pasir',
        'Menjadi predator utama lumba-lumba',
      ],
      correctAnswerIndex: 1,
      explanation:
          'Penyu Hijau membantu menjaga padang lamun tetap sehat melalui aktivitas makannya.',
    ),
  ];

  static const List<QuizQuestionModel> questions = [
    ...nttQuestions,
  ];

  static List<QuizQuestionModel> findByIslandId(String islandId) {
    final normalizedIslandId = islandId.trim().toLowerCase();

    final result = questions
        .where(
          (question) =>
              question.islandId.trim().toLowerCase() == normalizedIslandId,
        )
        .toList();

    result.sort(
      (a, b) => a.order.compareTo(b.order),
    );

    return result;
  }

  static QuizQuestionModel? findById(String id) {
    final normalizedId = id.trim().toLowerCase();

    for (final question in questions) {
      if (question.id.trim().toLowerCase() == normalizedId) {
        return question;
      }
    }

    return null;
  }
}

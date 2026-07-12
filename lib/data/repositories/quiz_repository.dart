import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/quiz_question_model.dart';

class QuizRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<QuizQuestionModel>> getQuestionsByIslandId(String islandId) async {
    try {
      final questionsData = await _client
          .from('quiz_questions')
          .select()
          .eq('island_id', islandId)
          .order('order_index', ascending: true);

      final List<QuizQuestionModel> questions = [];

      for (final questionJson in questionsData) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(questionJson);
        // Map order_index to order so QuizQuestionModel.fromJson can read it if it only looks for 'order'
        if (json.containsKey('order_index') && !json.containsKey('order')) {
          json['order'] = json['order_index'];
        }
        questions.add(QuizQuestionModel.fromJson(json));
      }

      return questions;
    } catch (e) {
      throw Exception('Gagal mengambil pertanyaan kuis untuk island $islandId: $e');
    }
  }
}

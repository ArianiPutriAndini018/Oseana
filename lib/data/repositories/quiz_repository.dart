import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/quiz_question_model.dart';
import 'profile_repository.dart';

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

  Future<bool> saveQuizResult({
    required String userId,
    required String islandId,
    required int score,
    required int correctAnswers,
    required int stars,
    required int xpEarned,
  }) async {
    try {
      await _client.from('user_quiz_results').insert({
        'user_id': userId,
        'island_id': islandId,
        'score': score,
        'correct_answers': correctAnswers,
        'stars': stars,
        'xp_earned': xpEarned,
        'completed_at': DateTime.now().toUtc().toIso8601String(),
      });

      if (correctAnswers >= 2) {
        try {
          await _client.from('user_stamps').insert({
            'user_id': userId,
            'island_id': islandId,
          });
        } catch (e) {
          if (!e.toString().contains('23505')) {
            rethrow; // Only ignore duplicate key errors
          }
        }
      }

      // Reuse existing ProfileRepository.addXp()
      await ProfileRepository().addXp(userId, xpEarned);

      return true;
    } catch (e) {
      print('Error saving quiz result: $e');
      throw Exception(e.toString());
    }
  }

  Future<Map<String, int>> getUserStars(String userId) async {
    try {
      final results = await _client
          .from('user_quiz_results')
          .select('island_id, stars')
          .eq('user_id', userId);
      
      final Map<String, int> map = {};
      for (final r in results) {
        map[r['island_id'].toString()] = r['stars'] as int;
      }
      return map;
    } catch (e) {
      return {};
    }
  }
}

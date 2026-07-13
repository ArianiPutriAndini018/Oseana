import 'package:supabase_flutter/supabase_flutter.dart';

class BiotaRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> markBiotaAsLearned(String userId, String biotaId) async {
    try {
      await _client.from('user_biota_progress').upsert(
        {
          'user_id': userId,
          'biota_id': biotaId,
          'learned_at': DateTime.now().toUtc().toIso8601String(),
        },
        onConflict: 'user_id, biota_id',
        ignoreDuplicates: true,
      );
    } catch (e) {
      // Ignore errors for now, as requested to gracefully handle if exists
    }
  }

  Future<int> getLearnedBiotasCount(String userId) async {
    try {
      final res = await _client
          .from('user_biota_progress')
          .select('biota_id')
          .eq('user_id', userId)
          .count(CountOption.exact);
      
      return res.count ?? 0;
    } catch (e) {
      return 0;
    }
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/sea_passport_reward_model.dart';
import '../../models/sea_passport_stamp_model.dart';

class PassportRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<SeaPassportStampModel>> getStamps(String? userId) async {
    try {
      final data = await _client
          .from('sea_passport_stamps')
          .select()
          .order('order_index', ascending: true);

      final unlockedIslandIds = <String>{};
      if (userId != null) {
        final userStamps = await _client
            .from('user_stamps')
            .select('island_id')
            .eq('user_id', userId);

        unlockedIslandIds.addAll(
          userStamps.map((e) => e['island_id']?.toString() ?? ''),
        );
      }

      return data.map((json) {
        final id = json['island_id']?.toString() ?? json['id']?.toString() ?? '';
        final isUnlocked = unlockedIslandIds.contains(id);
        
        final updatedJson = Map<String, dynamic>.from(json);
        updatedJson['is_unlocked'] = isUnlocked;

        return SeaPassportStampModel.fromJson(updatedJson);
      }).toList();
    } catch (e) {
      throw Exception('Gagal mengambil data stamps: $e');
    }
  }

  Future<List<SeaPassportRewardModel>> getRewards(String? userId) async {
    try {
      final data = await _client
          .from('sea_passport_rewards')
          .select()
          .order('order_index', ascending: true);

      final unlockedSlugs = <String>{};
      if (userId != null) {
        final userRewards = await _client
            .from('user_rewards')
            .select('reward_slug')
            .eq('user_id', userId);

        unlockedSlugs.addAll(
          userRewards.map((e) => e['reward_slug']?.toString() ?? ''),
        );
      }

      return data.map((json) {
        final slug = json['slug']?.toString() ?? json['id']?.toString() ?? '';
        final isUnlocked = unlockedSlugs.contains(slug);

        final updatedJson = Map<String, dynamic>.from(json);
        updatedJson['is_unlocked'] = isUnlocked;

        return SeaPassportRewardModel.fromJson(updatedJson);
      }).toList();
    } catch (e) {
      throw Exception('Gagal mengambil data rewards: $e');
    }
  }
}

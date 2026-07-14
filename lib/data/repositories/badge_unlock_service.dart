import 'package:supabase_flutter/supabase_flutter.dart';

class BadgeUnlockService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Mengecek semua kriteria badge dan meng-unlock yang memenuhi syarat.
  /// Mengembalikan daftar nama (title) badge yang baru saja terbuka.
  Future<List<Map<String, String>>> checkAndUnlockBadges(String userId) async {
    final newUnlockedBadges = <Map<String, String>>[];

    try {
      print('[Badge] Starting check for $userId');
      final rewardsResponse = await _client
          .from('sea_passport_rewards')
          .select()
          .not('unlock_type', 'is', null);

      if (rewardsResponse.isEmpty) return [];

      final userRewardsResponse = await _client
          .from('user_rewards')
          .select('reward_slug')
          .eq('user_id', userId);
      
      final unlockedSlugs = userRewardsResponse
          .map((row) => row['reward_slug']?.toString() ?? '')
          .toSet();

      print('[Badge] Unlocked: $unlockedSlugs');

      if (unlockedSlugs.length >= rewardsResponse.length) return [];

      final userStampsResponse = await _client
          .from('user_stamps')
          .select('island_id')
          .eq('user_id', userId);
      final islandsCompletedCount = userStampsResponse
          .map((row) => row['island_id'].toString())
          .toSet()
          .length;

      final userQuizResponse = await _client
          .from('user_quiz_results')
          .select('island_id, stars')
          .eq('user_id', userId);
      
      final quizPassedOnce = userQuizResponse.isNotEmpty;
      int starsTotal = 0;
      int quizPerfectAllCount = 0;
      bool quizPerfectOnce = false;

      for (var row in userQuizResponse) {
        int stars = int.tryParse(row['stars']?.toString() ?? '0') ?? 0;
        starsTotal += stars;
        if (stars == 3) {
          quizPerfectOnce = true;
          quizPerfectAllCount++; // Note: should technically count distinct islands, but since quiz results are overwritten per island, it's fine.
        }
      }

      print('[Badge] Quizzes: $quizPassedOnce, Total Stars: $starsTotal');

      final userMissionsResponse = await _client
          .from('user_missions')
          .select('mission_id')
          .eq('user_id', userId);
      final missionCount = userMissionsResponse.length;
      
      final needsMissionCategory = rewardsResponse.any((r) => r['unlock_type'] == 'mission_category');
      
      Map<String, int> missionCategoryCounts = {};
      if (needsMissionCategory && missionCount > 0) {
        final missionIds = userMissionsResponse.map((r) => r['mission_id']).toList();
        final missionsJoinResponse = await _client
            .from('missions')
            .select('category')
            .inFilter('id', missionIds);
        
        for (final row in missionsJoinResponse) {
          final category = row['category']?.toString() ?? '';
          missionCategoryCounts[category] = (missionCategoryCounts[category] ?? 0) + 1;
        }
      }

      for (final reward in rewardsResponse) {
        final slug = reward['slug']?.toString() ?? '';
        final title = reward['title']?.toString() ?? '';
        final image = reward['image']?.toString() ?? '';
        
        if (unlockedSlugs.contains(slug)) continue;

        final unlockType = reward['unlock_type']?.toString() ?? '';
        final threshold = int.tryParse(reward['unlock_threshold']?.toString() ?? '0') ?? 0;
        final threshold2 = int.tryParse(reward['unlock_threshold_2']?.toString() ?? '0') ?? 0;
        final category = reward['unlock_category']?.toString() ?? '';

        bool isMet = false;

        switch (unlockType) {
          case 'islands_completed':
          case 'stamps_collected':
            isMet = islandsCompletedCount >= threshold;
            break;
          case 'quiz_passed_once':
            isMet = quizPassedOnce;
            break;
          case 'quiz_perfect_once':
            isMet = quizPerfectOnce;
            break;
          case 'stars_total':
            isMet = starsTotal >= threshold;
            break;
          case 'quiz_perfect_all':
            isMet = quizPerfectAllCount >= threshold;
            break;
          case 'mission_count':
            isMet = missionCount >= threshold;
            break;
          case 'mission_category':
            isMet = (missionCategoryCounts[category] ?? 0) >= threshold;
            break;
          case 'islands_and_missions':
            isMet = (islandsCompletedCount >= threshold) && (missionCount >= threshold2);
            break;
        }

        print('[Badge] Checking $slug: type=$unlockType, met=$isMet');

        if (isMet) {
          try {
            await _client.from('user_rewards').upsert({
              'user_id': userId,
              'reward_slug': slug,
            });
            newUnlockedBadges.add({
              'title': title,
              'image': image,
            });
            print('[Badge] Unlocked $slug successfully');
          } catch (e) {
            print('[Badge] Upsert failed for $slug: $e');
            throw Exception('Gagal menyimpan badge $slug: $e');
          }
        }
      }
    } catch (e) {
      print('ERROR IN BADGE UNLOCK SERVICE: $e');
      throw Exception('Gagal memproses badge: $e');
    }

    return newUnlockedBadges;
  }
}

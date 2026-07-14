import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user_profile_model.dart';

class ProfileRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<UserProfileModel?> getProfile(String userId) async {
    try {
      final data = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (data == null) return null;

      return UserProfileModel.fromJson(data);
    } catch (e) {
      throw Exception('Gagal mengambil profil: $e');
    }
  }

  Future<UserProfileModel?> addXp(String userId, int xpToAdd) async {
    try {
      final currentProfileData = await _client
          .from('profiles')
          .select('xp, level_number, max_xp, title')
          .eq('id', userId)
          .maybeSingle();
      
      if (currentProfileData == null) {
        await _client.from('profiles').insert({
          'id': userId,
          'xp': xpToAdd,
        });
        return await getProfile(userId);
      }
      
      int currentXp = currentProfileData['xp'] is int 
          ? currentProfileData['xp'] as int 
          : int.tryParse(currentProfileData['xp']?.toString() ?? '0') ?? 0;
          
      int levelNumber = currentProfileData['level_number'] is int
          ? currentProfileData['level_number'] as int
          : int.tryParse(currentProfileData['level_number']?.toString() ?? '1') ?? 1;
          
      int maxXp = currentProfileData['max_xp'] is int
          ? currentProfileData['max_xp'] as int
          : int.tryParse(currentProfileData['max_xp']?.toString() ?? '150') ?? 150;
          
      String title = currentProfileData['title']?.toString() ?? 'Pemula';

      int newXp = currentXp + xpToAdd;
      
      // Level Up Logic
      while (newXp >= maxXp) {
        newXp -= maxXp;
        levelNumber++;
        maxXp += 50; // Increase max XP requirement for next level
        
        // Update Title based on level
        if (levelNumber >= 20) {
            title = 'Legenda Samudra';
        } else if (levelNumber >= 15) {
            title = 'Penguasa Lautan';
        } else if (levelNumber >= 10) {
            title = 'Penjelajah Ahli';
        } else if (levelNumber >= 5) {
            title = 'Penjelajah Aktif';
        }
      }

      final data = await _client
          .from('profiles')
          .update({
            'xp': newXp,
            'level_number': levelNumber,
            'max_xp': maxXp,
            'title': title
          })
          .eq('id', userId)
          .select()
          .maybeSingle();

      if (data == null) {
        throw Exception('Gagal update XP: Policy UPDATE/SELECT mungkin belum benar.');
      }

      return UserProfileModel.fromJson(data);
    } catch (e) {
      throw Exception('Gagal menambahkan XP: $e');
    }
  }
}

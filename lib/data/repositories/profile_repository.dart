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
      // Get current profile first to calculate new XP
      final currentProfileData = await _client
          .from('profiles')
          .select('xp')
          .eq('id', userId)
          .maybeSingle();
      
      if (currentProfileData == null) {
        // Create profile if missing
        await _client.from('profiles').insert({
          'id': userId,
          'xp': xpToAdd,
        });
        return await getProfile(userId);
      }
      
      int currentXp = currentProfileData['xp'] is int 
          ? currentProfileData['xp'] as int 
          : int.tryParse(currentProfileData['xp'].toString()) ?? 0;
          
      final data = await _client
          .from('profiles')
          .update({'xp': currentXp + xpToAdd})
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

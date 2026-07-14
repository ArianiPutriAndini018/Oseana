import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/mission_model.dart';
import 'profile_repository.dart';

class MissionRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<MissionModel>> getAllMissions() async {
    try {
      final missionsData = await _client
          .from('missions')
          .select()
          .order('order_index', ascending: true);

      final List<MissionModel> missions = [];

      for (final missionJson in missionsData) {
        missions.add(MissionModel.fromJson(missionJson));
      }

      return missions;
    } catch (e) {
      throw Exception('Gagal mengambil data misi: $e');
    }
  }

  Future<Set<String>> getCompletedMissionIds(String userId) async {
    try {
      final completedData = await _client
          .from('user_missions')
          .select('mission_id')
          .eq('user_id', userId);

      final Set<String> completedIds = {};
      for (final json in completedData) {
        final id = json['mission_id']?.toString();
        if (id != null) {
          completedIds.add(id);
        }
      }

      return completedIds;
    } catch (e) {
      print('Error fetching completed missions: $e');
      return {};
    }
  }

  Future<void> completeMission(String userId, String missionId) async {
    try {
      await _client.from('user_missions').insert({
        'user_id': userId,
        'mission_id': missionId,
        'completed_at': DateTime.now().toUtc().toIso8601String(),
      });

      // Berhasil insert, tambahkan XP
      await ProfileRepository().addXp(userId, 5);
    } catch (e) {
      // Jika error karena duplicate key (23505), abaikan (anggap sukses)
      if (e.toString().contains('23505')) {
        print('Mission already completed, ignoring duplicate key error.');
        return;
      }
      throw Exception('Gagal menyimpan status misi: $e');
    }
  }
}

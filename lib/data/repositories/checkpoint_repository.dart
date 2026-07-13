import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/island_checkpoint_model.dart';

class CheckpointRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<IslandCheckpointModel>> getAllCheckpoints() async {
    try {
      final checkpointsData = await _client.from('island_checkpoints').select();
      final biotasData = await _client.from('biotas').select().order('order_index', ascending: true);

      final List<IslandCheckpointModel> checkpoints = [];
      
      final user = _client.auth.currentUser;
      Set<String> learnedBiotaIds = {};
      if (user != null) {
        final progressData = await _client
            .from('user_biota_progress')
            .select('biota_id')
            .eq('user_id', user.id);
        learnedBiotaIds = progressData.map((e) => e['biota_id'].toString()).toSet();
      }

      for (final checkpointJson in checkpointsData) {
        final islandId = checkpointJson['island_id']?.toString() ?? '';
        final relatedBiotas = biotasData.where((b) => b['island_id']?.toString() == islandId).map((b) {
          final updatedBiota = Map<String, dynamic>.from(b);
          updatedBiota['is_learned'] = learnedBiotaIds.contains(b['id'].toString());
          return updatedBiota;
        }).toList();

        final Map<String, dynamic> combinedJson = Map<String, dynamic>.from(checkpointJson);
        combinedJson['biotas'] = relatedBiotas;

        checkpoints.add(IslandCheckpointModel.fromJson(combinedJson));
      }

      return checkpoints;
    } catch (e) {
      throw Exception('Gagal mengambil semua checkpoint: $e');
    }
  }

  Future<IslandCheckpointModel?> getCheckpointByIslandId(String islandId) async {
    try {
      final checkpointData = await _client
          .from('island_checkpoints')
          .select()
          .eq('island_id', islandId)
          .maybeSingle();

      if (checkpointData == null) {
        return null;
      }

      final biotasData = await _client
          .from('biotas')
          .select()
          .eq('island_id', islandId)
          .order('order_index', ascending: true);

      final user = _client.auth.currentUser;
      Set<String> learnedBiotaIds = {};
      if (user != null) {
        final progressData = await _client
            .from('user_biota_progress')
            .select('biota_id')
            .eq('user_id', user.id);
        learnedBiotaIds = progressData.map((e) => e['biota_id'].toString()).toSet();
      }

      final relatedBiotas = biotasData.map((b) {
        final updatedBiota = Map<String, dynamic>.from(b);
        updatedBiota['is_learned'] = learnedBiotaIds.contains(b['id'].toString());
        return updatedBiota;
      }).toList();

      final Map<String, dynamic> combinedJson = Map<String, dynamic>.from(checkpointData);
      combinedJson['biotas'] = relatedBiotas;

      return IslandCheckpointModel.fromJson(combinedJson);
    } catch (e) {
      throw Exception('Gagal mengambil checkpoint untuk island $islandId: $e');
    }
  }
}

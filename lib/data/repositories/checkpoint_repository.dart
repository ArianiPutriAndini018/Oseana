import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/island_checkpoint_model.dart';

class CheckpointRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<IslandCheckpointModel>> getAllCheckpoints() async {
    try {
      final checkpointsData = await _client.from('island_checkpoints').select();
      final biotasData = await _client.from('biotas').select().order('order_index', ascending: true);

      final List<IslandCheckpointModel> checkpoints = [];

      for (final checkpointJson in checkpointsData) {
        final islandId = checkpointJson['island_id']?.toString() ?? '';
        final relatedBiotas = biotasData.where((b) => b['island_id']?.toString() == islandId).toList();

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

      final Map<String, dynamic> combinedJson = Map<String, dynamic>.from(checkpointData);
      combinedJson['biotas'] = biotasData;

      return IslandCheckpointModel.fromJson(combinedJson);
    } catch (e) {
      throw Exception('Gagal mengambil checkpoint untuk island $islandId: $e');
    }
  }
}

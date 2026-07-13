import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/island_checkpoint_model.dart';
import '../checkpoint_data.dart';

class CheckpointRepository {
  final SupabaseClient _client = Supabase.instance.client;

  static List<IslandCheckpointModel> _cachedCheckpoints = [];

  static List<IslandCheckpointModel> get cachedCheckpoints => _cachedCheckpoints;

  Future<void> loadAllCheckpoints() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      
      final checkpointsResponse = await _client.from('island_checkpoints').select();
      final biotasResponse = await _client.from('biotas').select();
      
      Set<String> learnedBiotaIds = {};
      if (userId != null) {
        try {
          final progressResponse = await _client
              .from('user_biota_progress')
              .select('biota_id')
              .eq('user_id', userId);
          for (final row in progressResponse) {
            learnedBiotaIds.add(row['biota_id'].toString());
          }
        } catch (e) {
          print('Error loading user_biota_progress: $e');
        }
      }

      final List<IslandCheckpointModel> loaded = [];

      for (final json in checkpointsResponse) {
        final islandId = json['island_id']?.toString().toLowerCase() ?? '';
        
        // Filter and sort biotas for this island
        final islandBiotas = biotasResponse
            .where((b) => b['island_id']?.toString().toLowerCase() == islandId)
            .map((b) {
              final biotaMap = Map<String, dynamic>.from(b);
              final biotaId = biotaMap['id']?.toString() ?? '';
              biotaMap['is_learned'] = learnedBiotaIds.contains(biotaId);
              biotaMap['order'] = biotaMap['order_index'] ?? 0;
              return biotaMap;
            })
            .toList();

        islandBiotas.sort((a, b) => 
            ((a['order_index'] as int?) ?? 0).compareTo((b['order_index'] as int?) ?? 0)
        );

        final updatedJson = Map<String, dynamic>.from(json);
        updatedJson['biotas'] = islandBiotas;

        loaded.add(IslandCheckpointModel.fromJson(updatedJson));
      }

      _cachedCheckpoints = loaded;
    } catch (e) {
      print('Error loading island_checkpoints: $e');
    }
  }
}

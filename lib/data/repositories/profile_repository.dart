import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user_profile_model.dart';

class ProfileRepository {
  final SupabaseClient _client = Supabase.instance.client;

  static const int maximumXp = 180;

  Future<UserProfileModel?> getProfile(
    String userId,
  ) async {
    try {
      final data = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (data == null) {
        return null;
      }

      final originalData = Map<String, dynamic>.from(
        data,
      );

      final currentXp = _asInt(
        originalData['xp'],
        defaultValue: 0,
      );

      final normalizedXp = normalizeXp(
        currentXp,
      );

      final correctLevel = calculateLevelNumber(
        normalizedXp,
      );

      final correctTitle = calculateLevelTitle(
        normalizedXp,
      );

      final currentLevel = _asInt(
        originalData['level_number'],
        defaultValue: 1,
      );

      final currentMaxXp = _asInt(
        originalData['max_xp'],
        defaultValue: maximumXp,
      );

      final currentTitle =
          originalData['title']?.toString() ?? '';

      final normalizedData =
          Map<String, dynamic>.from(
        originalData,
      );

      normalizedData['xp'] = normalizedXp;
      normalizedData['max_xp'] = maximumXp;
      normalizedData['level_number'] = correctLevel;
      normalizedData['title'] = correctTitle;

      final needsUpdate =
          currentXp != normalizedXp ||
          currentLevel != correctLevel ||
          currentMaxXp != maximumXp ||
          currentTitle != correctTitle;

      if (needsUpdate) {
        try {
          await _client
              .from('profiles')
              .update({
                'xp': normalizedXp,
                'max_xp': maximumXp,
                'level_number': correctLevel,
                'title': correctTitle,
              })
              .eq('id', userId);
        } catch (e) {
          debugPrint(
            'Profil sudah dihitung dengan benar secara lokal, '
            'tetapi gagal disinkronkan ke Supabase: $e',
          );
        }
      }

      return UserProfileModel.fromJson(
        normalizedData,
      );
    } catch (e) {
      throw Exception(
        'Gagal mengambil profil: $e',
      );
    }
  }

  Future<UserProfileModel?> addXp(
    String userId,
    int xpToAdd,
  ) async {
    try {
      final currentProfileData = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      final safeXpToAdd = xpToAdd < 0
          ? 0
          : xpToAdd;

      if (currentProfileData == null) {
        final newXp = normalizeXp(
          safeXpToAdd,
        );

        final levelNumber = calculateLevelNumber(
          newXp,
        );

        final title = calculateLevelTitle(
          newXp,
        );

        final insertedData = await _client
            .from('profiles')
            .insert({
              'id': userId,
              'xp': newXp,
              'level_number': levelNumber,
              'max_xp': maximumXp,
              'title': title,
            })
            .select()
            .maybeSingle();

        if (insertedData == null) {
          throw Exception(
            'Profil gagal dibuat. '
            'Periksa policy INSERT dan SELECT tabel profiles.',
          );
        }

        return UserProfileModel.fromJson(
          Map<String, dynamic>.from(
            insertedData,
          ),
        );
      }

      final currentXp = _asInt(
        currentProfileData['xp'],
        defaultValue: 0,
      );

      final newXp = normalizeXp(
        currentXp + safeXpToAdd,
      );

      final levelNumber = calculateLevelNumber(
        newXp,
      );

      final title = calculateLevelTitle(
        newXp,
      );

      final updatedData = await _client
          .from('profiles')
          .update({
            'xp': newXp,
            'level_number': levelNumber,
            'max_xp': maximumXp,
            'title': title,
          })
          .eq('id', userId)
          .select()
          .maybeSingle();

      if (updatedData == null) {
        throw Exception(
          'Profil gagal diperbarui. '
          'Periksa policy UPDATE dan SELECT tabel profiles.',
        );
      }

      return UserProfileModel.fromJson(
        Map<String, dynamic>.from(
          updatedData,
        ),
      );
    } catch (e) {
      throw Exception(
        'Gagal menambahkan XP: $e',
      );
    }
  }

  static int normalizeXp(
    int xp,
  ) {
    return xp.clamp(
      0,
      maximumXp,
    ).toInt();
  }

  static int calculateLevelNumber(
    int totalXp,
  ) {
    final xp = normalizeXp(
      totalXp,
    );

    if (xp >= 144) {
      return 5;
    }

    if (xp >= 108) {
      return 4;
    }

    if (xp >= 72) {
      return 3;
    }

    if (xp >= 36) {
      return 2;
    }

    return 1;
  }

  static String calculateLevelTitle(
    int totalXp,
  ) {
    final level = calculateLevelNumber(
      totalXp,
    );

    return calculateLevelTitleFromNumber(
      level,
    );
  }

  static String calculateLevelTitleFromNumber(
    int levelNumber,
  ) {
    switch (levelNumber) {
      case 5:
        return 'Master Oceana';

      case 4:
        return 'Penjaga Samudra';

      case 3:
        return 'Explorer Oceana';

      case 2:
        return 'Penjelajah Laut';

      case 1:
      default:
        return 'Penjelajah Pemula';
    }
  }

  static int _asInt(
    dynamic value, {
    int defaultValue = 0,
  }) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    if (value is String) {
      return int.tryParse(value) ??
          defaultValue;
    }

    return defaultValue;
  }
}
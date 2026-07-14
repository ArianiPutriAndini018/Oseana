import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/controllers/user_profile_controller.dart';
import '../../core/services/auth_service.dart';
import '../../data/repositories/passport_repository.dart';
import '../../data/sea_passport_data.dart';
import '../../models/sea_passport_reward_model.dart';
import '../../models/sea_passport_stamp_model.dart';
import 'sea_passport_card.dart';

class SeaPassportContent extends StatefulWidget {
  const SeaPassportContent({super.key});

  @override
  State<SeaPassportContent> createState() => _SeaPassportContentState();
}

class _SeaPassportContentState extends State<SeaPassportContent> {
  final _passportRepository = PassportRepository();
  final _authService = AuthService();

  List<SeaPassportStampModel> _stamps = [];
  List<SeaPassportRewardModel> _rewards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPassportData();
  }

  Future<void> _loadPassportData() async {
    final userId = _authService.currentUser?.id;

    try {
      final stamps = await _passportRepository.getStamps(userId);
      final rewards = await _passportRepository.getRewards(userId);

      if (!mounted) return;

      setState(() {
        _stamps = stamps.map((s) {
          final local = SeaPassportData.stamps.firstWhere((ls) => ls.id == s.id, orElse: () => s);
          // Prefer local image if available, otherwise check if Supabase image is valid, else force empty string.
          final validImage = (local.image != null && local.image!.isNotEmpty) 
              ? local.image 
              : ((s.image != null && s.image!.length > 5) ? s.image : "");
          return s.copyWith(image: validImage);
        }).toList()..sort((a, b) => a.order.compareTo(b.order));

        _rewards = rewards.map((r) {
          final local = SeaPassportData.rewards.firstWhere((lr) => lr.id == r.id, orElse: () => r);
          final validImage = (local.image.isNotEmpty) 
              ? local.image 
              : ((r.image.length > 5) ? r.image : "");
          return r.copyWith(image: validImage);
        }).where((r) => r.isUnlocked).toList()
          ..sort((a, b) => a.order.compareTo(b.order));

        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  int get _completedIslandCount =>
      _stamps.where((s) => s.isUnlocked).length;

  int get _totalIslandCount => _stamps.isEmpty ? 7 : _stamps.length;

  double get _learningProgressValue {
    if (_totalIslandCount <= 0) return 0;
    return _completedIslandCount / _totalIslandCount;
  }

  int get _learningProgressPercent =>
      (_learningProgressValue * 100).round();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return AnimatedBuilder(
      animation: UserProfileController.instance,
      builder: (context, _) {
        final profileController = UserProfileController.instance;

        return SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              isSmall ? 24 : 26,
              isSmall ? 44 : 64,
              isSmall ? 16 : 18,
              135,
            ),
            child: Column(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Sea Passport & Progress',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.blueDark,
                      fontSize: isSmall ? 18 : 22,
                      fontWeight: FontWeight.w900,
                      height: 1,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                SizedBox(height: isSmall ? 20 : 24),
                SeaPassportCard(
                  userName: profileController.userName,
                  avatar: profileController.avatar,
                  level: profileController.level,
                  title: profileController.title,
                  xp: profileController.xp,
                  stamps: _stamps,
                  rewards: _rewards,
                  completedIslandCount: _completedIslandCount,
                  totalIslandCount: _totalIslandCount,
                  learningProgressValue: _learningProgressValue,
                  learningProgressPercent: _learningProgressPercent,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

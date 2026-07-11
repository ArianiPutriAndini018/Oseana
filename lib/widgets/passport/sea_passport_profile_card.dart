import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';

class SeaPassportProfileCard extends StatelessWidget {
  final String userName;
  final String avatar;
  final String level;
  final String title;
  final int xp;

  const SeaPassportProfileCard({
    super.key,
    required this.userName,
    required this.avatar,
    required this.level,
    required this.title,
    required this.xp,
  });

  static const Color _borderColor = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isSmall ? 12 : 14,
        isSmall ? 9 : 10,
        isSmall ? 12 : 14,
        isSmall ? 9 : 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusXXL,
        border: Border.all(
          color: _borderColor,
          width: 2,
        ),
        boxShadow: AppShadows.medium,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _AvatarImage(
            image: avatar,
            size: isSmall ? 64 : 72,
          ),
          SizedBox(width: isSmall ? 12 : 14),
          Expanded(
            child: _ProfileInfo(
              userName: userName,
              level: level,
              title: title,
              isSmall: isSmall,
            ),
          ),
          SizedBox(width: isSmall ? 8 : 10),
          _XpBadge(
            xp: xp,
            isSmall: isSmall,
          ),
        ],
      ),
    );
  }
}

class _AvatarImage extends StatelessWidget {
  final String image;
  final double size;

  const _AvatarImage({
    required this.image,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        image,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  final String userName;
  final String level;
  final String title;
  final bool isSmall;

  const _ProfileInfo({
    required this.userName,
    required this.level,
    required this.title,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final levelStyle = AppTextStyles.bodySmall.copyWith(
      color: AppColors.primary,
      fontSize: isSmall ? 10 : 12,
      fontWeight: FontWeight.w900,
      height: 1.15,
    );

    final titleStyle = AppTextStyles.bodySmall.copyWith(
      color: AppColors.textGrey,
      fontSize: isSmall ? 8 : 10,
      fontWeight: FontWeight.w800,
      height: 1.15,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          userName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.blueDark,
            fontSize: isSmall ? 14 : 16,
            fontWeight: FontWeight.w900,
            height: 1,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: isSmall ? 6 : 7),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: level,
                style: levelStyle,
              ),
              TextSpan(
                text: ' • ',
                style: levelStyle,
              ),
              TextSpan(
                text: title,
                style: titleStyle,
              ),
            ],
          ),
          softWrap: true,
        ),
      ],
    );
  }
}

class _XpBadge extends StatelessWidget {
  final int xp;
  final bool isSmall;

  const _XpBadge({
    required this.xp,
    required this.isSmall,
  });

  static const Color _borderColor = Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 10,
        vertical: isSmall ? 6 : 7,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppRadius.radiusMD,
        border: Border.all(
          color: _borderColor,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImages.passportXpIcon,
            width: isSmall ? 24 : 26,
            height: isSmall ? 24 : 26,
            fit: BoxFit.contain,
          ),
          SizedBox(width: isSmall ? 1 : 3),
          Text(
            '$xp XP',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.blueDark,
              fontSize: isSmall ? 13 : 15,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

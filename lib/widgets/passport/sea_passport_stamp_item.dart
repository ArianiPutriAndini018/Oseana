import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/sea_passport_stamp_model.dart';

class SeaPassportStampItem extends StatelessWidget {
  final SeaPassportStampModel stamp;
  final bool isSmall;
  final bool isBottomRow;

  const SeaPassportStampItem({
    super.key,
    required this.stamp,
    required this.isSmall,
    this.isBottomRow = false,
  });

  @override
  Widget build(BuildContext context) {
    final stampSize =
        isBottomRow ? (isSmall ? 62.0 : 70.0) : (isSmall ? 68.0 : 76.0);

    final lockSize =
        isBottomRow ? (isSmall ? 60.0 : 68.0) : (isSmall ? 66.0 : 74.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: stampSize,
          height: stampSize,
          child: stamp.isUnlocked && stamp.hasImage
              ? _UnlockedStamp(
                  image: stamp.image!,
                  size: stampSize,
                )
              : _LockedStamp(
                  size: lockSize,
                ),
        ),
        SizedBox(height: isSmall ? 7 : 8),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isBottomRow ? 1 : 2,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              stamp.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.blueDark,
                fontSize: isBottomRow
                    ? (isSmall ? 10.2 : 11.2)
                    : (isSmall ? 11.2 : 12.2),
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UnlockedStamp extends StatelessWidget {
  final String image;
  final double size;

  const _UnlockedStamp({
    required this.image,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      width: size,
      height: size,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: size,
          height: size,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.image_not_supported_outlined,
          size: size,
          color: Colors.grey,
        );
      },
    );
  }
}

class _LockedStamp extends StatelessWidget {
  final double size;

  const _LockedStamp({
    required this.size,
  });

  static const Color _lockedBackground = Color(0xFFD9D9D9);
  static const Color _lockedBorder = Color(0xFFD1D5DB);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _lockedBackground,
          borderRadius: AppRadius.pill,
          border: Border.all(
            color: _lockedBorder,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.12),
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          Icons.lock_rounded,
          color: AppColors.blueDark,
          size: size * 0.42,
        ),
      ),
    );
  }
}

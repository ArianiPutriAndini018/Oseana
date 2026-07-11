import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_radius.dart';
import '../../core/constants/app_shadows.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/sea_passport_stamp_model.dart';
import 'sea_passport_stamp_item.dart';

class SeaPassportStampCollection extends StatefulWidget {
  final List<SeaPassportStampModel> stamps;

  const SeaPassportStampCollection({
    super.key,
    required this.stamps,
  });

  @override
  State<SeaPassportStampCollection> createState() =>
      _SeaPassportStampCollectionState();
}

class _SeaPassportStampCollectionState
    extends State<SeaPassportStampCollection> {
  bool _isExpanded = false;

  static const Color _borderColor = Color(0xFFD9D9D9);
  static const Color _innerBackground = Color(0xFFF7FAFF);

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    final visibleStamps =
        _isExpanded ? widget.stamps : widget.stamps.take(3).toList();

    final canExpand = widget.stamps.length > 3;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        isSmall ? 12 : 14,
        isSmall ? 16 : 18,
        isSmall ? 12 : 14,
        isSmall ? 12 : 14,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: isSmall ? 2 : 4,
            ),
            child: Text(
              'Koleksi Stamp Pulau',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.blueDark,
                fontSize: isSmall ? 12 : 14,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
          SizedBox(height: isSmall ? 12 : 14),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                isSmall ? 10 : 12,
                isSmall ? 12 : 14,
                isSmall ? 10 : 12,
                isSmall ? 10 : 12,
              ),
              decoration: BoxDecoration(
                color: _innerBackground,
                borderRadius: AppRadius.radiusXXL,
                border: Border.all(
                  color: _borderColor,
                  width: 2,
                ),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: visibleStamps.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: isSmall ? 6 : 8,
                  crossAxisSpacing: isSmall ? 12 : 14,
                  mainAxisExtent: isSmall ? 104 : 116,
                ),
                itemBuilder: (context, index) {
                  return SeaPassportStampItem(
                    stamp: visibleStamps[index],
                    isSmall: isSmall,
                  );
                },
              ),
            ),
          ),
          if (canExpand) ...[
            SizedBox(height: isSmall ? 8 : 10),
            Center(
              child: TextButton(
                onPressed: _toggleExpanded,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmall ? 14 : 16,
                    vertical: isSmall ? 6 : 7,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isExpanded
                          ? 'Tampilkan Lebih Sedikit'
                          : 'Lihat Selengkapnya',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontSize: isSmall ? 12 : 13,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                    SizedBox(width: isSmall ? 4 : 5),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primary,
                      size: isSmall ? 18 : 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

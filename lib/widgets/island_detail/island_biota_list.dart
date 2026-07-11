import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/biota_model.dart';
import 'island_biota_list_item.dart';

class IslandBiotaList extends StatelessWidget {
  final List<BiotaModel> biotas;
  final ValueChanged<BiotaModel>? onBiotaTap;

  const IslandBiotaList({
    super.key,
    required this.biotas,
    this.onBiotaTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 380;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${biotas.length} Biota Khas',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.primary,
            fontSize: isSmall ? 14 : 16,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
        SizedBox(height: isSmall ? 12 : 14),
        ...biotas.map(
          (biota) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: isSmall ? 16 : 18,
              ),
              child: IslandBiotaListItem(
                biota: biota,
                onTap: () => onBiotaTap?.call(biota),
              ),
            );
          },
        ),
      ],
    );
  }
}

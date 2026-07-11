import 'package:flutter/material.dart';

import '../../core/constants/app_radius.dart';
import '../../models/biota_model.dart';

class BiotaImageCard extends StatelessWidget {
  final BiotaModel biota;
  final double? width;
  final double? height;
  final double aspectRatio;
  final BoxFit fit;

  const BiotaImageCard({
    super.key,
    required this.biota,
    this.width,
    this.height,
    this.aspectRatio = 1.78,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final image = _buildImage();

    final imageCard = ClipRRect(
      borderRadius: AppRadius.radiusXXL,
      child: image,
    );

    if (height != null) {
      return SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: imageCard,
      );
    }

    final aspectRatioCard = AspectRatio(
      aspectRatio: aspectRatio,
      child: imageCard,
    );

    if (width != null) {
      return SizedBox(
        width: width,
        child: aspectRatioCard,
      );
    }

    return aspectRatioCard;
  }

  Widget _buildImage() {
    if (biota.image.startsWith('http')) {
      return Image.network(
        biota.image,
        width: double.infinity,
        height: double.infinity,
        fit: fit,
      );
    }

    return Image.asset(
      biota.image,
      width: double.infinity,
      height: double.infinity,
      fit: fit,
    );
  }
}

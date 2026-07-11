import 'package:flutter/material.dart';

class CheckpointBanner extends StatelessWidget {
  final String image;
  final double? height;
  final double? aspectRatio;
  final BoxFit fit;

  const CheckpointBanner({
    super.key,
    required this.image,
    this.height,
    this.aspectRatio,
    this.fit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    if (aspectRatio != null) {
      return AspectRatio(
        aspectRatio: aspectRatio!,
        child: _buildImage(),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: height,
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (image.startsWith('http')) {
      return Image.network(
        image,
        width: double.infinity,
        height: double.infinity,
        fit: fit,
        errorBuilder: (_, __, ___) {
          return _buildErrorPlaceholder();
        },
      );
    }

    return Image.asset(
      image,
      width: double.infinity,
      height: double.infinity,
      fit: fit,
      filterQuality: FilterQuality.high,
      errorBuilder: (_, __, ___) {
        return _buildErrorPlaceholder();
      },
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: const Color(0xFFE7F3FA),
      child: const Icon(
        Icons.image_not_supported_outlined,
        size: 42,
        color: Color(0xFF035FCB),
      ),
    );
  }
}

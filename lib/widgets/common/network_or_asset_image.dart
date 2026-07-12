import 'package:flutter/material.dart';

class NetworkOrAssetImage extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final Color? color;

  const NetworkOrAssetImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            width: width,
            height: height,
            child: const Center(
              child: Icon(Icons.broken_image, color: Colors.grey),
            ),
          );
        },
      );
    }

    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      color: color,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: Icon(Icons.broken_image, color: Colors.grey),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class MissionStatImage extends StatelessWidget {
  final String image;
  final double size;
  final double scale;

  const MissionStatImage({
    super.key,
    required this.image,
    required this.size,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Transform.scale(
          scale: scale,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
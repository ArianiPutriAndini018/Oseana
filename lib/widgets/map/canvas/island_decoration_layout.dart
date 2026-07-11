import 'package:flutter/material.dart';

class IslandDecorationLayout {
  final Offset label;
  final Offset node;
  final Offset? stars;

  const IslandDecorationLayout({
    required this.label,
    required this.node,
    this.stars,
  });

  static IslandDecorationLayout of(String name) {
    switch (name) {
      case 'Sumatra':
        return const IslandDecorationLayout(
          label: Offset(0.15, 0.39),
          node: Offset(0.34, 0.35),
          stars: Offset(0.15, 0.42),
        );

      case 'Jawa':
        return const IslandDecorationLayout(
          label: Offset(0.20, 0.61),
          node: Offset(0.40, 0.55),
          stars: Offset(0.20, 0.64),
        );

      case 'Kalimantan':
        return const IslandDecorationLayout(
          label: Offset(0.58, 0.21),
          node: Offset(0.47, 0.16),
          stars: Offset(0.58, 0.24),
        );

      case 'Sulawesi':
        return const IslandDecorationLayout(
          label: Offset(0.79, 0.39),
          node: Offset(0.80, 0.20),
          stars: Offset(0.79, 0.42),
        );

      case 'Papua':
        return const IslandDecorationLayout(
          label: Offset(0.73, 0.68),
          node: Offset(0.63, 0.62),
          stars: Offset(0.73, 0.71),
        );

      case 'NTB':
        return const IslandDecorationLayout(
          label: Offset(0.18, 0.82),
          node: Offset(0.38, 0.76),
          stars: Offset(0.18, 0.85),
        );

      case 'NTT':
        return const IslandDecorationLayout(
          label: Offset(0.73, 0.96),
          node: Offset(0.43, 0.87),
          stars: Offset(0.73, 0.99),
        );

      default:
        return const IslandDecorationLayout(
          label: Offset(0.50, 0.50),
          node: Offset(0.50, 0.60),
        );
    }
  }
}

import 'package:flutter/material.dart';

class ProfileMenuModel {
  final String id;
  final String title;
  final String iconKey;
  final String? iconAsset;
  final IconData fallbackIcon;
  final int order;

  const ProfileMenuModel({
    required this.id,
    required this.title,
    required this.iconKey,
    required this.fallbackIcon,
    required this.order,
    this.iconAsset,
  });

  ProfileMenuModel copyWith({
    String? id,
    String? title,
    String? iconKey,
    String? iconAsset,
    IconData? fallbackIcon,
    int? order,
  }) {
    return ProfileMenuModel(
      id: id ?? this.id,
      title: title ?? this.title,
      iconKey: iconKey ?? this.iconKey,
      iconAsset: iconAsset ?? this.iconAsset,
      fallbackIcon: fallbackIcon ?? this.fallbackIcon,
      order: order ?? this.order,
    );
  }
}

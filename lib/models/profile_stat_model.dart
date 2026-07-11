import 'package:flutter/material.dart';

class ProfileStatModel {
  final String id;
  final String title;
  final String value;
  final String iconKey;
  final String? iconAsset;
  final IconData fallbackIcon;
  final Color fallbackIconColor;
  final int order;

  const ProfileStatModel({
    required this.id,
    required this.title,
    required this.value,
    required this.iconKey,
    required this.fallbackIcon,
    required this.fallbackIconColor,
    required this.order,
    this.iconAsset,
  });

  ProfileStatModel copyWith({
    String? id,
    String? title,
    String? value,
    String? iconKey,
    String? iconAsset,
    IconData? fallbackIcon,
    Color? fallbackIconColor,
    int? order,
  }) {
    return ProfileStatModel(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      iconKey: iconKey ?? this.iconKey,
      iconAsset: iconAsset ?? this.iconAsset,
      fallbackIcon: fallbackIcon ?? this.fallbackIcon,
      fallbackIconColor: fallbackIconColor ?? this.fallbackIconColor,
      order: order ?? this.order,
    );
  }
}

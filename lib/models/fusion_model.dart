import 'package:flutter/material.dart';

class Character {
  final String id;
  final String name;
  final String universe; // 'MCU' or 'JJK'
  final String titleTag; // e.g. 'MYSTIC SUPREME', 'LIMITLESS // 6 EYES'
  final int powerRating;
  final IconData icon;
  final Color themeColor;

  const Character({
    required this.id,
    required this.name,
    required this.universe,
    required this.titleTag,
    required this.powerRating,
    required this.icon,
    required this.themeColor,
  });
}

class FusionAbility {
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  const FusionAbility({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class FusionCharacter {
  final String id;
  final String name;
  final String mcuParent;
  final String jjkParent;
  final int powerLevel;
  final String rank; // 'SPECIAL GRADE', 'RANK S', 'RANK A'
  final String domainExpansion;
  final String domainDescription;
  final String mcuPowersName;
  final List<String> mcuPowerTags;
  final String mcuPowersDescription;
  final String originStory;
  final List<FusionAbility> abilities;
  final Color primaryColor;
  final String? imageUrl;
  final IconData avatarIcon;

  const FusionCharacter({
    required this.id,
    required this.name,
    required this.mcuParent,
    required this.jjkParent,
    required this.powerLevel,
    required this.rank,
    required this.domainExpansion,
    required this.domainDescription,
    required this.mcuPowersName,
    required this.mcuPowerTags,
    required this.mcuPowersDescription,
    required this.originStory,
    required this.abilities,
    required this.primaryColor,
    this.imageUrl,
    this.avatarIcon = Icons.auto_awesome,
  });
}

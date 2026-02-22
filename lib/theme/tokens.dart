// lib/theme/tokens.dart

import 'package:flutter/material.dart';

class AppColors {
  // Base backgrounds
  static const background = Color(0xFF111214);
  static const surface = Color(0xFF15171A);
  static const surface2 = Color(0xFF1B1E22);

  // Paper tones (for search + premium strip)
  static const paper = Color(0xFFF3EFE6);
  static const paper2 = Color(0xFFE9E4DA);

  // Text
  static const textPrimary = Color(0xFFE6E6E6);
  static const textMuted = Color.fromRGBO(230, 230, 230, 0.65);
  static const textDark = Color(0xFF1A1A1A);

  // Accent
  static const gold = Color(0xFFC9A64B);
  static const goldBorder = Color.fromRGBO(201, 166, 75, 0.35);

  // Borders
  static const cardBorder = Color.fromRGBO(255, 255, 255, 0.06);

  // Utility
  static const cartRed = Color(0xFFD24B4B);
  static const white = Colors.white;
}

class AppSpacing {
  static const xs = 6.0;
  static const sm = 10.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

class AppRadius {
  static const sm = 8.0;
  static const md = 14.0;
  static const lg = 22.0;
  static const xl = 28.0;
}
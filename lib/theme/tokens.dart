import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF0B0E12);
  static const surface = Color(0xFF111720);
  static const surface2 = Color(0xFF0F141C);
  static const stroke = Color(0xFF1B2431);
  static const muted = Color(0xFF96A3B4);
  static const text = Color(0xFFEAF0F8);
  static const gold = Color(0xFFD4B15D);


  // ------------------------------------------------------------
  // Compatibility aliases (some widgets/pages use these names).
  // Keep them const so they work inside const widgets.
  // ------------------------------------------------------------
  static const background = bg;
  static const card = surface;
  static const border = stroke;

  static const textPrimary = text;
  static const textSecondary = muted;
  static const textMuted = muted;

  // Additional legacy tokens used in a few widgets.
  static const panel = surface;
  static const panel2 = surface2;
  static const line = stroke;
  static const gold2 = gold;
  static const danger = Color(0xFFE05A5A);
}

class AppText {
  static const h1 = TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.text);
  static const h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.text);
  static const h3 = TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text);

  static const body = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.text);
  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.text);
}

/// Radius tokens.
/// Some files use `AppRadius.*` and others use `AppRadii.*`.
class AppRadius {
  static const double xs = 8;
  static const double sm = 10;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double pill = 999;
}

class AppRadii {
  static const double xs = AppRadius.xs;
  static const double sm = AppRadius.sm;
  static const double md = AppRadius.md;
  static const double lg = AppRadius.lg;
  static const double xl = AppRadius.xl;
  static const double pill = AppRadius.pill;
}

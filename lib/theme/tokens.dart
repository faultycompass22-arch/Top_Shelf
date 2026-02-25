import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF0B0E12);
  static const surface = Color(0xFF111720);
  static const surface2 = Color(0xFF0F141C);
  static const stroke = Color(0xFF1B2431);
  static const muted = Color(0xFF96A3B4);
  static const text = Color(0xFFEAF0F8);
  static const gold = Color(0xFFD4B15D);
}

class AppText {
  static const h1 = TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.text);
  static const h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.text);
  static const h3 = TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text);

  static const body = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.text);
  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.text);
}
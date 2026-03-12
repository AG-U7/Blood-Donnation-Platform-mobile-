import 'package:flutter/material.dart';

class AppColors {
  // Couleurs issues de theme.css (:root)
  static const Color background = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF111111); // oklch(0.145 0 0) approximé
  static const Color primary = Color(0xFF030213);
  static const Color primaryForeground = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFFF3F3F5); // oklch(0.95 0.0058 264.53) approximé
  static const Color secondaryForeground = Color(0xFF030213);
  static const Color muted = Color(0xFFECECF0);
  static const Color mutedForeground = Color(0xFF717182);
  static const Color accent = Color(0xFFE9EBEF);
  static const Color accentForeground = Color(0xFF030213);
  static const Color destructive = Color(0xFFD4183D);
  static const Color destructiveForeground = Color(0xFFFFFFFF);
  static const Color border = Color(0x1A000000); // rgba(0, 0, 0, 0.1)
  static const Color inputBackground = Color(0xFFF3F3F5);
  static const Color switchBackground = Color(0xFFCBCED4);

  // Couleurs spécifiques SangVie identifiées dans le projet Web
  static const Color sangVieRed = Color(0xFFCC0000);
  static const Color successGreen = Color(0xFF1A7A3F);
  static const Color warningOrange = Color(0xFFD4720B);
}

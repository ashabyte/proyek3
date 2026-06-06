import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4C6977);
  static const Color primaryDark = Color(0xFF3A5566);
  static const Color primaryLight = Color(0xFF6B8FA3);
  static const Color accent = Color(0xFF8FBCCC);
  static const Color accentLight = Color(0xFFB8D4DF);

  static const Color surface = Color(0xFFF7F8FA);
  static const Color card = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF1A2530);
  static const Color textSecondary = Color(0xFF4A5C6A);
  static const Color textHint = Color(0xFF8A9FAE);

  static const Color border = Color(0xFFE2EAEf);
  static const Color divider = Color(0xFFEEF2F5);

  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);

  static const Color serviceGradient1Start = Color(0xFF3A5F75);
  static const Color serviceGradient1End = Color(0xFF4E6E81);
  static const Color serviceGradient2Start = Color(0xFF2D6E5A);
  static const Color serviceGradient2End = Color(0xFF3D8A6F);
  static const Color serviceGradient3Start = Color(0xFF5A4A7A);
  static const Color serviceGradient3End = Color(0xFF7A6AAA);

  static const Color starColor = Color(0xFFF5A623);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDark, primary],
  );

  static const LinearGradient service1Gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [serviceGradient1Start, serviceGradient1End],
  );

  static const LinearGradient service2Gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [serviceGradient2Start, serviceGradient2End],
  );

  static const LinearGradient service3Gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [serviceGradient3Start, serviceGradient3End],
  );
}

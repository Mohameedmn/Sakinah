import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 65, 108, 38);  
  static const Color secondart = Color(0xFFBFD8AF);  

  static const Color background = Color(0xFFF6F2E9);     // Soft beige
  static const Color card = Colors.white;
  static const Color accent = Color(0xFFBFD8AF);         // Light green
  static const Color textPrimary = Color(0xFF1C1C1C);    // Dark text
  static const Color textSecondary = Colors.black54;
  static const Color gray = Color(0xFFE0E0E0);           // Border/Line
}

class AppTextStyles {
  static const TextStyle headingLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}

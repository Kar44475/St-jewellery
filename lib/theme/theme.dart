// lib/theme.dart
import 'package:flutter/material.dart';

final ThemeData stJewelleryTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF903036), // Deep maroon
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF903036),
    foregroundColor: Colors.white,
    elevation: 2,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  textTheme: TextTheme(
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1E1E1E),
    ),
    bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF1E1E1E)),
    bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF666666)),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color(0xFF903036),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF903036),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0x26FFCB03),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Color(0xFFFFCB03), // Yellow border
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFFFCB03)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF903036), width: 2),
    ),
    hintStyle: TextStyle(color: Colors.grey),
  ),
  cardTheme: CardThemeData(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Color(0xFFFFCB03)),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Color(0xFFD4AF37), // Accent gold
  ),
);

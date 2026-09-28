import 'package:flutter/material.dart';

abstract final class NetqiraTheme {
  static const primary = Color(0xFF1268F3);
  static const cyan = Color(0xFF20C8F6);
  static const navy = Color(0xFF071B36);
  static const ink = Color(0xFF0D1B35);
  static const muted = Color(0xFF6E7D95);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: primary),
    scaffoldBackgroundColor: const Color(0xFFF5F8FC),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: ink,
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 72,
      backgroundColor: Colors.white,
      indicatorColor: primary.withValues(alpha: 0.10),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: cyan,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF06162B),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 72,
      backgroundColor: const Color(0xFF0A1D38),
      indicatorColor: cyan.withValues(alpha: 0.12),
    ),
  );
}

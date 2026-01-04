import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

class AppTheme {
  static const Color primary = Color(0xFF1A1F29);
  static const Color accent = Color(0xFFFFC107);

  /* ================= LIGHT THEME ================= */

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF7F7FB),
    dividerColor: Colors.grey[300],
    primaryColor: primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(foregroundColor: Colors.black, elevation: 0),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: EdgeInsets.zero,
    ),
  );

  /* ================= DARK THEME ================= */

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF090D1F),
    primaryColor: Colors.white,
    cardColor: const Color(0xFF12172A),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(foregroundColor: Colors.white, elevation: 0),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: EdgeInsets.zero,
    ),
  );

  /* ================= CODE EDITOR THEME ================= */

  static final CodeThemeData devCppDark = CodeThemeData(
    styles: {
      'root': const TextStyle(
        color: Color(0xFFD4D4D4),
        backgroundColor: Color(0xFF1E1E1E),
      ),
      'keyword': const TextStyle(color: Color(0xFF569CD6)),
      'type': const TextStyle(color: Color(0xFF4EC9B0)),
      'string': const TextStyle(color: Color(0xFFD69D85)),
      'comment': const TextStyle(color: Color(0xFF6A9955)),
      'number': const TextStyle(color: Color(0xFFB5CEA8)),
      'built_in': const TextStyle(color: Color(0xFF4FC1FF)),
      'operator': const TextStyle(color: Color(0xFFD4D4D4)),
    },
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Gavel's visual language: courtroom ink and brass, hackathon energy.
class G {
  G._();

  static const ink = Color(0xFF0B1020);
  static const ink2 = Color(0xFF11172A);
  static const ink3 = Color(0xFF1A2240);
  static const line = Color(0x1AF4EFE6);
  static const paper = Color(0xFFF4EFE6);
  static const muted = Color(0xA8F4EFE6);
  static const faint = Color(0x66F4EFE6);
  static const brass = Color(0xFFE9B949);
  static const brass2 = Color(0xFFC99A2E);
  static const signal = Color(0xFFFF5A4E);
  static const mint = Color(0xFF43D9A3);
  static const sky = Color(0xFF6EA8FF);

  static TextStyle serif({
    double size = 28,
    FontWeight weight = FontWeight.w600,
    Color color = paper,
    FontStyle? style,
    double? height,
  }) => GoogleFonts.fraunces(
    fontSize: size,
    fontWeight: weight,
    color: color,
    fontStyle: style,
    height: height ?? 1.05,
    letterSpacing: size > 30 ? -1 : -0.3,
  );

  static TextStyle sans({
    double size = 15,
    FontWeight weight = FontWeight.w500,
    Color color = paper,
    double? height,
    double? spacing,
  }) => GoogleFonts.manrope(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: spacing,
  );

  static TextStyle mono({
    double size = 14,
    FontWeight weight = FontWeight.w500,
    Color color = paper,
    double? spacing,
  }) => GoogleFonts.jetBrainsMono(
    fontSize: size,
    fontWeight: weight,
    color: color,
    letterSpacing: spacing,
  );

  static TextStyle eyebrow({Color color = brass}) =>
      mono(size: 11.5, weight: FontWeight.w600, color: color, spacing: 2.2);

  static ThemeData theme() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ink,
      colorScheme: const ColorScheme.dark(
        primary: brass,
        onPrimary: ink,
        secondary: mint,
        surface: ink2,
        onSurface: paper,
        error: signal,
      ),
    );
    return base.copyWith(
      textTheme: GoogleFonts.manropeTextTheme(
        base.textTheme,
      ).apply(bodyColor: paper, displayColor: paper),
      dividerColor: line,
      cardTheme: CardThemeData(
        color: ink2,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: line),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ink3,
        hintStyle: sans(color: faint),
        labelStyle: sans(color: muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: brass, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: brass,
          foregroundColor: ink,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          textStyle: sans(size: 15.5, weight: FontWeight.w800, color: ink),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: paper,
          side: const BorderSide(color: line),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          textStyle: sans(size: 14.5, weight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: brass,
          textStyle: sans(size: 14, weight: FontWeight.w700),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ink3,
        contentTextStyle: sans(color: paper),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: paper,
        unselectedLabelColor: muted,
        indicatorColor: brass,
        dividerColor: line,
        labelStyle: sans(size: 14, weight: FontWeight.w800),
        unselectedLabelStyle: sans(size: 14, weight: FontWeight.w600),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: ink2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: line),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? ink : muted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? brass : ink3,
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: ink3,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: line),
        ),
        textStyle: sans(size: 12.5),
      ),
    );
  }
}

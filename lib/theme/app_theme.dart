import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color voidBg = Color(0xFF050508);
  static const Color surface = Color(0xFF131317);
  static const Color surfaceContainerLow = Color(0xFF1B1B1F);
  static const Color surfaceContainer = Color(0xFF1F1F23);
  static const Color surfaceContainerHigh = Color(0xFF2A292E);
  static const Color surfaceContainerHighest = Color(0xFF353439);
  static const Color surfaceContainerLowest = Color(0xFF0E0E12);

  // Accents
  static const Color primary = Color(0xFFDDB7FF);
  static const Color primaryContainer = Color(0xFFB76DFF);
  static const Color cursedPurple = Color(0xFFA855F7);
  static const Color deepPurple = Color(0xFF7C3AED);

  static const Color secondary = Color(0xFF7BD0FF);
  static const Color secondaryContainer = Color(0xFF00A6E0);
  static const Color iceBlue = Color(0xFF38BDF8);

  static const Color tertiary = Color(0xFFFFB4AB);
  static const Color tertiaryContainer = Color(0xFFFF544A);
  static const Color crimsonSlash = Color(0xFFDC2626);

  static const Color onSurface = Color(0xFFE5E1E7);
  static const Color onSurfaceVariant = Color(0xFFCFC2D6);
  static const Color outline = Color(0xFF988D9F);
  static const Color outlineVariant = Color(0xFF4D4354);
}

class AppGradients {
  static const LinearGradient cursedLaser = LinearGradient(
    colors: [AppColors.primary, AppColors.secondary, AppColors.tertiaryContainer],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient fusionButton = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFFDC2626), Color(0xFF6D28D9)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient cardBg = LinearGradient(
    colors: [Color(0x661B1B1F), Color(0x330E0E12)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient powerGauge = LinearGradient(
    colors: [AppColors.tertiaryContainer, AppColors.primaryContainer, AppColors.secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppStyles {
  // Headings
  static TextStyle displayHero({Color color = Colors.white}) =>
      GoogleFonts.spaceGrotesk(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: color);

  static TextStyle headlineLg({Color color = Colors.white}) =>
      GoogleFonts.spaceGrotesk(fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: color);

  static TextStyle headlineMd({Color color = Colors.white}) =>
      GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0.8, color: color);

  static TextStyle headlineSm({Color color = Colors.white}) =>
      GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.6, color: color);

  // Body
  static TextStyle bodyLg({Color color = AppColors.onSurface}) =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: color);

  static TextStyle bodyMd({Color color = AppColors.onSurface}) =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: color);

  static TextStyle bodySm({Color color = AppColors.outline}) =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: color);

  // Cyber / HUD Labels
  static TextStyle labelCyberLg({Color color = AppColors.primary}) =>
      GoogleFonts.spaceMono(fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.8, color: color);

  static TextStyle labelCyberMd({Color color = AppColors.outline}) =>
      GoogleFonts.spaceMono(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: color);

  static TextStyle labelCyberSm({Color color = AppColors.outline}) =>
      GoogleFonts.spaceMono(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.8, color: color);
}

BoxDecoration glassCardDecoration({
  Color borderColor = const Color(0x664D4354),
  Color glowColor = Colors.transparent,
  double glowRadius = 0,
  double borderRadius = 12,
  Color bgColor = const Color(0x661B1B1F),
}) {
  return BoxDecoration(
    color: bgColor,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: borderColor, width: 1),
    boxShadow: glowRadius > 0
        ? [
            BoxShadow(
              color: glowColor,
              blurRadius: glowRadius,
              spreadRadius: 1,
            )
          ]
        : [],
  );
}

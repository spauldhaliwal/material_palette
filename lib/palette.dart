library material_palette;

import 'package:flutter/material.dart';
import 'package:material_palette/src/color_generator.dart';
import 'package:material_palette/src/color_spaces/rgb.dart';
import 'package:material_palette/src/swatch.dart';
import 'package:material_palette/src/util.dart';

import 'src/constants.dart';

export 'src/swatch.dart';
export 'src/swatch_dark.dart';

part 'src/harmonies/analogous.dart';
part 'src/harmonies/complementary.dart';
part 'src/harmonies/split_complementary.dart';
part 'src/harmonies/tetradic.dart';
part 'src/harmonies/triadic_120.dart';
part 'src/harmonies/triadic_60.dart';

class Palette {
  final Swatch primarySwatch;

  Palette(Color seedColor) : primarySwatch = Swatch(seedColor);

  /// Creates a [Palette] with a pre-defined [Swatch]
  Palette._withSwatch(Swatch seedSwatch) : primarySwatch = seedSwatch;

  /// Takes a [Palette] and returns it as a [ComplementaryPalette]
  ComplementaryPalette withComplementaryHarmony() {
    return ComplementaryPalette._fromPrimarySwatch(primarySwatch);
  }

  /// Takes a [Palette] and returns it as a [AnalogousPalette]
  AnalogousPalette withAnalogousHarmony() {
    return AnalogousPalette._fromPrimarySwatch(primarySwatch);
  }

  /// Takes a [Palette] and returns it as a [Triadic60Palette]
  Triadic60Palette withTriadic60Harmony() {
    return Triadic60Palette._fromPrimarySwatch(primarySwatch);
  }

  /// Takes a [Palette] and returns it as a [Triadic120Palette]
  Triadic120Palette withTriadic120Harmony() {
    return Triadic120Palette._fromPrimarySwatch(primarySwatch);
  }

  /// Takes a [Palette] and returns it as a [SplitComplementaryPalette]
  SplitComplementaryPalette withSplitComplementaryHarmony() {
    return SplitComplementaryPalette._fromPrimarySwatch(primarySwatch);
  }

  /// Takes a [Palette] and returns it as a [TetradicPalette]
  TetradicPalette withTetradicHarmony() {
    return TetradicPalette._fromPrimarySwatch(primarySwatch);
  }

  Palette.fromHex(String seedColor) : primarySwatch = Swatch.fromHex(seedColor);

  Palette.fromLab(double lightness, double a, double b, {double alpha = 1})
      : primarySwatch = Swatch.fromLab(lightness, a, b, alpha: alpha);

  Palette.fromHSB(double hue, double saturation, double brightness)
      : primarySwatch = Swatch.fromHSB(hue, saturation, brightness);

  Palette.fromHSL(double hue, double saturation, double lightness)
      : primarySwatch = Swatch.fromHSL(hue, saturation, lightness);

  Palette.fromLCH(double lightness, double chroma, double hue)
      : primarySwatch = Swatch.fromLCH(lightness, chroma, hue);

  Palette.fromRGB(int red, int green, int blue)
      : primarySwatch = Swatch.fromRGB(red / 255, green / 255, blue / 255);
}

Color getTextColor(Color color, double minContrast) {
  RGBColor rgbColor = RGBColor(
    color.red.toDouble() / 255,
    color.green.toDouble() / 255,
    color.blue.toDouble() / 255,
  );

  /// Prefer white over black.
  /// TODO create black / white preference
  double whiteContrast = contrast(WHITE_COLOR, rgbColor);
  if (whiteContrast >= minContrast) {
    return rgb2color(WHITE_COLOR);
  }

  double darkContrast = contrast(BLACK_COLOR, rgbColor);

  if (darkContrast >= minContrast) {
    return rgb2color(BLACK_COLOR);
  } else {
    if (whiteContrast > darkContrast) {
      return rgb2color(WHITE_COLOR);
    } else {
      return rgb2color(WHITE_COLOR);
    }
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => int2hex(value);
}

extension TextColor on Color {
  /// Returns either white or black depending on which will meet minimum
  /// contrast ratio according to WCAG AA guidelines.
  Color foregroundColor() {
    const minContrast = 4.5;
    return getTextColor(this, minContrast);
  }

  Color foregroundColorXL() {
    const minContrast = 3.0;
    return getTextColor(this, minContrast);
  }

  /// Takes a [Swatch] and returns a [TextColors] object with
  /// light, medium, and dark colors from the swatch,
  /// all meeting WCAG AA guidelines.
  TextColors foregroundColors(Swatch? foregroundSwatch) {
    const minContrast = 4.5;
    return _foregroundColors(foregroundSwatch, minContrast);
  }

  /// Takes a [Swatch] and returns a [TextColors] object with
  /// light, medium, and dark colors from the swatch,
  /// all meeting WCAG AA guidelines for large text only.
  TextColors foregroundColorsXL(Swatch? foregroundSwatch) {
    const minContrast = 3.0;
    return _foregroundColors(foregroundSwatch, minContrast);
  }

  TextColors _foregroundColors(Swatch? foregroundSwatch, double minContrast) {
    final limitColor = getTextColor(this, 4.5);
    List<Color?> contrastedColorList = [];

    foregroundSwatch!.colors.forEach((key, color) {
      double contrast = contrastRatio(color);
      if (contrast > minContrast) {
        contrastedColorList.add(color);
      }
    });

    foregroundSwatch.dark.colors.forEach((key, color) {
      double contrast = contrastRatio(color);
      if (contrast > minContrast) {
        contrastedColorList.add(color);
      }
    });

    int mediumIndex = contrastedColorList.length ~/ 2;

    Color? light = contrastedColorList.firstOrNull;
    Color? medium = contrastedColorList.isNotEmpty
        ? contrastedColorList.elementAt(mediumIndex)
        : null;
    Color? dark = contrastedColorList.lastOrNull;

    return TextColors(
      light ?? limitColor,
      // medium ?? limitColor,
      dark ?? limitColor,
    );
  }

  double contrastRatio(Color foregroundColor) {
    return contrast(
      RGBColor(
        red / 255,
        green / 255,
        blue / 255,
      ),
      RGBColor(
        foregroundColor.red / 255,
        foregroundColor.green / 255,
        foregroundColor.blue / 255,
      ),
    );
  }
}

/// Contains light, medium, and dark variants of a [Color] that meet
/// WCAG AA standards against the [Swatch] form which this object was generated.
class TextColors {
  final Color light;
  // final Color medium;
  final Color dark;

  TextColors(
    this.light,
    // this.medium,
    this.dark,
  );
}

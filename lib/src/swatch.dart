import 'package:flutter/material.dart';
import 'package:material_palette/src/color_generator.dart';
import 'package:material_palette/src/swatch_dark.dart';
import 'package:material_palette/src/util.dart';

import 'color_spaces/rgb.dart';

class Swatch {
  final Map<int, Color> colors;
  late SwatchDark dark;

  _initSwatch() {
    shade50 = colors[0]!;
    shade100 = colors[1]!;
    shade200 = colors[2]!;
    shade300 = colors[3]!;
    shade400 = colors[4]!;
    shade500 = colors[5]!;
    shade600 = colors[6]!;
    shade700 = colors[7]!;
    shade800 = colors[8]!;
    shade900 = colors[9]!;
    dark = SwatchDark(this);
  }

  /// Returns an element of the swatch table.
  Color? operator [](int index) => colors[index];

  /// The color used to generate this [Swatch]
  late Color seedColor;

  /// The lightest shade.
  late Color shade50;

  /// The second lightest shade.
  late Color shade100;

  /// The third lightest shade.
  late Color shade200;

  /// The fourth lightest shade.
  late Color shade300;

  /// The fifth lightest shade.
  late Color shade400;

  /// The default shade.
  late Color shade500;

  /// The fourth darkest shade.
  late Color shade600;

  /// The third darkest shade.
  late Color shade700;

  /// The second darkest shade.
  late Color shade800;

  /// The darkest shade.
  late Color shade900;

  /// Applies action to each key/value pair of the map.
  /// Calling action must not add or remove keys from the map.
  Function(Function(int key, Color value) action) forEach(
          Function(Color color) action) =>
      colors.forEach;

  /// Returns a new map where all colors of this [Swatch] are transformed by
  /// the given convert function.
  Map<K2, V2> Function<K2, V2>(
          MapEntry<K2, V2> Function(int key, Color value) convert)
      map() => colors.map;

  /// Returns the number of colors in this [Swatch]
  int length() => colors.length;

  /// Returns a list of all the shades in this swatch.
  toList() {
    return colors.values.toList();
  }

  Swatch(Color color) : colors = generatePalette(color) {
    _initSwatch();
    seedColor = color;
  }

  Swatch.fromHex(String color) : colors = generatePalette(hex2color(color)) {
    _initSwatch();
    seedColor = hex2color(color);
  }

  Swatch.fromLab(
    double lightness,
    double a,
    double b, {
    double alpha = 1,
  }) : colors = generatePalette(lab2color(lightness, a, b, alpha)) {
    _initSwatch();
    seedColor = lab2color(lightness, a, b, alpha);
  }

  Swatch.fromHSB(
    double hue,
    double saturation,
    double brightness, {
    double alpha = 1,
  }) : colors = generatePalette(
            hsb2color(hue, saturation, brightness, alpha: alpha)) {
    _initSwatch();
    seedColor = hsb2color(hue, saturation, brightness, alpha: alpha);
  }

  Swatch.fromHSL(
    double hue,
    double saturation,
    double lightness, {
    double alpha = 1,
  }) : colors = generatePalette(
            hsl2color(hue, saturation, lightness, alpha: alpha)) {
    _initSwatch();
    seedColor = hsl2color(hue, saturation, lightness, alpha: alpha);
  }

  Swatch.fromLCH(
    double lightness,
    double chroma,
    double hue, {
    double alpha = 1,
  }) : colors = generatePalette(
          lch2color(lightness, chroma, hue, alpha: alpha),
        ) {
    _initSwatch();
    seedColor = lch2color(lightness, chroma, hue, alpha: alpha);
  }

  Swatch.fromRGB(double red, double green, double blue)
      : colors = generatePalette(
          rgb2color(RGBColor(red, green, blue, alpha: 1)),
        ) {
    _initSwatch();
    seedColor = rgb2color(RGBColor(red, green, blue, alpha: 1));
  }
}

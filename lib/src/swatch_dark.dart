import 'package:flutter/material.dart';
import 'package:material_palette/src/color_generator.dart';
import 'package:material_palette/src/swatch.dart';

class SwatchDark {
  final Map<int, Color> colors;

  _initSwatch() {
    surface00dp = colors[0]!;
    surface01dp = colors[1]!;
    surface02dp = colors[2]!;
    surface03dp = colors[3]!;
    surface04dp = colors[4]!;
    surface06dp = colors[5]!;
    surface08dp = colors[6]!;
    surface12dp = colors[7]!;
    surface16dp = colors[8]!;
    surface24dp = colors[9]!;

    foreground50 = colors[10]!;
    foreground100 = colors[11]!;
    foreground200 = colors[12]!;
    brandColor = colors[13]!;
  }

  /// Returns an element of the swatch table.
  Color? operator [](int index) => colors[index];

  /// The color used to generate this [SwatchDark]
  late Color seedColor;

  /// The color of this surface at 0dp.
  late Color surface00dp;

  /// The color of this surface at 1dp.
  late Color surface01dp;

  /// The color of this surface at 2dp.
  late Color surface02dp;

  /// The color of this surface at 3dp.
  late Color surface03dp;

  /// The color of this surface at 4dp.
  late Color surface04dp;

  /// The color of this surface at 5dp.
  late Color surface06dp;

  /// The color of this surface at 8dp.
  late Color surface08dp;

  /// The color of this surface at 12dp.
  late Color surface12dp;

  /// The color of this surface at 16dp.
  late Color surface16dp;

  /// The color of this surface at 24dp.
  late Color surface24dp;

  /// The lightest shade, besides white, that can be displayed
  /// over dark surfaces
  late Color foreground50;

  /// The second lightest, besides white, shade that can be displayed
  /// over dark surfaces
  late Color foreground100;

  /// The darkest shade that can be displayed over dark surfaces
  late Color foreground200;

  /// The brand color from the light theme. This color should not be used for
  /// text and all in all should be used sparingly.
  ///
  /// For text that complies with WCAG AA guidelines, use foreground50, 100,
  /// or 200 against any of the surface colors (0-24dp).
  late Color brandColor;

  /// Applies action to each key/value pair of the map.
  /// Calling action must not add or remove keys from the map.
  Function(Function(int key, Color value) action) forEach(
          Function(Color color) action) =>
      colors.forEach;

  /// Returns a new map where all colors of this [SwatchDark] are transformed by
  /// the given convert function.
  Map<K2, V2> Function<K2, V2>(
          MapEntry<K2, V2> Function(int key, Color value) convert)
      map() => colors.map;

  /// Returns the number of colors in this [SwatchDark]
  int length() => colors.length;

  /// Returns a list of all the shades in this swatch.
  toList() {
    return colors.values.toList();
  }

  SwatchDark(Swatch swatch) : colors = generateDarkPalette(swatch) {
    _initSwatch();
    seedColor = swatch.shade200;
    brandColor = swatch.shade500;
  }
}

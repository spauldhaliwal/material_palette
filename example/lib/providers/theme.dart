import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_palette/palette.dart';

class ThemeNotifier extends ChangeNotifier {
  void toggleTheme() {
    _lightMode = !_lightMode;
    notifyListeners();
  }

  void setColorHarmony(ColorHarmony harmony) {
    _harmony = harmony;
    notifyListeners();
  }

  bool _lightMode = true;
  bool get lightMode => _lightMode;

  ColorHarmony _harmony = ColorHarmony.monochromatic;
  ColorHarmony get harmony => _harmony;

  Color _themeColor = HexColor.fromHex('#6200ed');
  Color get themeColor => _themeColor;

  late Palette _monochromaticPalette = Palette(_themeColor);
  ComplementaryPalette get palette =>
      _monochromaticPalette.withComplementaryHarmony();

  late ComplementaryPalette _complementaryPalette =
      Palette(_themeColor).withComplementaryHarmony();
  ComplementaryPalette get complementaryPalette => _complementaryPalette;

  late AnalogousPalette _analogousPalette =
      Palette(_themeColor).withAnalogousHarmony();
  AnalogousPalette get analogousPalette => _analogousPalette;

  late Triadic60Palette _triadic60Palette =
      Palette(_themeColor).withTriadic60Harmony();
  Triadic60Palette get triadic60Palette => _triadic60Palette;

  late Triadic120Palette _triadic120Palette =
      Palette(_themeColor).withTriadic120Harmony();
  Triadic120Palette get triadic120Palette => _triadic120Palette;

  late TetradicPalette _tetradicPalette =
      Palette(_themeColor).withTetradicHarmony();
  TetradicPalette get tetradicPalette => _tetradicPalette;

  void nextColor({Color? seedColor}) {
    if (seedColor == null) {
      _themeColor =
          Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    } else {
      _themeColor = seedColor;
    }
    _monochromaticPalette = Palette(_themeColor);

    _complementaryPalette = _monochromaticPalette.withComplementaryHarmony();

    _analogousPalette = _monochromaticPalette.withAnalogousHarmony();

    _triadic60Palette = _monochromaticPalette.withTriadic60Harmony();

    _triadic120Palette = _monochromaticPalette.withTriadic120Harmony();

    _tetradicPalette = _monochromaticPalette.withTetradicHarmony();
    notifyListeners();
  }
}

final themeProvider = ChangeNotifierProvider((ref) => ThemeNotifier());

enum ColorHarmony {
  monochromatic,
  complementary,
  analogous,
  triadic60,
  triadic120,
  tetradic,
}

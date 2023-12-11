import 'package:material_palette/src/constants.dart';

class LCHColor {
  final double lightness;
  final double chroma;
  final double hue;
  final double alpha;

  const LCHColor(
    this.lightness,
    this.chroma,
    this.hue, {
    this.alpha = 1,
  })  : assert(lightness < double.maxFinite),
        assert(chroma < double.maxFinite),
        assert(hue >= 0),
        assert(hue <= 360),
        assert(alpha >= 0.0),
        assert(alpha <= 1.0);

  @override
  bool operator ==(other) {
    return other is LCHColor &&
        1e-4 > (lightness - other.lightness).abs() &&
        1e-4 > (chroma - other.chroma).abs() &&
        1e-4 > (hue - other.hue).abs() &&
        (alpha - other.alpha).abs() < ACCURACY;
  }

  @override
  int get hashCode =>
      lightness.hashCode + chroma.hashCode + alpha.hashCode ^ hue.hashCode;
}

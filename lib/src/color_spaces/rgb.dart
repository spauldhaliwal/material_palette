import 'package:material_palette/src/constants.dart';

class RGBColor {
  final double red;
  final double green;
  final double blue;
  final double alpha;

  RGBColor(
    this.red,
    this.green,
    this.blue, {
    this.alpha = 1,
  })  : assert(red >= 0.0),
        assert(red <= 1.0),
        assert(green >= 0.0),
        assert(green <= 1.0),
        assert(blue >= 0.0),
        assert(blue <= 1.0),
        assert(alpha >= 0.0),
        assert(alpha <= 1.0);

  @override
  bool operator ==(other) {
    return other is RGBColor &&
        (red - other.red).abs() < ACCURACY &&
        (green - other.green).abs() < ACCURACY &&
        (blue - other.blue).abs() < ACCURACY &&
        (alpha - other.alpha).abs() < ACCURACY;
  }

  @override
  int get hashCode =>
      red.hashCode + green.hashCode + alpha.hashCode ^ blue.hashCode;

  // toCSSValue() is never called
  String toCSSValue() {
    return ('rgba(' +
        (100 * red).toString() +
        '%, ' +
        (100 * green).toString() +
        '%, ' +
        (100 * blue).toString() +
        '%, ' +
        alpha.toString() +
        ')');
  }
}

import 'package:material_palette/src/constants.dart';

class LABColor {
  final double lightness;
  final double a;
  final double b;
  final double alpha;

  const LABColor(
    this.lightness,
    this.a,
    this.b, {
    this.alpha = 1,
  })  : assert(lightness < double.maxFinite),
        assert(alpha >= 0.0),
        assert(alpha <= 1.0);

  @override
  bool operator ==(other) {
    return other is LABColor &&
        1e-4 > (lightness - other.lightness).abs() &&
        1e-4 > (a - other.a).abs() &&
        1e-4 > (b - other.b).abs() &&
        (b - other.b).abs() < ACCURACY;
  }

  @override
  int get hashCode =>
      lightness.hashCode + a.hashCode + alpha.hashCode ^ b.hashCode;
}

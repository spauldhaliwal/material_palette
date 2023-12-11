class HSLColor {
  final double hue;
  final double saturation;
  final double lightness;
  final double alpha;

  const HSLColor(
    this.hue,
    this.saturation,
    this.lightness, {
    this.alpha = 1,
  })  : assert(alpha >= 0.0),
        assert(alpha <= 1.0),
        assert(saturation >= 0.0),
        assert(saturation <= 1.0),
        assert(lightness >= 0.0),
        assert(lightness <= 1.0),
        assert(hue >= 0),
        assert(hue <= 360);

  // rotate() is never called
  HSLColor rotate(double hueAdjustment) {
    return HSLColor(
      (hue + hueAdjustment + 360) % 360,
      saturation,
      lightness,
      alpha: alpha,
    );
  }

  // toCSSValue() is never called
  String toCSSValue() {
    return ('hsla(' +
        hue.toString() +
        ', ' +
        (100 * saturation).toString() +
        '%, ' +
        (100 * lightness).toString() +
        '%, ' +
        alpha.toString() +
        ')');
  }
}

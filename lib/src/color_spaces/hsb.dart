class HSBColor {
  final double hue;
  final double saturation;
  final double value;
  final double alpha;

  const HSBColor(
    this.hue,
    this.saturation,
    this.value, {
    this.alpha = 1,
  })  : assert(alpha >= 0.0),
        assert(alpha <= 1.0),
        assert(saturation >= 0.0),
        assert(saturation <= 1.0),
        assert(value >= 0.0),
        assert(value <= 1.0),
        assert(hue >= 0),
        assert(hue <= 360);
}

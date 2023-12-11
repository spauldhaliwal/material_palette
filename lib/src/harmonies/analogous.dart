// ignore_for_file: unused_element

part of material_palette;

/// A palette with an analogous harmony.
///
/// To create a palette with this harmony, instantiate a regular
/// [Palette] and call Palette().withComplementaryHarmony().
class AnalogousPalette extends Palette {
  final Swatch analogousSwatchA;
  final Swatch analogousSwatchB;

  AnalogousPalette._(Color seedColor)
      : analogousSwatchA = Swatch(
          hex2color(
            getAnalogousColorA(
              int2hex(seedColor.value),
            ),
          ),
        ),
        analogousSwatchB = Swatch(
          hex2color(
            getAnalogousColorB(
              int2hex(seedColor.value),
            ),
          ),
        ),
        super(seedColor);

  AnalogousPalette._fromPrimarySwatch(Swatch seedSwatch)
      : analogousSwatchA = Swatch(
          hex2color(
            getAnalogousColorA(
              int2hex(seedSwatch.seedColor.value),
            ),
          ),
        ),
        analogousSwatchB = Swatch(
          hex2color(
            getAnalogousColorB(
              int2hex(seedSwatch.seedColor.value),
            ),
          ),
        ),
        super._withSwatch(seedSwatch);
}

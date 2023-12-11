// ignore_for_file: unused_element

part of material_palette;

class SplitComplementaryPalette extends Palette {
  final Swatch splitComplementarySwatchA;
  final Swatch splitComplementarySwatchB;

  SplitComplementaryPalette._(Color seedColor)
      : splitComplementarySwatchA = Swatch(
          hex2color(
            getTriadicColorA(
              int2hex(seedColor.value),
            ),
          ),
        ),
        splitComplementarySwatchB = Swatch(
          hex2color(
            getTriadicColorB(
              int2hex(seedColor.value),
            ),
          ),
        ),
        super(seedColor);

  SplitComplementaryPalette._fromPrimarySwatch(Swatch seedSwatch)
      : splitComplementarySwatchA = Swatch(
          hex2color(
            getSplitComplementaryColorA(
              int2hex(seedSwatch.seedColor.value),
            ),
          ),
        ),
        splitComplementarySwatchB = Swatch(
          hex2color(
            getSplitComplementaryColorB(
              int2hex(seedSwatch.seedColor.value),
            ),
          ),
        ),
        super._withSwatch(seedSwatch);
}

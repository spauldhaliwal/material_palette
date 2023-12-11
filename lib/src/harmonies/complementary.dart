// ignore_for_file: unused_element

part of material_palette;

class ComplementaryPalette extends Palette {
  final Swatch complementarySwatch;

  ComplementaryPalette._(Color seedColor)
      : complementarySwatch = Swatch(
          hex2color(
            getComplementaryColor(
              int2hex(seedColor.value),
            ),
          ),
        ),
        super(seedColor);

  ComplementaryPalette._fromPrimarySwatch(Swatch seedSwatch)
      : complementarySwatch = Swatch(
          hex2color(
            getComplementaryColor(
              int2hex(seedSwatch.seedColor.value),
            ),
          ),
        ),
        super._withSwatch(seedSwatch);
}

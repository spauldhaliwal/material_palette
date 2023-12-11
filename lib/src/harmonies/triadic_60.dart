// ignore_for_file: unused_element

part of material_palette;

class Triadic60Palette extends Palette {
  final Swatch triadicSwatchA;
  final Swatch triadicSwatchB;

  Triadic60Palette._(Color seedColor)
      : triadicSwatchA = Swatch(
          hex2color(
            getTriadicColorA(
              int2hex(seedColor.value),
            ),
          ),
        ),
        triadicSwatchB = Swatch(
          hex2color(
            getTriadicColorB(
              int2hex(seedColor.value),
            ),
          ),
        ),
        super(seedColor);

  Triadic60Palette._fromPrimarySwatch(Swatch seedSwatch)
      : triadicSwatchA = Swatch(
          hex2color(
            getTriadicColorA(
              int2hex(seedSwatch.seedColor.value),
            ),
          ),
        ),
        triadicSwatchB = Swatch(
          hex2color(
            getTriadicColorB(
              int2hex(seedSwatch.seedColor.value),
            ),
          ),
        ),
        super._withSwatch(seedSwatch);
}

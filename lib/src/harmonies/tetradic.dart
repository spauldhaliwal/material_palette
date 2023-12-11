// ignore_for_file: unused_element

part of material_palette;

class TetradicPalette extends Palette {
  final Swatch tetradicSwatchA;
  final Swatch tetradicSwatchB;
  final Swatch tetradicSwatchC;

  TetradicPalette._(Color seedColor)
      : tetradicSwatchA = Swatch(
          hex2color(
            getTetradicColorA(
              int2hex(seedColor.value),
            ),
          ),
        ),
        tetradicSwatchB = Swatch(
          hex2color(
            getTetradicColorB(
              int2hex(seedColor.value),
            ),
          ),
        ),
        tetradicSwatchC = Swatch(
          hex2color(
            getTetradicColorC(
              int2hex(seedColor.value),
            ),
          ),
        ),
        super(seedColor);

  TetradicPalette._fromPrimarySwatch(Swatch seedSwatch)
      : tetradicSwatchA = Swatch(
          hex2color(
            getTetradicColorA(
              int2hex(seedSwatch.seedColor.value),
            ),
          ),
        ),
        tetradicSwatchB = Swatch(
          hex2color(
            getTetradicColorB(
              int2hex(seedSwatch.seedColor.value),
            ),
          ),
        ),
        tetradicSwatchC = Swatch(
          hex2color(
            getTetradicColorC(
              int2hex(seedSwatch.seedColor.value),
            ),
          ),
        ),
        super._withSwatch(seedSwatch);
}

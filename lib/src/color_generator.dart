import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:material_palette/palette.dart';
import 'package:material_palette/src/util.dart';

import 'color_spaces/hsl.dart';
import 'color_spaces/lab.dart';
import 'color_spaces/lch.dart';
import 'constants.dart';

Set<Object> findClosestGoldenPalette(labColor,
    {goldenPalettes = goldenPalettes}) {
  double minEmpfindungDifference = double.infinity;
  List<LABColor> closestGoldenPalette = goldenPalettes[0];
  int closestColorIndex = -1;
  for (var paletteIndex = 0;
      paletteIndex < goldenPalettes.length;
      paletteIndex++) {
    for (var colorIndex = 0;
        colorIndex < goldenPalettes[paletteIndex].length &&
            0 < minEmpfindungDifference;
        colorIndex++) {
      LABColor goldenColor = goldenPalettes[paletteIndex][colorIndex];
      double avgLightness = (goldenColor.lightness + labColor.lightness) / 2;
      double goldenColorChroma =
          sqrt(pow(goldenColor.a, 2) + pow(goldenColor.b, 2));
      double labColorChroma = sqrt(pow(labColor.a, 2) + pow(labColor.b, 2));
      double avgChroma = (goldenColorChroma + labColorChroma) / 2;

      double G = 0.5 *
          (1 - sqrt(pow(avgChroma, 7) / (pow(avgChroma, 7) + pow(25, 7))));

      double adjustedGoldenA = goldenColor.a * (1 + G);
      double adjustedLabA = labColor.a * (1 + G);
      double goldenColorAdjustedChroma =
          sqrt(pow(adjustedGoldenA, 2) + pow(goldenColor.b, 2));
      double labColorAdjustedChroma =
          sqrt(pow(adjustedLabA, 2) + pow(labColor.b, 2));

      double deltaAdjustedChroma =
          labColorAdjustedChroma - goldenColorAdjustedChroma;

      double avgAdjustedChroma =
          (goldenColorAdjustedChroma + labColorAdjustedChroma) / 2;

      double goldenColorModifiedHue = lab2hue(goldenColor.b, adjustedGoldenA);
      double labColorModifiedHue = lab2hue(labColor.b, adjustedLabA);
      num deltaHue = 2 *
          sqrt(goldenColorAdjustedChroma * labColorAdjustedChroma) *
          sin((1e-4 > goldenColorChroma.abs() || 1e-4 > labColorChroma.abs()
                  ? 0
                  : 180 >= (labColorModifiedHue - goldenColorModifiedHue).abs()
                      ? labColorModifiedHue - goldenColorModifiedHue
                      : labColorModifiedHue <= goldenColorModifiedHue
                          ? labColorModifiedHue - goldenColorModifiedHue + 360
                          : labColorModifiedHue -
                              goldenColorModifiedHue -
                              360) /
              2 *
              pi /
              180);

      double avgHue = 1e-4 > goldenColorChroma.abs() ||
              1e-4 > labColorChroma.abs()
          ? 0
          : 180 >= (labColorModifiedHue - goldenColorModifiedHue).abs()
              ? (goldenColorModifiedHue + labColorModifiedHue) / 2
              : 360 > goldenColorModifiedHue + labColorModifiedHue
                  ? (goldenColorModifiedHue + labColorModifiedHue + 360) / 2
                  : (goldenColorModifiedHue + labColorModifiedHue - 360) / 2;

      double chromaCompensation = 1 + 0.045 * avgAdjustedChroma;

      double hueCompensation = 1 +
          0.015 *
              avgAdjustedChroma *
              (1 -
                  0.17 * cos(((avgHue - 30) * pi) / 180) +
                  0.24 * cos((2 * avgHue * pi) / 180) +
                  0.32 * cos(((3 * avgHue + 6) * pi) / 180) -
                  0.2 * cos(((4 * avgHue - 63) * pi) / 180));

      double lightnessCompensation = 1 +
          (0.015 * pow(avgLightness - 50, 2)) /
              sqrt(20 + pow(avgLightness - 50, 2));

      double chromaRotation = 2 *
          sqrt(pow(avgAdjustedChroma, 7) /
              (pow(avgAdjustedChroma, 7) + pow(25, 7)));

      double deltaTheta = 30 * exp(-pow((avgHue - 275) / 25, 2));

      double hueRotation =
          -1 * chromaRotation * sin((2 * deltaTheta * pi) / 180);

      double empfindungDifference = sqrt(pow(
              (labColor.lightness - goldenColor.lightness) /
                  (lightnessCompensation),
              2) +
          pow(deltaAdjustedChroma / (1 * chromaCompensation), 2) +
          pow(deltaHue / hueCompensation, 2) +
          (deltaAdjustedChroma / chromaCompensation) *
              hueRotation *
              (deltaHue / hueCompensation));

      if (empfindungDifference < minEmpfindungDifference) {
        minEmpfindungDifference = empfindungDifference;
        closestGoldenPalette = goldenPalettes[paletteIndex];
        closestColorIndex = colorIndex;
      }
    }
  }
  return {closestGoldenPalette, closestColorIndex};
}

Map<int, Color> generatePalette(
  Color seedColor, {
  List<List<LABColor>> goldenPalettes = goldenPalettes,
  List<double> lightnessTolerance = defaultLightnessTolerance,
  List<double> chromaTolerance = defaultChromaTolerance,
}) {
  Color sourceRgbColor = seedColor;
  LABColor sourceLabColor = rgb2lab(hex2rgb(int2hex(seedColor.value)));

  List<LABColor> closestGoldenPalette =
      findClosestGoldenPalette(sourceLabColor, goldenPalettes: goldenPalettes)
          .elementAt(0) as List<LABColor>;

  int closestColorIndex =
      findClosestGoldenPalette(sourceLabColor, goldenPalettes: goldenPalettes)
          .elementAt(1) as int;

  LABColor closestGoldenLabColor = closestGoldenPalette[closestColorIndex];

  LCHColor closestGoldenLchColor = lab2lch(closestGoldenLabColor);

  LCHColor sourceLchColor = lab2lch(sourceLabColor);

  bool isGoldenColorGreyInMiddle = 30 > lab2lch(closestGoldenPalette[5]).chroma;

  double deltaGoldenLightness =
      closestGoldenLchColor.lightness - sourceLchColor.lightness;
  double deltaGoldenChroma =
      closestGoldenLchColor.chroma - sourceLchColor.chroma;
  double deltaGoldenHue = closestGoldenLchColor.hue - sourceLchColor.hue;
  int lightnessMinimumStep = 2;
  double lightnessMaximum = 100;

  Map<int, Color> generatedPalette = {};

  closestGoldenPalette.forEachIndexed((index, goldenLabColor) {
    if (goldenLabColor == closestGoldenLabColor) {
      lightnessMaximum = max(sourceLchColor.lightness - 1.7, 0);
      generatedPalette.putIfAbsent(index, () => sourceRgbColor);
      // generatedPalette.add(sourceRgbColor);
    }

    if (index == 10) {
      lightnessMaximum =
          100; // Restart maximum lightness when transitioning from color 900 to A100
    }

    LCHColor goldenLchColor = lab2lch(goldenLabColor);

    double lightness = min(
        max(
            min(
                goldenLabColor.lightness -
                    (lightnessTolerance[index] /
                            lightnessTolerance[closestColorIndex]) *
                        deltaGoldenLightness,
                lightnessMaximum),
            0),
        100); // Ensure lightness not lower than 0 and not greater than 100

    double chroma = max(
        0,
        isGoldenColorGreyInMiddle
            ? goldenLchColor.chroma - deltaGoldenChroma
            : goldenLchColor.chroma -
                deltaGoldenChroma *
                    min(
                        chromaTolerance[index] /
                            chromaTolerance[closestColorIndex],
                        1.25));

    double hue = (goldenLchColor.hue - deltaGoldenHue + 360) % 360;

    LCHColor lchColor = LCHColor(lightness, chroma, hue);

    lightnessMaximum = max(lchColor.lightness - lightnessMinimumStep, 0);

    generatedPalette.putIfAbsent(index, () => rgb2color(lch2rgb(lchColor)));
  });
  return generatedPalette;
}

/// Generates a dark swatch from regular swatch. As per Material Design
/// guidelines, dark swatches use the 200 shade as a base.
Map<int, Color> generateDarkPalette(Swatch swatch) {
  Map<int, Color> generatedDarkPalette = {};

  // Dark palettes use the 200 shade as a base.
  Color primaryColor = swatch.shade200;

  for (var index = 0; index <= 9; index++) {
    generatedDarkPalette.putIfAbsent(
      index,
      () => Color.alphaBlend(
          primaryColor.withOpacity(darkPaletteMixAlpha[index]),
          darkPaletteMixer),
    );
  }

  for (var index = 10; index <= 13; index++) {
    switch (index) {
      case 10:
        generatedDarkPalette.putIfAbsent(
          index,
          () => swatch.shade50,
        );
        break;
      case 11:
        generatedDarkPalette.putIfAbsent(
          index,
          () => swatch.shade100,
        );
        break;
      case 12:
        generatedDarkPalette.putIfAbsent(
          index,
          () => swatch.shade200,
        );
        break;
      case 13:
        generatedDarkPalette.putIfAbsent(
          index,
          () => swatch.shade500,
        );
        break;
    }
  }

  return generatedDarkPalette;
}

String getComplementaryColor(String seed) {
  HSLColor hslSeed = hex2Hsl(seed);
  HSLColor shiftedHSL = hslSeed.rotate(180);

  String shiftedHex = hsl2Hex(HSLColor(
    shiftedHSL.hue,
    shiftedHSL.saturation,
    shiftedHSL.lightness,
  ));
  return shiftedHex;
}

String getAnalogousColorA(String seed) {
  HSLColor hslSeed = hex2Hsl(seed);
  HSLColor shiftedHSL = hslSeed.rotate(-30);

  String shiftedHex = hsl2Hex(HSLColor(
    shiftedHSL.hue,
    shiftedHSL.saturation,
    shiftedHSL.lightness,
  ));
  return shiftedHex;
}

String getAnalogousColorB(String seed) {
  HSLColor hslSeed = hex2Hsl(seed);
  /**/
  HSLColor shiftedHSL = hslSeed.rotate(30);

  String shiftedHex = hsl2Hex(HSLColor(
    shiftedHSL.hue,
    shiftedHSL.saturation,
    shiftedHSL.lightness,
  ));
  return shiftedHex;
}

String getTriadicColorA(String seed) {
  HSLColor hslSeed = hex2Hsl(seed);
  HSLColor shiftedHSL = hslSeed.rotate(60);

  String shiftedHex = hsl2Hex(HSLColor(
    shiftedHSL.hue,
    shiftedHSL.saturation,
    shiftedHSL.lightness,
  ));
  return shiftedHex;
}

String getTriadicColorB(String seed) {
  return getTriadicColorA(getTriadicColorA(seed));
}

String getTriadic120(String seed) {
  HSLColor hslSeed = hex2Hsl(seed);
  HSLColor shiftedHSL = hslSeed.rotate(120);

  String shiftedHex = hsl2Hex(HSLColor(
    shiftedHSL.hue,
    shiftedHSL.saturation,
    shiftedHSL.lightness,
  ));
  return shiftedHex;
}

String getTriadic240(String seed) {
  return getTriadic120(
    getTriadic120(
      seed,
    ),
  );
}

double shiftHue(double hue, double shift) {
  double newHue = hue + shift;
  if (newHue >= 360) {
    return newHue - 360;
  } else {
    return newHue;
  }
}

String getSplitComplementaryColorA(String seed) {
  HSLColor hslSeed = hex2Hsl(seed);
  HSLColor shiftedHSL = hslSeed.rotate(150);

  String shiftedHex = hsl2Hex(HSLColor(
    shiftedHSL.hue,
    shiftedHSL.saturation,
    shiftedHSL.lightness,
  ));
  return shiftedHex;
}

String getSplitComplementaryColorB(String seed) {
  HSLColor hslSeed = hex2Hsl(seed);
  HSLColor shiftedHSL = hslSeed.rotate(210);

  String shiftedHex = hsl2Hex(HSLColor(
    shiftedHSL.hue,
    shiftedHSL.saturation,
    shiftedHSL.lightness,
  ));
  return shiftedHex;
}

String getTetradicColorA(String seed) {
  HSLColor hslSeed = hex2Hsl(seed);
  HSLColor shiftedHSL = hslSeed.rotate(90);

  String shiftedHex = hsl2Hex(HSLColor(
    shiftedHSL.hue,
    shiftedHSL.saturation,
    shiftedHSL.lightness,
  ));
  return shiftedHex;
}

String getTetradicColorB(String seed) {
  return getTetradicColorA(
    getTetradicColorA(
      seed,
    ),
  );
}

String getTetradicColorC(String seed) {
  return getTetradicColorA(
    getTetradicColorB(
      seed,
    ),
  );
}

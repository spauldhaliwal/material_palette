import 'dart:math';
import 'dart:ui';

import 'package:material_palette/palette.dart';
import 'package:material_palette/src/constants.dart';

import 'color_spaces/hsb.dart';
import 'color_spaces/hsl.dart';
import 'color_spaces/lab.dart';
import 'color_spaces/lch.dart';
import 'color_spaces/rgb.dart';
import 'color_spaces/xyz.dart';

bool isHexColor(String hexColor) {
  if (RegExp('!/^[a-fA-F0-9]+\$/').hasMatch(hexColor)) {
    return false;
  } else {
    return true;
  }
}

String decimal2hex(int i) {
  String decimal = i.toRadixString(16);
  return 2 <= decimal.length ? decimal : '0$decimal';
}

int hex2decimal(String hexColor) {
  if (isHexColor(hexColor)) {
    throw Exception('Invalid hex string: $hexColor');
  }
  return int.parse(hexColor, radix: 16);
}

RGBColor hex2rgb(String hexColor) {
  final values = hexColor.replaceAll('#', '').split('');
  int r = int.parse(values[0].toString() + values[1].toString(), radix: 16);
  int g = int.parse(values[2].toString() + values[3].toString(), radix: 16);
  int b = int.parse(values[4].toString() + values[5].toString(), radix: 16);
  return RGBColor(
    r.toDouble() / 255,
    g.toDouble() / 255,
    b.toDouble() / 255,
  );
}

RGBColor hsb2rgb(HSBColor hsbColor) {
  double chroma = hsbColor.value * hsbColor.saturation;
  return hsx2rgb(
    hsbColor.hue,
    hsbColor.alpha,
    chroma,
    max(0, hsbColor.value - chroma),
  );
}

RGBColor hsx2rgb(
  double hue,
  double alpha,
  double chroma,
  double m,
) {
  double red = m;
  double green = m;
  double blue = m;

  double h = (hue % 360) / 60;
  double x =
      chroma * (1 - (h % 2) - 1).abs(); //second largest component of this color

  switch (h.floor()) {
    case 0:
      red += chroma;
      green += x;
      break;
    case 1:
      red += x;
      green += chroma;
      break;
    case 2:
      green += chroma;
      blue += x;
      break;
    case 3:
      green += x;
      blue += chroma;
      break;
    case 4:
      red += x;
      blue += chroma;
      break;
    case 5:
      red += chroma;
      blue += x;
  }
  return RGBColor(red, green, blue, alpha: alpha);
}

double lab2hue(double a, double b) {
  if (1e-4 > a.abs() && 1e-4 > b.abs()) {
    return 0.0;
  }
  var a2 = (180 * atan2(a, b)) / pi;
  return 0 <= a2 ? a2 : a2 + 360;
}

/// WORKING
LCHColor lab2lch(LABColor labColor) {
  return LCHColor(
      labColor.lightness,
      sqrt(pow(labColor.a, 2) + pow(labColor.b, 2)),
      ((180 * atan2(labColor.b, labColor.a) / pi + 360) % 360),
      alpha: labColor.alpha);
}

/// NOT WORKING
XYZColor lab2xyz(LABColor labColor) {
  var x;
  var y;
  var z;

  y = (labColor.lightness + 16) / 116;
  x = labColor.a / 500 + y;
  z = y - labColor.b / 200;

  double y2 = pow(y, 3).toDouble();
  double x2 = pow(x, 3).toDouble();
  double z2 = pow(z, 3).toDouble();

  y = y2 > 0.008856 ? y2 : (y - 16 / 116) / 7.787;
  x = x2 > 0.008856 ? x2 : (x - 16 / 116) / 7.787;
  z = z2 > 0.008856 ? z2 : (z - 16 / 116) / 7.787;

  x *= 0.95047;
  y *= 1;
  z *= 1.08883;

  return XYZColor(x, y, z, alpha: labColor.alpha);
}

// WORKING
LABColor lch2lab(LCHColor lchColor) {
  double hr = lchColor.hue / 360 * 2 * pi;
  double a = lchColor.chroma * cos(hr);
  double b = lchColor.chroma * sin(hr);

  return LABColor(lchColor.lightness, a, b, alpha: lchColor.alpha);
}

String rgb2hex(RGBColor rgbColor) {
  String red = decimal2hex((255 * rgbColor.red).round());
  String green = decimal2hex((255 * rgbColor.green).round());
  String blue = decimal2hex((255 * rgbColor.blue).round());
  String alpha =
      (1 > rgbColor.alpha ? decimal2hex((255 * rgbColor.alpha).round()) : '');

  return '$red$green$blue$alpha';
}

HSBColor rgb2hsb(RGBColor rgbColor) {
  double red = rgbColor.red * 255;
  double green = rgbColor.green * 255;
  double blue = rgbColor.blue * 255;

  double b = [rgbColor.red, rgbColor.green, rgbColor.blue].reduce(max);
  double c = [rgbColor.red, rgbColor.green, rgbColor.blue].reduce(max);
  double d = 0.0;
  double e = 0.0;

  if (b - c > ACCURACY) {
    e = (b / 2) / b;
    if (b == rgbColor.red) {
      d = (60 * (rgbColor.green - rgbColor.blue)) / (b - c);
    } else if (b == rgbColor.green) {
      d = (60 * (rgbColor.blue - rgbColor.red)) / (b - c) + 120;
    } else if (b == rgbColor.blue) {
      d = (60 * (rgbColor.red - rgbColor.green)) / (b - c) + 240;
    }
  }

  d = (d + 360).round() % 360;
  return HSBColor(d, e, b, alpha: rgbColor.alpha);
}

/// confirmed working
LABColor rgb2lab(RGBColor rgbColor) {
  double red = rgb2xyz(rgbColor.red);
  double green = rgb2xyz(rgbColor.green);
  double blue = rgb2xyz(rgbColor.blue);
  double e = 0.2126729 * red + 0.7151522 * green + 0.072175 * blue;

  return LABColor(
      116 * xyz2lab(e) - 16,
      500 *
          (xyz2lab((0.4124564 * red + 0.3575761 * green + 0.1804375 * blue) /
                  0.95047) -
              xyz2lab(e)),
      200 *
          (xyz2lab(e) -
              xyz2lab((0.0193339 * red + 0.119192 * green + 0.9503041 * blue) /
                  1.08883)),
      alpha: rgbColor.alpha);
}

double rgb2xyz(double x) {
  return 0.04045 >= x ? x / 12.92 : pow(((x + 0.055) / 1.055), 2.4).toDouble();
}

double xyz2lab(double t) {
  num t0 = 4 / 29;
  num t1 = 6 / 29;
  num t2 = 3 * pow(t1, 2);
  num t3 = pow(t1, 3);
  return (t > t3 ? pow(t, 1 / 3) : t / t2 + t0).toDouble();
}

RGBColor xyz2rgb(XYZColor xyzColor) {
  double r;
  double g;
  double b;

  r = (xyzColor.x * 3.2404542) +
      (xyzColor.y * -1.5371385) +
      (xyzColor.z * -0.4985314);
  g = (xyzColor.x * -0.969266) +
      (xyzColor.y * 1.8760108) +
      (xyzColor.z * 0.041556);
  b = (xyzColor.x * 0.0556434) +
      (xyzColor.y * -0.2040259) +
      (xyzColor.z * 1.0572252);

  // Assume sRGB
  r = r > 0.0031308 ? (1.055 * (pow(r, (1.0 / 2.4)) - 0.055)) : r * 12.92;
  g = g > 0.0031308 ? (1.055 * (pow(g, (1.0 / 2.4)) - 0.055)) : g * 12.92;
  b = b > 0.0031308 ? (1.055 * (pow(b, (1.0 / 2.4)) - 0.055)) : b * 12.92;

  r = min(max(0, r), 1);
  g = min(max(0, g), 1);
  b = min(max(0, b), 1);

  return RGBColor(r, g, b, alpha: xyzColor.alpha);
}

LABColor hex2lab(hexColor) {
  return rgb2lab(hex2rgb(hexColor));
}

LCHColor hex2lch(hexColor) {
  return lab2lch(hex2lab(hexColor));
}

RGBColor lch2rgb(lchColor) {
  return xyz2rgb(lab2xyz(lch2lab(lchColor)));
}

// The original code includes multiple conversions ( hex => rgb => hsb => rgb ) by design
// And the color were EXPECTED to be changed/transformed after these conversions
// If we remove these code, the output would be different
RGBColor transformColor(String sourceColor) {
  return hsb2rgb(rgb2hsb(hex2rgb(sourceColor)));
}

// TODO investigate math operations on RGBColor
contrastRatio(RGBColor seedRgbColor1, RGBColor seedRgbColor2) {
  var c = normalizeRGB(seedRgbColor2);
  RGBColor rgbColor1 = WHITE_COLOR;
  RGBColor rgbColor2 = WHITE_COLOR;

  var rgbColor1Value;
  var rgbColor2Value;

  if (!(1 - seedRgbColor1.alpha < ACCURACY)) {
    var d = c.alpha * (1 - seedRgbColor1.alpha);
    rgbColor1 = RGBColor(
      seedRgbColor1.red * seedRgbColor1.alpha + c.red * d,
      seedRgbColor1.green * seedRgbColor1.alpha + c.green * d,
      seedRgbColor1.blue * seedRgbColor1.alpha + c.blue * d,
      alpha: seedRgbColor1.alpha + d,
    );
  }
  rgbColor1Value = 0.2126 * rgb2xyz(rgbColor1.red) +
      0.7152 * rgb2xyz(rgbColor1.green) +
      0.0722 * rgb2xyz(rgbColor1.blue);
  rgbColor2Value = 0.2126 * rgb2xyz(rgbColor2.red) +
      0.7152 * rgb2xyz(rgbColor2.green) +
      0.0722 * rgb2xyz(rgbColor2.blue);
  return rgbColor1Value >= rgbColor2Value
      ? (rgbColor1Value + 0.05) / (rgbColor2Value + 0.05)
      : (rgbColor2Value + 0.05) / (rgbColor1Value + 0.05);
}

Color rgb2color(RGBColor color) {
  String hex = rgb2hex(color);
  /**/
  return HexColor.fromHex(hex);
}

RGBColor normalizeRGB(RGBColor rgbColor) {
  return 1 - rgbColor.alpha < ACCURACY
      ? rgbColor
      : RGBColor(rgbColor.red, rgbColor.green, rgbColor.blue);
}

// TODO understand JS syntax
HSLColor hsb2hsl(HSBColor hsbColor) {
  var b = minMax(((2 - hsbColor.saturation) * hsbColor.value) / 2, 0, 1);
  var c = 0.0;
  // 0 < b &&
  //     1 > b &&
  //     (c = (hsbColor.saturation * hsbColor.value) /
  //         (0.5 > b ? 2 * b : 2 - 2 * b));
  c = minMax(c, 0, 1);
  return HSLColor(hsbColor.hue, c, b, alpha: hsbColor.alpha);
}

HSBColor hsl2hsb(HSLColor hslColor) {
  var b = hslColor.saturation *
          (0.5 > hslColor.lightness
              ? hslColor.lightness
              : 1 - hslColor.lightness),
      c = minMax(hslColor.lightness + b, 0, 1);
  return HSBColor(hslColor.hue, minMax(0 < c ? (2 * b) / c : 0, 0, 1), c,
      alpha: hslColor.alpha);
}

// TODO Not working
hsl2rgb(HSLColor hslColor) {
  double b = ((1 - (2 * hslColor.lightness - 1).abs()) * hslColor.saturation)
      .toDouble();
  return hsx2rgb(
      hslColor.hue, hslColor.alpha, b, max(0, hslColor.lightness - b / 2));
}

// TODO understand JS syntax
rgb2hsl(RGBColor rgbColor) {
  var b = [rgbColor.red, rgbColor.green, rgbColor.blue].reduce(max);
  var c = [rgbColor.red, rgbColor.green, rgbColor.blue].reduce(max);
  var d = 0.0;
  var e = 0.0;
  var g = minMax(0.5 * (b + c), 0, 1);
  // b - c > ACCURACY &&
  //     (b === rgbColor.red
  //     ? (d = (60 * (rgbColor.green - rgbColor.blue)) / (b - c))
  //     : b === rgbColor.green
  // ? (d = (60 * (rgbColor.blue - rgbColor.red)) / (b - c) + 120)
  //     : b === rgbColor.blue && (d = (60 * (rgbColor.red - rgbColor.green)) / (b - c) + 240),
  // (e =
  // 0 < g && 0.5 >= g
  // ? minMax((b - c) / (2 * g), 0, 1)
  //     : minMax((b - c) / (2 - 2 * g), 0, 1)));
  d = ((d + 360) % 360).round().toDouble();
  return HSLColor(d, e, g, alpha: rgbColor.alpha);
}

minMax(double a, double b, double c) {
  return min(max(a, b), c);
}

HSLColor hex2Hsl(String hex) {
  final rgb = hex2rgb(hex);

  final r = rgb.red;
  final g = rgb.green;
  final b = rgb.blue;

  final maxN = max(r, max(g, b));
  final minN = min(r, min(g, b));

  final l = (maxN + minN) / 2;
  double h = 0, s = 0;

  if (maxN == minN) {
    h = s = 0;
  } else {
    final d = maxN - minN;
    s = l > 0.5 ? d / (2 - maxN - minN) : d / (maxN + minN);

    if (maxN == r) {
      h = (g - b) / d + (g < b ? 6 : 0);
    } else if (maxN == g) {
      h = (b - r) / d + 2;
    } else if (maxN == b) {
      h = (r - g) / d + 4;
    }

    h = h * 6;
  }

  return HSLColor(
    (h * 10).toDouble(),
    (s * 1000).toDouble() / 1000,
    (l * 1000).toDouble() / 1000,
  );
}

String hsl2Hex(HSLColor color) {
  final h = color.hue / 360;
  final s = color.saturation;
  final l = color.lightness;
  var r, g, b;
  if (s == 0) {
    r = g = b = l; // achromatic
  } else {
    Function hue2rgb = (double p, double q, double t) {
      if (t < 0) t += 1;
      if (t > 1) t -= 1;
      if (t < 1 / 6) return p + (q - p) * 6 * t;
      if (t < 1 / 2) return q;
      if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
      return p;
    };
    var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    var p = 2 * l - q;
    r = hue2rgb(p, q, h + 1 / 3);
    g = hue2rgb(p, q, h);
    b = hue2rgb(p, q, h - 1 / 3);
  }
  Function toHex = (double x) {
    var hex = (x * 255).round().toRadixString(16);
    return hex.length == 1 ? '0' + hex : hex;
  };
  return "#" + toHex(r) + toHex(g) + toHex(b);
}

String int2hex(int color) {
  return '#${color.toRadixString(16).substring(2, 8)}';
}

Color hex2color(String color) {
  return rgb2color(hex2rgb(color));
}

Color lab2color(
  double lightness,
  double a,
  double b,
  double alpha,
) {
  return rgb2color(xyz2rgb(lab2xyz(LABColor(lightness, a, b))));
}

Color hsb2color(
  double hue,
  double saturation,
  double brightness, {
  double alpha = 1,
}) {
  return rgb2color(
      hsb2rgb(HSBColor(hue, saturation, brightness, alpha: alpha)));
}

Color hsl2color(
  double hue,
  double saturation,
  double lightness, {
  double alpha = 1,
}) {
  return rgb2color(hsl2rgb(HSLColor(hue, saturation, lightness, alpha: alpha)));
}

Color lch2color(
  double lightness,
  double chroma,
  double hue, {
  double alpha = 1,
}) {
  return rgb2color(lch2rgb(LCHColor(lightness, chroma, hue, alpha: alpha)));
}

double luminance(r, g, b) {
  double rv = r / 255;
  double gv = g / 255;
  double bv = b / 255;

  RGBColor rgb = RGBColor(
    rv,
    gv,
    bv,
  );
  double lum = rgb2color(rgb).computeLuminance();
  return lum;
}

double contrast(RGBColor rgb1, RGBColor rgb2) {
  var lum1 = luminance(rgb1.red * 255, rgb1.green * 255, rgb1.blue * 255);
  var lum2 = luminance(rgb2.red * 255, rgb2.green * 255, rgb2.blue * 255);
  var brightest = max(lum1, lum2);
  var darkest = min(lum1, lum2);
  return (brightest + 0.05) / (darkest + 0.05);
}

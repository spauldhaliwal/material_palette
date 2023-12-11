import 'package:flutter/material.dart';
import 'package:material_palette/palette.dart';

Color colorOrDarkerOverWhite(Swatch swatch) {
  if (swatch.shade500.foregroundColor() == Colors.white) {
    return swatch.shade500;
  } else {
    return Colors.white.foregroundColors(swatch).light;
  }
}

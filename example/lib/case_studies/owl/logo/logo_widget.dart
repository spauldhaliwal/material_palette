import 'package:example/case_studies/owl/logo/logo_full.dart';
import 'package:example/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_palette/palette.dart';

class Logo extends ConsumerStatefulWidget {
  const Logo({
    Key? key,
    required this.logoSize,
  }) : super(key: key);

  final double logoSize;

  @override
  ConsumerState<Logo> createState() => _LogoState();
}

class _LogoState extends ConsumerState<Logo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(
              widget.logoSize,
              widget.logoSize /
                  2), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: OwlLogoFull(
            const Color(0xfff6bb00),
            const Color(0xffff0366),
            logoLetteringColor(),
            beakStroke: logoStrokeColor(),
            bodyStroke: logoStrokeColor(),
            strokeWidth: 4,
          ),
        ),
      ],
    );
  }

  Color logoStrokeColor() {
    ThemeNotifier theme = ref.watch(themeProvider);

    return theme.lightMode
        ? theme.palette.primarySwatch.shade500
                    .contrastRatio(const Color(0xfff6bb00)) <
                3
            ? theme.palette.primarySwatch.shade500.foregroundColor()
            : Colors.transparent
        : Colors.transparent;
  }

  Color logoBeakColor() {
    ThemeNotifier theme = ref.watch(themeProvider);
    return theme.lightMode
        ? theme.palette.primarySwatch.shade500
            .foregroundColorsXL(Palette(const Color(0xfff6bb00)).primarySwatch)
            .light
        : theme.palette.primarySwatch.dark.surface00dp
            .foregroundColorsXL(Palette(const Color(0xfff6bb00)).primarySwatch)
            .light;
  }

  Color logoLetteringColor() {
    ThemeNotifier theme = ref.watch(themeProvider);
    switch (theme.harmony) {
      case ColorHarmony.tetradic:
        return theme.lightMode
            ? theme.tetradicPalette.primarySwatch.shade500
                .foregroundColors(theme.tetradicPalette.tetradicSwatchC)
                .dark
            : theme.tetradicPalette.primarySwatch.dark.surface00dp
                .foregroundColors(theme.tetradicPalette.tetradicSwatchC)
                .dark;
      default:
        return theme.lightMode
            ? theme.palette.primarySwatch.shade500.foregroundColor()
            : Colors.white;
    }
  }
}

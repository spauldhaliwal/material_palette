import 'package:example/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/palette.dart';
import 'package:nil/nil.dart';

class SwatchScreen extends ConsumerStatefulWidget {
  const SwatchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SwatchScreen> createState() => _SwatchScreenState();
}

class _SwatchScreenState extends ConsumerState<SwatchScreen> {
  String _seedColor = '#344955';

  final double _fabSize = 65;

  @override
  Widget build(BuildContext context) {
    ThemeNotifier theme = ref.watch(themeProvider);
    _seedColor = theme.themeColor.toHex();

    ComplementaryPalette palette =
        Palette.fromHex(_seedColor).withComplementaryHarmony();

    AnalogousPalette analogousPalette =
        Palette.fromHex(_seedColor).withAnalogousHarmony();

    Triadic60Palette triadic60palette =
        Palette.fromHex(_seedColor).withTriadic60Harmony();

    Triadic120Palette triadic120palette =
        Palette.fromHex(_seedColor).withTriadic120Harmony();

    SplitComplementaryPalette splitComplementaryPalette =
        Palette.fromHex(_seedColor).withSplitComplementaryHarmony();

    TetradicPalette tetradicPalette =
        Palette.fromHex(_seedColor).withTetradicHarmony();

    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: RepaintBoundary(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("PRIMARY"),
              ),
              const SizedBox(height: 10),
              SwatchWidget(
                palette.primarySwatch,
                palette.primarySwatch,
                palette.primarySwatch.seedColor,
                label: 'P',
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("COMPLEMENTARY"),
              ),
              const SizedBox(height: 10),
              SwatchWidget(
                palette.complementarySwatch,
                palette.primarySwatch,
                palette.complementarySwatch.seedColor,
                label: 'C',
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("ANALOGOUS"),
              ),
              const SizedBox(height: 10),
              SwatchWidget(
                  analogousPalette.analogousSwatchA,
                  palette.primarySwatch,
                  analogousPalette.analogousSwatchA.seedColor,
                  showRange: false,
                  label: 'A\u00B9'),
              const SizedBox(height: 2),
              SwatchWidget(
                  analogousPalette.analogousSwatchB,
                  palette.primarySwatch,
                  analogousPalette.analogousSwatchB.seedColor,
                  label: 'A\u00B2'),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("TRIADIC 60"),
              ),
              const SizedBox(height: 10),
              SwatchWidget(
                  triadic60palette.triadicSwatchA,
                  palette.primarySwatch,
                  triadic60palette.triadicSwatchA.seedColor,
                  showRange: false,
                  label: 'T\u00B9'),
              const SizedBox(height: 2),
              SwatchWidget(
                  triadic60palette.triadicSwatchB,
                  palette.primarySwatch,
                  triadic60palette.triadicSwatchB.seedColor,
                  label: 'T\u00B2'),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("TRIADIC 120"),
              ),
              const SizedBox(height: 10),
              SwatchWidget(
                  triadic120palette.triadicSwatchA,
                  palette.primarySwatch,
                  triadic120palette.triadicSwatchA.seedColor,
                  showRange: false,
                  label: 'T\u00B2'),
              const SizedBox(height: 2),
              SwatchWidget(
                  triadic120palette.triadicSwatchB,
                  palette.primarySwatch,
                  triadic120palette.triadicSwatchB.seedColor,
                  showRange: true,
                  label: 'T\u00B9'),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("SPLIT COMPLEMENTARY"),
              ),
              const SizedBox(height: 10),
              SwatchWidget(
                  splitComplementaryPalette.splitComplementarySwatchA,
                  palette.primarySwatch,
                  splitComplementaryPalette.splitComplementarySwatchA.seedColor,
                  showRange: false,
                  label: 'S\u00B9'),
              const SizedBox(height: 2),
              SwatchWidget(
                  splitComplementaryPalette.splitComplementarySwatchB,
                  palette.primarySwatch,
                  splitComplementaryPalette.splitComplementarySwatchB.seedColor,
                  label: 'S\u00B9'),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("TETRADIC"),
              ),
              const SizedBox(height: 10),
              SwatchWidget(
                  tetradicPalette.tetradicSwatchA,
                  palette.primarySwatch,
                  tetradicPalette.tetradicSwatchA.seedColor,
                  showRange: false,
                  label: 'T\u00B9'),
              const SizedBox(height: 2),
              SwatchWidget(
                  tetradicPalette.tetradicSwatchB,
                  palette.primarySwatch,
                  tetradicPalette.tetradicSwatchB.seedColor,
                  showRange: false,
                  label: 'T\u00B9'),
              const SizedBox(height: 2),
              SwatchWidget(
                  tetradicPalette.tetradicSwatchC,
                  palette.primarySwatch,
                  tetradicPalette.tetradicSwatchC.seedColor,
                  showRange: true,
                  label: 'T\u00B9'),
              SizedBox(
                  height:
                      MediaQuery.of(context).padding.bottom + _fabSize * 1.5)
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: _fabSize,
        height: _fabSize,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              ref.read(themeProvider).nextColor();
            },
            backgroundColor: HexColor.fromHex(_seedColor),
            child: Icon(
              Icons.color_lens,
              color: HexColor.fromHex(_seedColor).foregroundColor(),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    ThemeNotifier theme = ref.watch(themeProvider);
    Palette monochromaticPalette = theme.palette;
    return AppBar(
      systemOverlayStyle: _appBarOverlayStyle(),
      foregroundColor:
          monochromaticPalette.primarySwatch.shade500.foregroundColor(),
      backgroundColor: monochromaticPalette.primarySwatch.shade500,
      title: const Text(
        'Swatches',
        textAlign: TextAlign.start,
      ),
      leading: InkWell(
        borderRadius: BorderRadius.circular(
          10000,
        ),
        onTap: () {
          context.go('/');
        },
        child: const Center(
            child: Icon(
          Icons.navigate_before,
        )),
      ),
    );
  }

  SystemUiOverlayStyle _appBarOverlayStyle() {
    Swatch appSwatch = ref.watch(themeProvider).palette.primarySwatch;
    return appSwatch.shade500.foregroundColor() == Colors.white
        ? SystemUiOverlayStyle.light
            .copyWith(systemNavigationBarColor: appSwatch.shade500)
        : SystemUiOverlayStyle.dark
      ..copyWith(systemNavigationBarColor: appSwatch.shade500);
  }
}

class SwatchWidget extends StatefulWidget {
  const SwatchWidget(
    this.swatch,
    this.seedSwatch,
    this.seedRGB, {
    this.showRange = true,
    this.label = 'P',
    Key? key,
  }) : super(key: key);

  final Swatch swatch;
  final Swatch seedSwatch;
  final Color seedRGB;
  final bool showRange;
  final String label;

  @override
  State<SwatchWidget> createState() => _SwatchWidgetState();
}

class _SwatchWidgetState extends State<SwatchWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (int i = widget.swatch.length() - 1; i >= 0; i--)
              Expanded(
                child: Column(
                  children: [
                    AnimatedContainer(
                      height: 75,
                      width: double.infinity,
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: widget.swatch[i],
                        border: Border.symmetric(
                          vertical: BorderSide(
                              color: widget.seedRGB == widget.swatch[i]
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2),
                        ),
                      ),
                      child: widget.seedRGB == widget.swatch[i]
                          ? Center(
                              child: Text(
                                widget.label,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.roboto().fontFamily,
                                  fontSize: 20,
                                  color: widget.swatch[i]!
                                      .foregroundColors(widget.swatch)
                                      .light,
                                ),
                              ),
                            )
                          : nil,
                    ),
                    widget.showRange
                        ? Text(
                            getTonalValue(i),
                            style: TextStyle(
                              fontFamily: GoogleFonts.roboto().fontFamily,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class SwatchDarkWidget extends StatefulWidget {
  const SwatchDarkWidget(
    this.swatch,
    this.seedRGB, {
    this.showRange = true,
    this.label = 'P',
    Key? key,
  }) : super(key: key);

  final SwatchDark swatch;
  final Color seedRGB;
  final bool showRange;
  final String label;

  @override
  State<SwatchDarkWidget> createState() => _SwatchDarkWidgetState();
}

class _SwatchDarkWidgetState extends State<SwatchDarkWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (int i = 0; i <= widget.swatch.length() - 2; i++)
              Expanded(
                child: Column(
                  children: [
                    AnimatedContainer(
                      height: 75,
                      width: double.infinity,
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: widget.swatch[i],
                        border: Border.symmetric(
                          vertical: BorderSide(
                              color: widget.seedRGB == widget.swatch[i]
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2),
                        ),
                      ),
                      child: widget.seedRGB == widget.swatch[i]
                          ? Center(
                              child: Text(
                                widget.label,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.roboto().fontFamily,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          : nil,
                    ),
                    widget.showRange
                        ? Text(
                            getElevationValue(i),
                            style: TextStyle(
                              fontFamily: GoogleFonts.roboto().fontFamily,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

String getTonalValue(int index) {
  switch (index) {
    case 9:
      {
        return "900";
      }
    case 8:
      {
        return "800";
      }
    case 7:
      {
        return "700";
      }
    case 6:
      {
        return "600";
      }
    case 5:
      {
        return "500";
      }
    case 4:
      {
        return "400";
      }
    case 3:
      {
        return "300";
      }
    case 2:
      {
        return "200";
      }
    case 1:
      {
        return "100";
      }
    case 0:
      {
        return "50";
      }
    default:
      {
        return "900";
      }
  }
}

String getElevationValue(int index) {
  switch (index) {
    case 13:
      {
        return "B";
      }
    case 12:
      {
        return "200";
      }
    case 11:
      {
        return "100";
      }
    case 10:
      {
        return "50";
      }
    case 9:
      {
        return "24";
      }
    case 8:
      {
        return "16";
      }
    case 7:
      {
        return "12";
      }
    case 6:
      {
        return "08";
      }
    case 5:
      {
        return "06";
      }
    case 4:
      {
        return "04";
      }
    case 3:
      {
        return "03";
      }
    case 2:
      {
        return "02";
      }
    case 1:
      {
        return "01";
      }
    case 0:
      {
        return "00";
      }
    default:
      {
        return "00";
      }
  }
}

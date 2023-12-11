import 'dart:ui';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:example/providers/data.dart';
import 'package:example/providers/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_palette/palette.dart';

class Analytics extends ConsumerStatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends ConsumerState<Analytics>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _lightMode = true;

  static const double cardRadius = 6;
  Widget getSnackBar() {
    Palette palette = ref.watch(themeProvider).palette;
    return SnackBar(
      content: const Text(
        'User data saved.',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      duration: const Duration(days: 365),
      backgroundColor: _lightMode
          ? Colors.grey.shade900
          : palette.primarySwatch.dark.surface24dp,
      action: SnackBarAction(
        label: 'DISMISS',
        textColor: _lightMode
            ? palette.primarySwatch.dark.surface24dp
                .foregroundColors(palette.primarySwatch)
                .dark
            : Colors.grey.shade900.foregroundColors(palette.primarySwatch).dark,
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _lightMode = ref.watch(themeProvider).lightMode;
    ThemeNotifier theme = ref.watch(themeProvider);
    Palette monochromaticPalette = theme.palette;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: RepaintBoundary(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                top: 24,
                bottom: 12,
              ),
              child: Text(
                'Weekly stats',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  color: _lightMode
                      ? Colors.black
                      : monochromaticPalette.primarySwatch.dark.foreground50,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8, bottom: 8, right: 4),
                    child: Wrap(
                      runSpacing: 8,
                      children: [
                        _marketingCard(monochromaticPalette),
                        _reachCardSpark(monochromaticPalette),
                        _usersCard(monochromaticPalette),
                        _sessionsCard(monochromaticPalette),
                        _pageViewsCard(monochromaticPalette),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 4, bottom: 8, right: 8),
                    child: Wrap(
                      runSpacing: 8,
                      children: [
                        _conversionCardBar(monochromaticPalette),
                        _salesCard(monochromaticPalette),
                        _averageSessionCard(monochromaticPalette),
                        _bounceRateCard(monochromaticPalette),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 125),
          ],
        ),
      ),
    );
  }

  Material _marketingCard(Palette palette) {
    return _card(
      palette,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marketing',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '123.4 M',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: _lightMode
                      ? Colors.grey.shade900
                      : palette.primarySwatch.dark.foreground50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material _conversionCardBar(Palette palette) {
    return _card(
      palette,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Conversion',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
              const SizedBox(height: 12),
              Consumer(builder: (context, ref, child) {
                double _conversionNo = ref.watch(dataProvider).conversionNo;
                return _animatedTicker(
                  _conversionNo.toDouble(),
                  TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: _lightMode
                        ? Colors.grey.shade900
                        : palette.primarySwatch.dark.foreground50,
                  ),
                );
              }),
              const SizedBox(height: 12),
              Consumer(builder: (
                context,
                red,
                child,
              ) {
                int _conversionNoPercentage =
                    ref.watch(dataProvider).conversionPercentage;
                return _animatedTicker(
                  _conversionNoPercentage.toDouble(),
                  TextStyle(
                    fontSize: 18,
                    color: _getChartSecondColor(),
                  ),
                  prefix: '+',
                  suffix: '% of target',
                );
              }),
              const SizedBox(height: 24),
              _barChart(palette)
            ],
          ),
        ),
      ),
    );
  }

  Widget _animatedTicker(
    double number,
    TextStyle textStyle, {
    int decimals = 0,
    String prefix = '',
    String suffix = '',
  }) {
    return AnimatedFlipCounter(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      value: number,
      fractionDigits: decimals,
      prefix: prefix,
      suffix: suffix,
      textStyle: textStyle,
    );
  }

  Material _reachCardSpark(Palette palette) {
    return _card(
      palette,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: double.infinity,
          child: Consumer(builder: (context, ref, widget) {
            double reach = ref.watch(dataProvider).reachNo;
            double reachPercentage = ref.watch(dataProvider).reachPercentage;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reach',
                  style: TextStyle(
                    fontSize: 18,
                    color: _getChartSecondColor(),
                  ),
                ),
                const SizedBox(height: 12),
                _animatedTicker(
                  reach,
                  TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: _lightMode
                        ? Colors.grey.shade900
                        : palette.primarySwatch.dark.foreground50,
                  ),
                  decimals: 1,
                  suffix: 'M',
                ),
                const SizedBox(height: 12),
                _animatedTicker(
                  reachPercentage.toDouble(),
                  TextStyle(
                    color: _getChartSecondColor(),
                    fontSize: 18,
                  ),
                  decimals: 1,
                  prefix: '+',
                  suffix: '% of target',
                ),
                const SizedBox(height: 24),
                _sparkChart(palette)
              ],
            );
          }),
        ),
      ),
    );
  }

  Material _salesCard(Palette palette) {
    return _card(
      palette,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sales',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '345.8 M',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: _lightMode
                      ? Colors.grey.shade900
                      : palette.primarySwatch.dark.foreground50,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '+11%  of target',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material _usersCard(Palette palette) {
    return _card(
      palette,
      child: Padding(
        padding: const EdgeInsets.only(top: 18, left: 18, right: 10, bottom: 6),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Users',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '45.5 M',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: _lightMode
                      ? Colors.grey.shade900
                      : palette.primarySwatch.dark.foreground50,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Consumer(builder: (context, ref, widget) {
                  Color _btnColor = _getChartMainColor();
                  Color _btnTextColor =
                      _lightMode ? Colors.white : Colors.black;
                  return MaterialButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(getSnackBar() as SnackBar);
                    },
                    splashColor: _lightMode
                        ? palette.primarySwatch.shade50
                        : palette.primarySwatch.dark.foreground50,
                    color: _btnColor,
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: _btnTextColor),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material _averageSessionCard(Palette palette) {
    return _card(
      palette,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Avg. sessions',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '4:53H',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: _lightMode
                      ? Colors.grey.shade900
                      : palette.primarySwatch.dark.foreground50,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '+56.6%  of target',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material _sessionsCard(Palette palette) {
    return _card(
      palette,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sessions',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '23,242',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: _lightMode
                      ? Colors.grey.shade900
                      : palette.primarySwatch.dark.foreground50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material _bounceRateCard(Palette palette) {
    return _card(
      palette,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bounce rate',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '12%',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: _lightMode
                      ? Colors.grey.shade900
                      : palette.primarySwatch.dark.foreground50,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '+13.9%  of target',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material _pageViewsCard(Palette palette) {
    return _card(
      palette,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Page views',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '102.2 M',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                  color: _lightMode
                      ? Colors.grey.shade900
                      : palette.primarySwatch.dark.foreground50,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '-8%  of target',
                style: TextStyle(
                  fontSize: 18,
                  color: _getChartSecondColor(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sparkChart(Palette palette) {
    return Consumer(builder: (context, ref, child) {
      Color chartColor = _getChartMainColor();
      List<double> data = ref.watch(dataProvider).sparkData;

      return SizedBox(
        height: 65,
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              show: false,
            ),
            axisTitleData: FlAxisTitleData(
              show: false,
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> toolTips) {
                    return List.generate(
                        toolTips.length,
                        (index) => LineTooltipItem(
                              toolTips[index].y.toString(),
                              TextStyle(
                                  color:
                                      _chartTooltipBgColor().foregroundColor()),
                            ));
                  },
                  tooltipBgColor: _chartTooltipBgColor(),
                ),
                getTouchedSpotIndicator: (barData, spotIndexes) {
                  return List.generate(
                      spotIndexes.length,
                      (index) => TouchedSpotIndicatorData(
                          FlLine(color: Colors.transparent),
                          FlDotData(
                              show: true,
                              getDotPainter: (spot, _, __, ___) {
                                return FlDotCirclePainter(
                                  color: chartColor,
                                  strokeWidth: 3,
                                  radius: 4,
                                  strokeColor: _lightMode
                                      ? Colors.white
                                      : palette.primarySwatch.dark.surface02dp,
                                );
                              })));
                }),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, _, __, index) {
                      bool isLast = index == 21;
                      return FlDotCirclePainter(
                        color: isLast ? chartColor : Colors.transparent,
                        strokeWidth: isLast ? 3 : 0,
                        radius: isLast ? 4 : 0,
                        strokeColor: _lightMode
                            ? Colors.white
                            : palette.primarySwatch.dark.surface02dp,
                      );
                    }),
                curveSmoothness: 0.3,
                spots: [
                  for (int item = 0; item <= 21; item++)
                    FlSpot(item.toDouble(), data[item]),
                ],
                colors: [chartColor],
              ),
            ],
          ),
        ),
      );
    });
  }

  Color _chartTooltipBgColor() {
    ThemeNotifier theme = ref.watch(themeProvider);

    Palette monochromaticPalette = theme.palette;
    Triadic60Palette triadic60Palette = theme.triadic60Palette;
    Triadic120Palette triadic120Palette = theme.triadic120Palette;
    AnalogousPalette analogousPalette = theme.analogousPalette;
    ComplementaryPalette complementaryPalette = theme.complementaryPalette;
    TetradicPalette tetradicPalette = theme.tetradicPalette;

    ColorHarmony harmony = ref.watch(themeProvider).harmony;
    switch (harmony) {
      case ColorHarmony.monochromatic:
        return _lightMode
            ? colorOrDarkerOverWhite(monochromaticPalette.primarySwatch)
            : monochromaticPalette.primarySwatch.dark.surface24dp;
      case ColorHarmony.complementary:
        return _lightMode
            ? colorOrDarkerOverWhite(complementaryPalette.primarySwatch)
            : monochromaticPalette.primarySwatch.dark.surface24dp;
      case ColorHarmony.analogous:
        return _lightMode
            ? colorOrDarkerOverWhite(analogousPalette.analogousSwatchB)
            : monochromaticPalette.primarySwatch.dark.surface24dp;
      case ColorHarmony.triadic60:
        return _lightMode
            ? colorOrDarkerOverWhite(triadic60Palette.triadicSwatchB)
            : monochromaticPalette.primarySwatch.dark.surface24dp;
      case ColorHarmony.triadic120:
        return _lightMode
            ? colorOrDarkerOverWhite(triadic120Palette.triadicSwatchB)
            : monochromaticPalette.primarySwatch.dark.surface24dp;
      case ColorHarmony.tetradic:
        return _lightMode
            ? colorOrDarkerOverWhite(tetradicPalette.tetradicSwatchB)
            : monochromaticPalette.primarySwatch.dark.surface24dp;
    }
  }

  Widget _barChart(Palette palette) {
    return SizedBox(
      height: 65,
      child: Consumer(builder: (context, ref, child) {
        Color chartColor = _getChartMainColor();
        List<double> data = ref.watch(dataProvider).chartData;
        return LayoutBuilder(builder: (context, constraints) {
          double barWidth = (constraints.maxWidth / data.length) - 4;
          return BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (groupData, groupIndex, rodData, rodIndex) {
                    return BarTooltipItem(
                      rodData.y.toString(),
                      TextStyle(
                        color: _chartTooltipBgColor().foregroundColor(),
                      ),
                    );
                  },
                  tooltipBgColor: _chartTooltipBgColor(),
                ),
              ),
              titlesData: FlTitlesData(
                show: false,
              ),
              axisTitleData: FlAxisTitleData(
                show: false,
              ),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: [
                _bar(0, data[0], barWidth, [chartColor]),
                _bar(0, data[1], barWidth, [chartColor]),
                _bar(0, data[2], barWidth, [chartColor]),
                _bar(0, data[3], barWidth, [chartColor]),
                _bar(0, data[4], barWidth, [chartColor]),
                _bar(0, data[5], barWidth, [chartColor]),
                _bar(0, data[6], barWidth, [chartColor]),
              ],
            ),
          );
        });
      }),
    );
  }

  BarChartGroupData _bar(int x, double y, double width, List<Color> colors) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          colors: colors,
          borderRadius: BorderRadius.circular(3),
          y: y,
          width: width,
        )
      ],
    );
  }

  Material _card(Palette palette, {Widget? child}) {
    return Material(
      elevation: 4,
      borderRadius: const BorderRadius.all(
        Radius.circular(cardRadius),
      ),
      color: _lightMode ? Colors.white : palette.primarySwatch.dark.surface02dp,
      child: child,
    );
  }

  Color colorOrDarkerOverWhite(Swatch swatch) {
    if (swatch.shade500.foregroundColor() == Colors.white) {
      return swatch.shade500;
    } else {
      return Colors.white.foregroundColors(swatch).light;
    }
  }

  Color _getChartMainColor() {
    ThemeNotifier theme = ref.watch(themeProvider);

    bool lightMode = theme.lightMode;

    Palette monochromaticPalette = theme.palette;
    Triadic60Palette triadic60Palette = theme.triadic60Palette;
    Triadic120Palette triadic120Palette = theme.triadic120Palette;
    AnalogousPalette analogousPalette = theme.analogousPalette;
    ComplementaryPalette complementaryPalette = theme.complementaryPalette;
    TetradicPalette tetradicPalette = theme.tetradicPalette;

    ColorHarmony harmony = ref.watch(themeProvider).harmony;
    switch (harmony) {
      case ColorHarmony.monochromatic:
        return lightMode
            ? colorOrDarkerOverWhite(monochromaticPalette.primarySwatch)
            : monochromaticPalette.primarySwatch.dark.foreground200;
      case ColorHarmony.complementary:
        return lightMode
            ? colorOrDarkerOverWhite(complementaryPalette.primarySwatch)
            : complementaryPalette.primarySwatch.dark.foreground200;
      case ColorHarmony.analogous:
        return lightMode
            ? colorOrDarkerOverWhite(analogousPalette.analogousSwatchB)
            : analogousPalette.analogousSwatchB.dark.foreground200;
      case ColorHarmony.triadic60:
        return lightMode
            ? colorOrDarkerOverWhite(triadic60Palette.triadicSwatchB)
            : triadic60Palette.triadicSwatchB.dark.foreground200;
      case ColorHarmony.triadic120:
        return lightMode
            ? colorOrDarkerOverWhite(triadic120Palette.triadicSwatchB)
            : triadic120Palette.triadicSwatchB.dark.foreground200;
      case ColorHarmony.tetradic:
        return lightMode
            ? colorOrDarkerOverWhite(tetradicPalette.tetradicSwatchB)
            : tetradicPalette.tetradicSwatchB.dark.foreground200;
    }
  }

  Color _getChartSecondColor() {
    ThemeNotifier theme = ref.watch(themeProvider);

    Palette monochromaticPalette = theme.palette;
    TetradicPalette tetradicPalette = theme.tetradicPalette;

    ColorHarmony harmony = ref.watch(themeProvider).harmony;
    switch (harmony) {
      case ColorHarmony.tetradic:
        return _lightMode
            ? Colors.white
                .foregroundColors(tetradicPalette.tetradicSwatchC)
                .dark
            : tetradicPalette.tetradicSwatchC.dark.foreground200;
      default:
        return _lightMode
            ? Colors.grey.shade900
            : monochromaticPalette.primarySwatch.dark.foreground200;
    }
  }
}

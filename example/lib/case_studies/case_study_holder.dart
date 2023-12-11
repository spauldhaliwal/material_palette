import 'dart:ui';

import 'package:example/case_studies/owl/owl.dart';
import 'package:example/providers/data.dart';
import 'package:example/providers/owl.dart';
import 'package:example/providers/studies.dart';
import 'package:example/providers/theme.dart';
import 'package:example/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:material_palette/palette.dart';

import 'analytics/analytics.dart';

class CaseStudyHolder extends ConsumerStatefulWidget {
  const CaseStudyHolder({
    required this.appId,
    Key? key,
  }) : super(key: key);
  final String appId;
  @override
  ConsumerState<CaseStudyHolder> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<CaseStudyHolder> {
  bool _lightMode = true;
  String _appId = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appId = ref.read(caseStudyProvider).activeApp;
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier theme = ref.watch(themeProvider);
    _lightMode = theme.lightMode;

    return Consumer(
      builder: (context, ref, widget) {
        _appId = ref.watch(caseStudyProvider).activeApp;
        return Scaffold(
          backgroundColor: _scaffoldBackgroundColor(),
          appBar: _appBar(),
          drawer: _navDrawer(),
          body: () {
            switch (_appId) {
              case 'analytics':
                return const Analytics();
              case 'owl':
                return const Owl();
              default:
                Container(width: 100, height: 100, color: Colors.red);
            }
          }(),
          floatingActionButton: _floatingActionButton(),
          bottomNavigationBar: _navigationBar(),
        );
      },
    );
  }

  AppBar _appBar() {
    ThemeNotifier theme = ref.watch(themeProvider);
    Palette monochromaticPalette = theme.palette;
    return AppBar(
      systemOverlayStyle: _appBarOverlayStyle(),
      foregroundColor: _lightMode
          ? monochromaticPalette.primarySwatch.shade500.foregroundColor()
          : Colors.white,
      backgroundColor: _lightMode
          ? monochromaticPalette.primarySwatch.shade500
          : monochromaticPalette.primarySwatch.dark.surface24dp,
      title: () {
        switch (_appId) {
          case 'analytics':
            return const Text('Analytics');
          case 'owl':
            return const Text('Owl');
        }
      }(),
      actions: [
        _colorSciencePopupMenuAction(),
        _swatchMenuAction(),
        _darkModeToggleMenuAction(),
      ],
    );
  }

  void _updateColor() {
    setState(() {
      ref.read(themeProvider).nextColor();
      ref.read(dataProvider).updateData();
    });
  }

  void _toggleDarkMode() {
    setState(() {
      ref.read(themeProvider).toggleTheme();
      _lightMode = ref.watch(themeProvider).lightMode;
    });
  }

  Color _popupMenuColor() {
    Palette palette = ref.watch(themeProvider).palette;
    return _lightMode ? Colors.white : palette.primarySwatch.dark.surface06dp;
  }

  Color _radioColor() {
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

  Color _getFabIconColor() {
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
        return monochromaticPalette.primarySwatch.shade500.foregroundColor();
      case ColorHarmony.complementary:
        return complementaryPalette.complementarySwatch.shade500
            .foregroundColor();
      case ColorHarmony.triadic60:
        return triadic60Palette.triadicSwatchA.shade500.foregroundColor();
      case ColorHarmony.analogous:
        return analogousPalette.analogousSwatchA.shade500.foregroundColor();
      case ColorHarmony.triadic120:
        return triadic120Palette.triadicSwatchA.shade500.foregroundColor();
      case ColorHarmony.tetradic:
        return tetradicPalette.tetradicSwatchA.shade500.foregroundColor();
    }
  }

  Swatch _getFabColor() {
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
        return monochromaticPalette.primarySwatch;
      case ColorHarmony.complementary:
        return complementaryPalette.complementarySwatch;
      case ColorHarmony.analogous:
        return analogousPalette.analogousSwatchA;
      case ColorHarmony.triadic60:
        return triadic60Palette.triadicSwatchA;
      case ColorHarmony.triadic120:
        return triadic120Palette.triadicSwatchA;
      case ColorHarmony.tetradic:
        return tetradicPalette.tetradicSwatchA;
    }
  }

  SystemUiOverlayStyle _appBarOverlayStyle() {
    Swatch appSwatch = ref.watch(themeProvider).palette.primarySwatch;
    if (_lightMode) {
      return appSwatch.shade500.foregroundColor() == Colors.white
          ? SystemUiOverlayStyle.light
              .copyWith(systemNavigationBarColor: appSwatch.shade500)
          : SystemUiOverlayStyle.dark
        ..copyWith(systemNavigationBarColor: appSwatch.shade500);
    } else {
      return SystemUiOverlayStyle.light
          .copyWith(systemNavigationBarColor: appSwatch.shade500);
    }
  }

  Widget _circleSwatches(List<Swatch> swatches, double height) {
    return Consumer(builder: (context, ref, widget) {
      Swatch appSwatch = ref.watch(themeProvider).palette.primarySwatch;
      return Theme(
        data: Theme.of(context).copyWith(
          buttonTheme: ButtonTheme.of(context).copyWith(
            splashColor: appSwatch.shade900,
          ),
          splashColor: appSwatch.shade900,
        ),
        child: SizedBox(
          height: height,
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int index = swatches.length - 1; index >= 0; index--)
                  Transform.translate(
                    offset: Offset(index * (height / 3), 0),
                    child: Container(
                      height: height,
                      width: height,
                      decoration: BoxDecoration(
                        color: swatches[index].shade500,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: _lightMode
                              ? Colors.white
                              : appSwatch.dark.surface06dp,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Color _getBottomNavActivatedColor() {
    ThemeNotifier theme = ref.watch(themeProvider);
    switch (theme.harmony) {
      case ColorHarmony.monochromatic:
        return theme.lightMode
            ? theme.palette.primarySwatch.shade500.foregroundColor()
            : theme.palette.primarySwatch.dark.surface24dp.foregroundColor();
      case ColorHarmony.complementary:
        return theme.lightMode
            ? theme.palette.primarySwatch.shade500
                .foregroundColors(
                    theme.complementaryPalette.complementarySwatch)
                .dark
            : theme.complementaryPalette.complementarySwatch.dark.foreground200;
      case ColorHarmony.analogous:
        return theme.lightMode
            ? theme.palette.primarySwatch.shade500
                .foregroundColors(theme.analogousPalette.analogousSwatchA)
                .light
            : theme.analogousPalette.analogousSwatchA.dark.foreground200;
      case ColorHarmony.triadic60:
        return theme.lightMode
            ? theme.palette.primarySwatch.shade500
                .foregroundColors(theme.triadic60Palette.triadicSwatchA)
                .light
            : theme.triadic60Palette.triadicSwatchA.dark.foreground200;
      case ColorHarmony.triadic120:
        return theme.lightMode
            ? theme.palette.primarySwatch.shade500
                .foregroundColors(theme.triadic120Palette.triadicSwatchA)
                .light
            : theme.triadic120Palette.triadicSwatchA.dark.foreground200;
      case ColorHarmony.tetradic:
        return theme.lightMode
            ? theme.palette.primarySwatch.shade500
                .foregroundColors(theme.tetradicPalette.tetradicSwatchA)
                .light
            : theme.tetradicPalette.tetradicSwatchA.dark.foreground200;
    }
  }

  Color _getBottomNavUnactivatedColor() {
    ThemeNotifier theme = ref.watch(themeProvider);
    return theme.lightMode
        ? theme.palette.primarySwatch.shade500.foregroundColor()
        : theme.palette.primarySwatch.dark.surface00dp.foregroundColor();
  }

  Widget _navigationBar() {
    String caseStudy = ref.watch(caseStudyProvider).activeApp;
    ThemeNotifier theme = ref.watch(themeProvider);

    OwlNotifier owlState = ref.watch(owlProvider);

    switch (caseStudy) {
      case 'owl':
        return BottomNavigationBar(
          currentIndex: owlState.owlBottomNavState.index,
          backgroundColor: theme.lightMode
              ? theme.palette.primarySwatch.shade500
              : theme.palette.primarySwatch.dark.surface00dp,
          showUnselectedLabels: false,
          unselectedItemColor: _getBottomNavUnactivatedColor(),
          selectedItemColor: _getBottomNavActivatedColor(),
          onTap: (id) {
            switch (id) {
              case 0:
                setState(() {
                  owlState.setBottomNavState(OwlBottomNavState.courses);
                });
                break;
              case 1:
                setState(() {
                  owlState.setBottomNavState(OwlBottomNavState.featured);
                });
                break;
              case 2:
                setState(() {
                  owlState.setBottomNavState(OwlBottomNavState.search);
                });
                break;
            }
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/icons/owl_courses.svg',
                    color: _getBottomNavActivatedColor()),
              ),
              icon: SvgPicture.asset(
                'assets/icons/owl_courses.svg',
                color: _getBottomNavUnactivatedColor(),
              ),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/icons/owl_featured.svg',
                    color: _getBottomNavActivatedColor()),
              ),
              icon: SvgPicture.asset(
                'assets/icons/owl_featured.svg',
                color: _getBottomNavUnactivatedColor(),
              ),
              label: 'Featured',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/icons/owl_search.svg',
                    color: _getBottomNavActivatedColor()),
              ),
              icon: SvgPicture.asset(
                'assets/icons/owl_search.svg',
                color: _getBottomNavUnactivatedColor(),
              ),
              label: 'Search',
            ),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Color _scaffoldBackgroundColor() {
    String activeApp = ref.watch(caseStudyProvider).activeApp;
    ThemeNotifier theme = ref.watch(themeProvider);
    switch (activeApp) {
      case 'analytics':
        return theme.lightMode
            ? Colors.white
            : theme.palette.primarySwatch.dark.surface00dp;
      case 'owl':
        return theme.lightMode
            ? theme.palette.primarySwatch.shade500
            : theme.palette.primarySwatch.dark.surface00dp;
      default:
        return theme.lightMode
            ? Colors.white
            : theme.palette.primarySwatch.dark.surface00dp;
    }
  }

  Widget _floatingActionButton() {
    Palette monochromaticPalette = ref.watch(themeProvider).palette;
    return SizedBox(
      width: 65,
      height: 65,
      child: Consumer(builder: (context, ref, child) {
        ref.watch(themeProvider).triadic60Palette;
        return FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              _updateColor();
            },
            tooltip: 'change theme',
            foregroundColor: _lightMode
                ? Colors.white
                : monochromaticPalette.primarySwatch.dark.foreground50,
            backgroundColor: _getFabColor().dark.brandColor,
            child: Icon(
              Icons.color_lens,
              color: _getFabIconColor(),
            ),
          ),
        );
      }),
    );
  }

  Widget _navDrawer() {
    return Consumer(builder: (context, ref, widget) {
      ThemeNotifier theme = ref.watch(themeProvider);
      Palette monochromaticPalette = theme.palette;
      TextStyle _menuItemTextStyle = TextStyle(
          color: _lightMode
              ? Colors.black
              : monochromaticPalette.primarySwatch.dark.foreground50);
      return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: _lightMode
              ? Colors.white
              : monochromaticPalette.primarySwatch.dark.surface00dp,
          //other styles
        ),
        child: Drawer(
          child: Consumer(builder: (context, ref, child) {
            String activeApp = ref.watch(caseStudyProvider).activeApp;
            return Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: _lightMode ? Colors.black : Colors.white,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 125,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: _lightMode
                            ? monochromaticPalette.primarySwatch.shade500
                            : monochromaticPalette
                                .primarySwatch.dark.surface24dp,
                      ),
                      child: Center(
                        child: Text(
                          'Case Studies',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            color: _lightMode
                                ? monochromaticPalette.primarySwatch.shade500
                                    .foregroundColor()
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  RadioListTile(
                    title: Text(
                      'Analytics',
                      style: _menuItemTextStyle,
                    ),
                    value: 'analytics',
                    groupValue: activeApp,
                    activeColor: _radioColor(),
                    onChanged: (String? activeApp) {
                      {
                        theme.nextColor(seedColor: HexColor.fromHex('6200ed'));
                        theme.setColorHarmony(ColorHarmony.monochromatic);
                        context.go('/apps/analytics');
                        ref
                            .read(caseStudyProvider)
                            .setActiveApp(activeApp ?? 'analytics');
                      }
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      'Owl',
                      style: _menuItemTextStyle,
                    ),
                    value: 'owl',
                    groupValue: activeApp,
                    activeColor: _radioColor(),
                    onChanged: (String? activeApp) {
                      {
                        theme.nextColor(seedColor: HexColor.fromHex('0f41fb'));
                        theme.setColorHarmony(ColorHarmony.complementary);
                        context.go('/apps/owl');
                        ref
                            .read(caseStudyProvider)
                            .setActiveApp(activeApp ?? 'analytics');
                      }
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }

  Widget _darkModeToggleMenuAction() {
    return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Consumer(builder: (context, ref, child) {
          return GestureDetector(
            onTap: () {
              _toggleDarkMode();
            },
            child: Icon(
              _lightMode ? Icons.brightness_7 : Icons.brightness_4_rounded,
              size: 26.0,
            ),
          );
        }));
  }

  Widget _swatchMenuAction() {
    return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Consumer(builder: (context, ref, child) {
          return GestureDetector(
            onTap: () {
              context.push('/swatches');
            },
            child: const Center(
              child: FaIcon(FontAwesomeIcons.swatchbook, size: 21),
            ),
          );
        }));
  }

  Widget _colorSciencePopupMenuAction() {
    ThemeNotifier theme = ref.watch(themeProvider);
    Palette monochromaticPalette = theme.palette;
    Triadic60Palette triadic60Palette = theme.triadic60Palette;
    Triadic120Palette triadic120Palette = theme.triadic120Palette;
    AnalogousPalette analogousPalette = theme.analogousPalette;
    ComplementaryPalette complementaryPalette = theme.complementaryPalette;
    TetradicPalette tetradicPalette = theme.tetradicPalette;

    TextStyle _menuItemTextStyle = TextStyle(
        color: _lightMode
            ? Colors.black
            : monochromaticPalette.primarySwatch.dark.foreground50);
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Theme(
        data: Theme.of(context).copyWith(
          cardColor: _popupMenuColor(),
          unselectedWidgetColor: _lightMode
              ? Colors.black
              : monochromaticPalette.primarySwatch.shade50,
        ),
        child: PopupMenuButton<ColorHarmony>(
          child: Center(
              child: InkWell(
            borderRadius: BorderRadius.circular(
              10000,
            ),
            child: FaIcon(
              FontAwesomeIcons.vial,
              size: 21,
              color: _lightMode
                  ? monochromaticPalette.primarySwatch.shade500
                      .foregroundColor()
                  : monochromaticPalette.primarySwatch.dark.surface24dp
                      .foregroundColor(),
            ),
          )),
          onSelected: (harmony) {},
          itemBuilder: (BuildContext context) {
            return ColorHarmony.values.map((ColorHarmony harmony) {
              return PopupMenuItem<ColorHarmony>(
                value: harmony,
                child: () {
                  switch (harmony) {
                    case ColorHarmony.monochromatic:
                      return Consumer(builder: (context, ref, widget) {
                        return RadioListTile(
                          title: Text(
                            'Single',
                            style: _menuItemTextStyle,
                          ),
                          secondary: _circleSwatches(
                            [monochromaticPalette.primarySwatch],
                            16,
                          ),
                          value: ColorHarmony.monochromatic,
                          groupValue: ref.watch(themeProvider).harmony,
                          activeColor: monochromaticPalette
                              .primarySwatch.dark.brandColor,
                          onChanged: (ColorHarmony? harmony) {
                            {
                              ref.read(themeProvider).setColorHarmony(
                                  harmony ?? ColorHarmony.monochromatic);
                            }
                          },
                        );
                      });
                    case ColorHarmony.complementary:
                      return Consumer(builder: (context, ref, widget) {
                        return RadioListTile(
                          title: Text(
                            'Dual',
                            style: _menuItemTextStyle,
                          ),
                          secondary: _circleSwatches(
                            [
                              complementaryPalette.primarySwatch,
                              complementaryPalette.complementarySwatch,
                            ],
                            16,
                          ),
                          value: ColorHarmony.complementary,
                          groupValue: ref.watch(themeProvider).harmony,
                          activeColor: monochromaticPalette
                              .primarySwatch.dark.brandColor,
                          onChanged: (ColorHarmony? harmony) {
                            {
                              ref.read(themeProvider).setColorHarmony(
                                  harmony ?? ColorHarmony.monochromatic);
                            }
                          },
                        );
                      });
                    case ColorHarmony.analogous:
                      return Consumer(builder: (context, ref, widget) {
                        return RadioListTile(
                          title: Text(
                            'Analogous',
                            style: _menuItemTextStyle,
                          ),
                          secondary: _circleSwatches(
                            [
                              analogousPalette.primarySwatch,
                              analogousPalette.analogousSwatchA,
                              analogousPalette.analogousSwatchB,
                            ],
                            16,
                          ),
                          value: ColorHarmony.analogous,
                          groupValue: ref.watch(themeProvider).harmony,
                          activeColor: monochromaticPalette
                              .primarySwatch.dark.brandColor,
                          onChanged: (ColorHarmony? harmony) {
                            {
                              ref.read(themeProvider).setColorHarmony(
                                  harmony ?? ColorHarmony.monochromatic);
                            }
                          },
                        );
                      });
                    case ColorHarmony.triadic60:
                      return Consumer(builder: (context, ref, widget) {
                        return RadioListTile(
                          title: Text(
                            'Triadic60',
                            style: _menuItemTextStyle,
                          ),
                          secondary: _circleSwatches(
                            [
                              triadic60Palette.primarySwatch,
                              triadic60Palette.triadicSwatchA,
                              triadic60Palette.triadicSwatchB,
                            ],
                            16,
                          ),
                          value: ColorHarmony.triadic60,
                          groupValue: ref.watch(themeProvider).harmony,
                          activeColor: monochromaticPalette
                              .primarySwatch.dark.brandColor,
                          onChanged: (ColorHarmony? harmony) {
                            {
                              ref.read(themeProvider).setColorHarmony(
                                  harmony ?? ColorHarmony.monochromatic);
                            }
                          },
                        );
                      });
                    case ColorHarmony.triadic120:
                      return Consumer(builder: (context, ref, widget) {
                        return RadioListTile(
                          title: Text(
                            'Triadic120',
                            style: _menuItemTextStyle,
                          ),
                          secondary: _circleSwatches(
                            [
                              triadic120Palette.primarySwatch,
                              triadic120Palette.triadicSwatchA,
                              triadic120Palette.triadicSwatchB
                            ],
                            16,
                          ),
                          value: ColorHarmony.triadic120,
                          groupValue: ref.watch(themeProvider).harmony,
                          activeColor: monochromaticPalette
                              .primarySwatch.dark.brandColor,
                          onChanged: (ColorHarmony? harmony) {
                            {
                              ref.read(themeProvider).setColorHarmony(
                                  harmony ?? ColorHarmony.monochromatic);
                            }
                          },
                        );
                      });
                    case ColorHarmony.tetradic:
                      return Consumer(builder: (context, ref, widget) {
                        return RadioListTile(
                          title: Text(
                            'Tetradic',
                            style: _menuItemTextStyle,
                          ),
                          secondary: _circleSwatches(
                            [
                              tetradicPalette.primarySwatch,
                              tetradicPalette.tetradicSwatchA,
                              tetradicPalette.tetradicSwatchB,
                              tetradicPalette.tetradicSwatchC,
                            ],
                            16,
                          ),
                          value: ColorHarmony.tetradic,
                          groupValue: ref.watch(themeProvider).harmony,
                          activeColor: monochromaticPalette
                              .primarySwatch.dark.brandColor,
                          onChanged: (ColorHarmony? harmony) {
                            {
                              ref.read(themeProvider).setColorHarmony(
                                  harmony ?? ColorHarmony.monochromatic);
                            }
                          },
                        );
                      });
                  }
                }(),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}

class AppRouterWidget extends StatelessWidget {
  const AppRouterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:example/case_studies/owl/animated_clip_rect.dart';
import 'package:example/case_studies/owl/logo/logo_widget.dart';
import 'package:example/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/palette.dart';

class Featured extends StatelessWidget {
  const Featured({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(24),
              child: Logo(logoSize: 125),
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              splashColor: Colors.white,
              borderRadius: BorderRadius.circular(1000),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Consumer(
                    builder: (context, ref, widget) {
                      ThemeNotifier theme = ref.watch(themeProvider);
                      return Icon(
                        Icons.account_circle_rounded,
                        size: 32,
                        color: theme.lightMode
                            ? theme.palette.primarySwatch.shade500
                                .foregroundColor()
                            : theme.palette.primarySwatch.dark.surface00dp
                                .foregroundColor(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  runSpacing: 4,
                  children: const [
                    FeaturedListItem(
                      'An Introduction To Oil Painting On Canvas',
                      'Painting',
                      18,
                      'https://cdn.pixabay.com/photo/2016/09/20/18/49/brushes-1683134__340.jpg',
                      'https://cdn.pixabay.com/photo/2016/11/21/16/01/woman-1846127__480.jpg',
                    ),
                    FeaturedListItem(
                      'Soundproofing Your Home Recording Studio',
                      'Music',
                      6,
                      'https://cdn.pixabay.com/photo/2016/06/27/07/30/elvis-presley-1482026__480.jpg',
                      'https://cdn.pixabay.com/photo/2018/04/04/10/11/woman-3289372__340.jpg',
                    ),
                    FeaturedListItem(
                      'Thrifting For a Fall Outfit',
                      'Fashion',
                      8,
                      'https://cdn.pixabay.com/photo/2021/10/03/04/21/woman-6676901_1280.jpg',
                      'https://cdn.pixabay.com/photo/2016/11/18/19/07/happy-1836445__480.jpg',
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Wrap(
                  runSpacing: 8,
                  children: const [
                    FeaturedListItem(
                      'Understanding the Composition of Modern Cities',
                      'Architecture',
                      12,
                      'https://cdn.pixabay.com/photo/2017/03/27/15/17/apartment-2179337_1280.jpg',
                      'https://cdn.pixabay.com/photo/2017/08/07/14/15/portrait-2604283__480.jpg',
                    ),
                    FeaturedListItem(
                      'Woodworking With Hand Tools',
                      'Woodworking',
                      18,
                      'https://cdn.pixabay.com/photo/2017/10/23/14/20/tools-2881189__480.jpg',
                      'https://cdn.pixabay.com/photo/2018/02/16/14/38/portrait-3157821__480.jpg',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 125),
      ],
    );
  }
}

class FeaturedListItem extends ConsumerStatefulWidget {
  final String title;
  final String type;
  final int count;
  final String courseImageUrl;
  final String authorAvatarImageUrl;

  const FeaturedListItem(
    this.title,
    this.type,
    this.count,
    this.courseImageUrl,
    this.authorAvatarImageUrl, {
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FeaturedListItem> createState() => _FeaturedListItemState();
}

class _FeaturedListItemState extends ConsumerState<FeaturedListItem> {
  bool _lightMode = true;
  bool added = false;
  Color _cardBackgroundColor() {
    ThemeNotifier theme = ref.watch(themeProvider);
    return _lightMode
        ? Colors.white
        : theme.palette.primarySwatch.dark.surface02dp;
  }

  Color _cardTitleColor() {
    return _lightMode
        ? Colors.black.withOpacity(0.85)
        : Colors.white.withOpacity(0.85);
  }

  Color _cardSubtitleColor() {
    ThemeNotifier theme = ref.watch(themeProvider);
    switch (theme.harmony) {
      case ColorHarmony.monochromatic:
        return _lightMode
            ? Colors.white.foregroundColors(theme.palette.primarySwatch).dark
            : theme.palette.primarySwatch.dark.foreground200;
      case ColorHarmony.complementary:
        return _lightMode
            ? Colors.white
                .foregroundColors(theme.complementaryPalette.primarySwatch)
                .dark
            : theme.complementaryPalette.primarySwatch.dark.foreground200;
      case ColorHarmony.analogous:
        return _lightMode
            ? Colors.white
                .foregroundColors(theme.analogousPalette.analogousSwatchB)
                .dark
            : theme.analogousPalette.analogousSwatchB.dark.foreground200;
      case ColorHarmony.triadic60:
        return _lightMode
            ? Colors.white
                .foregroundColors(theme.triadic60Palette.triadicSwatchB)
                .dark
            : theme.triadic60Palette.triadicSwatchB.dark.foreground200;
      case ColorHarmony.triadic120:
        return _lightMode
            ? Colors.white
                .foregroundColors(theme.triadic120Palette.triadicSwatchB)
                .dark
            : theme.triadic120Palette.triadicSwatchB.dark.foreground200;
      case ColorHarmony.tetradic:
        return _lightMode
            ? Colors.white
                .foregroundColors(theme.tetradicPalette.tetradicSwatchB)
                .dark
            : theme.tetradicPalette.tetradicSwatchB.dark.foreground200;
    }
  }

  Color _bookmarkBtnBackgroundColor() {
    ThemeNotifier theme = ref.watch(themeProvider);
    switch (theme.harmony) {
      case ColorHarmony.monochromatic:
        return _lightMode
            ? theme.palette.primarySwatch.shade500
            : theme.palette.primarySwatch.dark.foreground200;
      case ColorHarmony.complementary:
        return _lightMode
            ? theme.complementaryPalette.primarySwatch.shade500
            : theme.complementaryPalette.primarySwatch.dark.foreground200;
      case ColorHarmony.analogous:
        return _lightMode
            ? theme.analogousPalette.analogousSwatchA.shade500
            : theme.analogousPalette.analogousSwatchA.dark.foreground200;
      case ColorHarmony.triadic60:
        return _lightMode
            ? theme.triadic60Palette.triadicSwatchA.shade500
            : theme.triadic60Palette.triadicSwatchA.dark.foreground200;
      case ColorHarmony.triadic120:
        return _lightMode
            ? theme.triadic120Palette.triadicSwatchA.shade500
            : theme.triadic120Palette.triadicSwatchA.dark.foreground200;
      case ColorHarmony.tetradic:
        return _lightMode
            ? theme.tetradicPalette.tetradicSwatchA.shade500
            : theme.tetradicPalette.tetradicSwatchA.dark.foreground200;
    }
  }

  Color _bookmarkBtnForegroundColor() {
    ThemeNotifier theme = ref.watch(themeProvider);
    return _lightMode
        ? _bookmarkBtnBackgroundColor()
            .foregroundColors(theme.palette.primarySwatch)
            .light
        : _bookmarkBtnBackgroundColor()
            .foregroundColors(theme.palette.primarySwatch)
            .dark;
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier theme = ref.watch(themeProvider);
    double topRightRadius = added ? 35 : 0;
    _lightMode = theme.lightMode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
          color: _cardBackgroundColor(),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(topRightRadius),
          )),
      child: Column(
        children: [
          AnimatedClipRRect(
            duration: const Duration(milliseconds: 150),
            curve: Curves.fastOutSlowIn,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(topRightRadius),
            ),
            child: Stack(
              children: [
                Image.network(
                  widget.courseImageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, widget, imageChunkEvent) {
                    return imageChunkEvent == null
                        ? widget
                        : Padding(
                            padding: const EdgeInsets.all(32),
                            child: CircularProgressIndicator(
                              color: _cardSubtitleColor(),
                            ),
                          );
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        added = !added;
                      });
                    },
                    child: AnimatedPadding(
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.fastOutSlowIn,
                      padding: EdgeInsets.all(added ? 16 : 12),
                      child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                              color: _bookmarkBtnBackgroundColor(),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _bookmarkBtnForegroundColor(),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 5,
                                  offset: const Offset(3, 3),
                                )
                              ]),
                          child: Center(
                            child: FaIcon(
                              added
                                  ? FontAwesomeIcons.minus
                                  : FontAwesomeIcons.plus,
                              size: 13.5,
                              color: _bookmarkBtnForegroundColor(),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Transform.translate(
              offset: const Offset(0, -21),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3.5,
                      ),
                    ),
                    width: 42,
                    height: 42,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        widget.authorAvatarImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.type.toUpperCase(),
                    style: TextStyle(
                        fontFamily: GoogleFonts.rubik().fontFamily,
                        fontSize: 11,
                        letterSpacing: 1.5,
                        color: _cardSubtitleColor(),
                        fontWeight: FontWeight.w100),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 16,
                      color: _cardTitleColor(),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.tv,
                        size: 10,
                        color: _cardSubtitleColor(),
                      ),
                      const SizedBox(width: 6),
                      Center(
                        child: Text(
                          widget.count.toString(),
                          maxLines: 2,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: GoogleFonts.rubik().fontFamily,
                              fontSize: 15,
                              color: _cardSubtitleColor(),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

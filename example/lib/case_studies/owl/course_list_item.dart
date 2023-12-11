import 'package:example/case_studies/owl/animated_clip_rect.dart';
import 'package:example/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/palette.dart';

class CourseListItemm extends ConsumerWidget {
  const CourseListItemm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class CourseListItem extends ConsumerStatefulWidget {
  final String title;
  final int count;
  final String courseImageUrl;
  final String authorAvatarImageUrl;

  const CourseListItem(
    this.title,
    this.count,
    this.courseImageUrl,
    this.authorAvatarImageUrl, {
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CourseListItem> createState() => _CourseListItemState();
}

class _CourseListItemState extends ConsumerState<CourseListItem> {
  bool added = false;
  bool _lightMode = true;

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
    _lightMode = ref.watch(themeProvider).lightMode;
    ThemeNotifier theme = ref.watch(themeProvider);
    double topLeftRadius = added ? 35 : 0;
    double avatarPadding = 24;

    final TextStyle textStyle = TextStyle(
        fontFamily: GoogleFonts.rubik().fontFamily,
        fontSize: 15,
        fontWeight: FontWeight.w600);

    final Size textSize = (TextPainter(
      text: TextSpan(text: widget.title, style: textStyle),
      maxLines: 2,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.longestLine,
    )..layout())
        .size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.fastOutSlowIn,
      height: 110,
      width: textSize.width + 110 + avatarPadding + 40 + 24,
      decoration: BoxDecoration(
          color: _cardBackgroundColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeftRadius),
          )),
      child: Row(
        children: [
          AnimatedClipRRect(
            duration: const Duration(milliseconds: 150),
            curve: Curves.fastOutSlowIn,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius),
            ),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
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
                ),
                GestureDetector(
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
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                // top: 24,
                left: 32,
                // right: 24,
                // bottom: 18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: GoogleFonts.rubik().fontFamily,
                      fontSize: 18,
                      color: _cardTitleColor(),
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  Consumer(builder: (context, ref, widgetRef) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                    );
                  })
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 32,
                height: 32,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    widget.authorAvatarImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

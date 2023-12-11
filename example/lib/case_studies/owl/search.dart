import 'package:example/providers/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/palette.dart';

class Search extends ConsumerStatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  Color foregroundColorOverBg() {
    ThemeNotifier theme = ref.watch(themeProvider);
    return theme.lightMode
        ? theme.palette.primarySwatch.shade500.foregroundColor()
        : theme.palette.primarySwatch.dark.surface00dp.foregroundColor();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 32,
                color: foregroundColorOverBg().withOpacity(0.5),
              ),
              const SizedBox(width: 24),
              Text(
                'Search Owl',
                style: TextStyle(
                  color: foregroundColorOverBg().withOpacity(0.5),
                  fontFamily: GoogleFonts.rubik().fontFamily,
                  fontSize: 20,
                  // color: _cardTitleColor(),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.account_circle_rounded,
                size: 32,
                color: foregroundColorOverBg(),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.black.withOpacity(0.25),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 0,
            top: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SearchCategory('Architecture'),
              SearchCategory('Arts & Crafts'),
              SearchCategory('Business'),
              SearchCategory('Culinary'),
              SearchCategory('Design'),
              SearchCategory('Fashion'),
              SearchCategory('Film'),
              SearchCategory('Gaming'),
              SearchCategory('Illustration'),
              SearchCategory('Lifestyle'),
              SearchCategory('Music'),
              SearchCategory('Painting'),
              SearchCategory('Photography'),
              SearchCategory('Woodworking'),
            ],
          ),
        )
      ],
    );
  }
}

class SearchCategory extends StatelessWidget {
  final String title;
  const SearchCategory(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 24),
          child: Consumer(builder: (
            context,
            ref,
            widget,
          ) {
            ThemeNotifier theme = ref.watch(themeProvider);
            return Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: theme.lightMode
                    ? theme.palette.primarySwatch.shade500.foregroundColor()
                    : theme.palette.primarySwatch.dark.surface00dp
                        .foregroundColor(),
                fontFamily: GoogleFonts.rubik().fontFamily,
                fontSize: 28,
                // color: _cardTitleColor(),
                fontWeight: FontWeight.w900,
              ),
            );
          }),
        ),
      ),
    );
  }
}

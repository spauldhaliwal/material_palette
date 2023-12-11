import 'package:example/case_studies/owl/courses.dart';
import 'package:example/case_studies/owl/featured.dart';
import 'package:example/case_studies/owl/search.dart';
import 'package:example/providers/owl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Owl extends ConsumerStatefulWidget {
  const Owl({Key? key}) : super(key: key);

  @override
  _OwlState createState() => _OwlState();
}

class _OwlState extends ConsumerState<Owl> {
  @override
  Widget build(BuildContext context) {
    OwlBottomNavState bottomNavState = ref.watch(owlProvider).owlBottomNavState;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: RepaintBoundary(
        child: () {
          switch (bottomNavState) {
            case OwlBottomNavState.courses:
              return const Courses();
            case OwlBottomNavState.featured:
              return const Featured();
            case OwlBottomNavState.search:
              return const Search();
          }
        }(),
      ),
    );
  }
}

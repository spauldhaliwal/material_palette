import 'package:example/case_studies/case_study_holder.dart';
import 'package:example/pages.dart';
import 'package:example/swatches_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    ProviderScope(child: NestedNavApp()),
  );
}

class NestedNavApp extends StatelessWidget {
  NestedNavApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'GoRouter Example: Nested Navigation',
      );

  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, state) => '/apps/analytics',
      ),
      GoRoute(
        path: '/apps/:appid',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: CaseStudyHolder(
              key: state.pageKey,
              appId: 'analytics',
            ),
          );
        },
      ),
      GoRoute(
        path: '/swatches',
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: SwatchScreen(
              key: state.pageKey,
            ),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorPage(state.error),
    ),
  );
}

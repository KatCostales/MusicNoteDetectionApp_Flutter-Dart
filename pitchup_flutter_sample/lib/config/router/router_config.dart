import 'package:pitchupfluttersample/app/presenter/index_page_provider.dart';
import 'package:pitchupfluttersample/app/ui/index/index_page.dart';
import 'package:pitchupfluttersample/app/ui/pages/login_page.dart';
import 'package:pitchupfluttersample/app/ui/pages/sign_up.dart';
import 'package:pitchupfluttersample/core/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

/// {@template exarouter_config}
///
/// Class to implements the navigator configuration and set routes
///
/// {@endtemplate}

class JRouterConfiguration implements IConfigNavigator {
  /// Default constructor for the NavigationService.
  JRouterConfiguration() {
    initConfiguration();
  }

  late RouteInformationParser<Object> _routeInformationParser;
  late RouterDelegate<Object> _routerDelegate;

  /// Instance for GoRoute package used for the app
  /// Rememer initialize in initConfiguration
  late GoRouter _router;

  @override
  void initConfiguration() {
    _router = GoRouter(
      initialLocation: Routes.login,
      urlPathStrategy: UrlPathStrategy.path,
      debugLogDiagnostics: true,
      navigatorBuilder: (context, state, child) {
        return child;
      },
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: Routes.signup,
              builder:(context, state) => SignUp(),
            ),
            GoRoute(
              path: Routes.home,
              builder: (context, state) {
                Provider.of<IndexPageProvider>(context, listen: false)
                    .updateScrollController('page');

                return IndexPage(page: 'page');
              },
            ),
          ],
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const Scaffold(
          body: SizedBox(
            child: Text('ERROR'),
          ),
        ),
      ),
    );

    _routeInformationParser = _router.routeInformationParser;
    _routerDelegate = _router.routerDelegate;
  }

  @override
  RouteInformationParser<Object> get routeInformationParser =>
      _routeInformationParser;

  @override
  RouterDelegate<Object> get routerDelegate => _routerDelegate;

  GoRouter get router => _router;
}

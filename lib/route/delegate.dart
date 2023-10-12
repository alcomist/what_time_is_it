import 'package:flutter/material.dart';
import 'package:what_time_is_it/page/game_result_page.dart';
import 'package:what_time_is_it/page/logo_page.dart';
import 'package:what_time_is_it/route/route.dart';
import 'package:what_time_is_it/route/notifier.dart';
import 'package:what_time_is_it/page/main_page.dart';
import 'package:what_time_is_it/page/game_select_page.dart';
import 'package:what_time_is_it/page/game_play_page.dart';
import 'package:what_time_is_it/page/not_found_page.dart';

class AppRouterDelegate extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  final PageNotifier notifier;

  AppRouterDelegate({required this.notifier});

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: navigatorKey,
        pages: [
          if (AppRoute.isUnknown(notifier.pageName))
            MaterialPage(child: LogoPage()),
          if (notifier.pageName == PageNames.main.name)
            MaterialPage(child: LogoPage()),
          if (notifier.pageName == PageNames.gameSelect.name)
            const MaterialPage(child: GameSelectPage()),
          if (notifier.pageName == PageNames.gamePlay.name)
            const MaterialPage(child: GamePlayPage()),
          if (notifier.pageName == PageNames.gameResult.name)
            const MaterialPage(child: GameResultPage()),
        ],
        onPopPage: (route, result) => route.didPop(result));
  }

  //currentConfiguration is called whenever there might be a change in route
  //It checks for the current page or route and return a new route information
  //This is what populates our browser history
  @override
  AppRoute? get currentConfiguration {
    return AppRoute.getInstance(notifier.pageName);
  }

  //This is called whenever the system detects a new route is passed
  //It checks the current route through the configuration and uses that to update the notifier
  @override
  Future<void> setNewRoutePath(AppRoute configuration) async {
    notifier.changePage(page: configuration.pageName);
  }
}

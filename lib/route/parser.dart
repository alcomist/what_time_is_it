import 'package:flutter/material.dart';
import 'package:what_time_is_it/route/route.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  @override
  Future<AppRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return AppRoute.main();
    }

    //If path includes more than one segement, go to 404
    if (uri.pathSegments.length > 1) {
      return AppRoute.unknown();
    }

    if (uri.pathSegments.length == 1) {
      //print('parse');
      //print(uri.pathSegments.first);

      return AppRoute.getInstance(uri.pathSegments.first);
    }

    return AppRoute.unknown();
  }

  //This passes route information to the parseRouteInformation method depending on the current AppRoute
  @override
  RouteInformation? restoreRouteInformation(AppRoute configuration) {
    //print('restore');
    //print(configuration.pageName);

    return RouteInformation(location: '/$configuration.pageName');
  }
}

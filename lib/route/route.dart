enum PageName {
  main,
  setting,
  gameSelect,
  gamePlay,
  gameResult,
  // about,
}

class AppRoute {
  static final pages = [
    for (var name in PageName.values) name.name,
  ];

  final String pageName;

  AppRoute.main() : pageName = PageName.main.name;

  AppRoute.setting() : pageName = PageName.setting.name;

  AppRoute.gamePlay() : pageName = PageName.gamePlay.name;

  AppRoute.gameSelect() : pageName = PageName.gameSelect.name;

  AppRoute.gameResult() : pageName = PageName.gameResult.name;

  //AppRoute.about() : pageName = PageName.about.name;

  AppRoute.unknown() : pageName = '';

  //Used to get the current path
  static bool isUnknown(String path) {
    return !pages.contains(path);
  }

  static AppRoute getInstance(String path) {
    if (isUnknown(path)) {
      return AppRoute.unknown();
    }

    return switch (PageName.values.byName(path)) {
      PageName.main => AppRoute.main(),
      PageName.setting => AppRoute.setting(),
      PageName.gamePlay => AppRoute.gamePlay(),
      PageName.gameSelect => AppRoute.gameSelect(),
      PageName.gameResult => AppRoute.gameResult(),
    };
  }
}

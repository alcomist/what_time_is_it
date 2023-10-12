enum PageNames {
  main,
  setting,
  gameSelect,
  gamePlay,
  gameResult,
  // about,
}

class AppRoute {
  static final pages = [
    for (var name in PageNames.values) name.name,
  ];

  final String pageName;

  AppRoute.main() : pageName = PageNames.main.name;

  AppRoute.setting() : pageName = PageNames.setting.name;

  AppRoute.gamePlay() : pageName = PageNames.gamePlay.name;

  AppRoute.gameSelect() : pageName = PageNames.gameSelect.name;

  AppRoute.gameResult() : pageName = PageNames.gameResult.name;

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

    return switch (PageNames.values.byName(path)) {
      PageNames.main => AppRoute.main(),
      PageNames.setting => AppRoute.setting(),
      PageNames.gamePlay => AppRoute.gamePlay(),
      PageNames.gameSelect => AppRoute.gameSelect(),
      PageNames.gameResult => AppRoute.gameResult(),
    };
  }
}

import 'package:flutter/material.dart';
import 'package:what_time_is_it/route/route.dart';

class PageNotifier extends ChangeNotifier {
  String _pageName = PageName.main.name;

  get pageName => _pageName;

  changePage({required String page}) {
    _pageName = page;
    notifyListeners();
  }
}

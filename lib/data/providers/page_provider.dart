import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int pageIndex = 0;
  PageController pageController = PageController();

  void toPage(int page) {
    pageIndex = page;
    notifyListeners();
  }
}

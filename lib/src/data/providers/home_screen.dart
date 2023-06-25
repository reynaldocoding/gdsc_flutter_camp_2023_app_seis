import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  int firstValue = 0;
  final pageController = PageController();

  set setValue(int value) {
    firstValue = value;
    pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }
}

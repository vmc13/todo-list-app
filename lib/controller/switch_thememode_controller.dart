import 'package:flutter/material.dart';

class SwitchThemeMode  extends ChangeNotifier {
  static SwitchThemeMode instance = SwitchThemeMode();

  bool isDarkTheme = false;
  changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}
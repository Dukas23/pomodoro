import 'package:flutter/material.dart';
import 'package:pomodoro/core/theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  Color _colorSkin = Colors.red;
  bool _useSystemColor = true;

  bool get isDarkMode => _isDarkMode;
  Color get colorSkin => _colorSkin;
  bool get useSystemColor => _useSystemColor;

  ThemeData get theme => _isDarkMode
      ? AppTheme.darkTheme(_colorSkin)
      : AppTheme.lightTheme(_colorSkin);

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setColorSkin(Color color) {
    _colorSkin = color;
    _useSystemColor = false;
    notifyListeners();
  }

  void setUseSystemColor(bool value) {
    _useSystemColor = value;
    notifyListeners();
  }
}

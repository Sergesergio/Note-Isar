import 'package:flutter/material.dart';
import 'package:offline_isar/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  // get method to access theme from other part of the code
ThemeData get themeData => _themeData;

//get method to see if we are in dark mode
bool get isDarMode => _themeData == darkMode;

//setter method to see new themes
set themeData(ThemeData themeData) {
  _themeData = themeData;
  notifyListeners();
}
// toggle to switch mode
void toggleTheme (){
  if (_themeData == lightMode) {
    themeData = darkMode;
  }
  else{
    themeData = lightMode;
  }
}
}
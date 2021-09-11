import 'dart:async';

import 'package:flutter/material.dart';

class CustomTheme with ChangeNotifier{
  static bool _isDarkTheme = false; 

  //to get the current app theme
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;   

  void toggleTheme(){
    _isDarkTheme = !_isDarkTheme;
    print(_isDarkTheme);
    notifyListeners();
  }

  //App level light theme
  static ThemeData get lightTheme{
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xffF3F4F8),
        iconTheme: IconThemeData(color: Colors.black)
      ),
      scaffoldBackgroundColor: Color(0xffF3F4F8),
      );
    }
  
  //App level dark theme
  static ThemeData get darkTheme{
    return ThemeData(
      focusColor: Colors.white,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff535356),
        iconTheme: IconThemeData(color: Colors.white)
      ),
      scaffoldBackgroundColor: Color(0xff1C1C1D)
    );
  }
}


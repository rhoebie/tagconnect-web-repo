import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tagconnectweb/constant/theme_constants.dart';
import 'dart:html' as html;

class AutoLoginNotifier extends ChangeNotifier {
  bool _isAutoLogin = true;

  bool get isAutoLogin => _isAutoLogin;

  // Key for storing the auto-login value
  static const String autoLoginKey = 'autoLogin';

  AutoLoginNotifier() {
    loadAutoLogin();
  }

  void toggleLogin() {
    _isAutoLogin = !_isAutoLogin;
    saveAutoLogin(_isAutoLogin);

    notifyListeners();
  }

  Future<void> loadAutoLogin() async {
    // Retrieve auto-login state from local storage
    final storedAutoLogin = html.window.localStorage[autoLoginKey];

    // If the value is not null, parse it to a boolean
    if (storedAutoLogin != null) {
      _isAutoLogin = storedAutoLogin.toLowerCase() == 'true';
    } else {
      // If the value is null, default to false
      _isAutoLogin = false;
    }
  }

  Future<void> saveAutoLogin(bool value) async {
    // Save auto-login state to local storage
    html.window.localStorage[autoLoginKey] = value.toString();
  }
}

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  // Key for storing the dark mode value
  static const String darkModeKey = 'darkMode';

  ThemeNotifier() {
    loadDarkMode();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;

    // Save the dark mode value
    saveDarkMode(_isDarkMode);

    _updateSystemNavigationBarColor();
    notifyListeners();
  }

  void _updateSystemNavigationBarColor() {
    final ThemeData currentTheme = _isDarkMode ? darkTheme : lightTheme;
    final Color navigationBarColor = currentTheme.scaffoldBackgroundColor;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: navigationBarColor,
    ));
  }

  Future<void> loadDarkMode() async {
    // Retrieve dark mode state from local storage
    final storedDarkMode = html.window.localStorage[darkModeKey];

    // If the value is not null, parse it to a boolean
    if (storedDarkMode != null) {
      _isDarkMode = storedDarkMode.toLowerCase() == 'true';
    } else {
      // If the value is null, default to false
      _isDarkMode = false;
    }
  }

  Future<void> saveDarkMode(bool value) async {
    // Save dark mode state to local storage
    html.window.localStorage[darkModeKey] = value.toString();
  }
}

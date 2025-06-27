import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class SettingsViewModel extends ChangeNotifier {
  static const _themeModeKey = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.light;
  bool _hasError = false;

  ThemeMode get themeMode => _themeMode;
  bool get hasError => _hasError;

  SettingsViewModel() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeString = prefs.getString(_themeModeKey) ?? 'dark';
      _themeMode = themeModeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
      _hasError = false;
    } catch (e) {
      developer.log('Failed to load settings: $e', name: 'SettingsViewModel');
      _themeMode = ThemeMode.light;
      _hasError = true;
    }
    notifyListeners();
  }

  Future<bool> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return false;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeModeKey, mode == ThemeMode.dark ? 'dark' : 'light');
      _themeMode = mode;
      _hasError = false;
      notifyListeners();
      return true;
    } catch (e) {
      developer.log('Failed to save theme mode: $e', name: 'SettingsViewModel');
      _hasError = true;
      notifyListeners();
      return false;
    }
  }

  Future<bool> clearPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      _themeMode = ThemeMode.light;
      _hasError = false;
      notifyListeners();
      return true;
    } catch (e) {
      developer.log('Failed to clear settings: $e', name: 'SettingsViewModel');
      _hasError = true;
      notifyListeners();
      return false;
    }
  }

  Future<bool> reloadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeString = prefs.getString(_themeModeKey) ?? 'light';
      _themeMode = themeModeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
      _hasError = false;
      notifyListeners();
      return true;
    } catch (e) {
      developer.log('Failed to reload settings: $e', name: 'SettingsViewModel');
      _hasError = true;
      notifyListeners();
      return false;
    }
  }
}

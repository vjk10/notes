import 'package:flutter/material.dart';
import 'package:notes/services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../android/data/data.dart';

class ThemeNotifier extends ChangeNotifier {
  late SharedPreferences _pref;
  late bool _material3;
  bool get material3 => _material3;
  ThemeNotifier() {
    _material3 = true;
    _loadFromPrefs();
  }
  toggleTheme() {
    _material3 = !_material3;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    _pref = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _material3 = _pref.getBool(key) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _pref.setBool(key, _material3);
  }
}

class ColorNotifier extends ChangeNotifier {
  late SharedPreferences _pref;
  late Color _primaryColor;
  Color get primaryColor => _primaryColor;
  ColorNotifier() {
    _primaryColor = Utils().getPrimaryColor(1);
    _loadFromPrefs();
  }

  toggleColor(int color) {
    _primaryColor = Utils().getPrimaryColor(color);
    _saveColorToPrefs(color);
    notifyListeners();
  }

  // _initPref() is to iniliaze  the _pref variable
  _initPrefs() async {
    _pref = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    var prefColor = _pref.getInt(primaryKey) ?? 1;
    _primaryColor = Utils().getPrimaryColor(prefColor);
    notifyListeners();
  }

  _saveColorToPrefs(int colorValue) async {
    await _initPrefs();
    _pref.setInt(primaryKey, colorValue);
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes/services/imports.dart';

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

  // _initPref() is to iniliaze  the _pref variable
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

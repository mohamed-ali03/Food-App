import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsProvider extends ChangeNotifier {
  static const _langKey = 'app_lang';
  bool isLoading = false;

  String lang = 'ar';

  AppSettingsProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    lang = prefs.getString(_langKey) ?? 'ar';

    isLoading = false;
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    lang = language;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, language);

    notifyListeners();
  }
}

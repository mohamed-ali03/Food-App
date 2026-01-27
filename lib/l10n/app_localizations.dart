import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  late Map<String, String> _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Future<void> load() async {
    final jsonString = await rootBundle.loadString(
      'assets/l10n/${locale.languageCode}.json',
    );

    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  /// Simple text with optional placeholder replacement
  String t(String key, {Map<String, String>? data}) {
    // Get the localized string
    String text = _localizedStrings[key] ?? key;

    // If data is provided, replace placeholders {placeholder} with actual values
    if (data != null) {
      data.forEach((placeholder, value) {
        text = text.replaceAll('{$placeholder}', value);
      });
    }

    return text;
  }

  /// Text with parameters: {name}, {count}, etc.
  String tr(String key, Map<String, String> params) {
    String text = t(key);
    params.forEach((k, v) {
      text = text.replaceAll('{$k}', v);
    });
    return text;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}

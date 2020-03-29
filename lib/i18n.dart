import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

const List<Locale> supportedLocales = [
  const Locale('en'),
  const Locale('ko'),
  const Locale('ja'),
  const Locale('zh'),
  const Locale('es'),
  const Locale('pt'),
  const Locale('ar'),
  const Locale('vi'),
  const Locale('th'),
  const Locale('ms'),
  const Locale('id'),
  const Locale('ru'),
  const Locale('fr'),
  const Locale('it'),
  const Locale('de'),
  const Locale('hi'),
];

const List<String> supportedLangs = [
  "en",
  "ko",
  "ja",
  "zh",
  "es",
  "pt",
  "ar",
  "vi",
  "th",
  "ms",
  "id",
  "ru",
  "fr",
  "it",
  "de",
  "hi"
];

class i18n {
  Locale locale;
  static Map<dynamic, dynamic> _sentences;

  i18n(Locale locale) {
    this.locale = locale;
  }

  static i18n of(BuildContext context) {
    return Localizations.of<i18n>(context, i18n);
  }

  static Future<i18n> load(Locale locale) async {
    i18n appTranslations = i18n(locale);
    String jsonContent =
        await rootBundle.loadString("assets/lang/${locale.languageCode}.json");
    _sentences = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;

  String trans(String key) {
    //print ("[DEBUG] key : " + key);
    //print ("[DEBUG] text : " + _sentences[key]);
    return _sentences[key] ?? "$key not found";
  }
}

class i18n_delegate extends LocalizationsDelegate<i18n> {
  const i18n_delegate();

  @override
  bool isSupported(Locale locale) {
    return supportedLangs.contains(locale.languageCode);
  }

  @override
  Future<i18n> load(Locale locale) {
    return i18n.load(locale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<i18n> old) => false;
}

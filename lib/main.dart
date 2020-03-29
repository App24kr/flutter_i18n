
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './i18n.dart';
import './home.dart';

void main() {

  if (!kIsWeb) {
    // Linux/Windows
    if (Platform.isLinux || Platform.isWindows) 
      debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      supportedLocales: supportedLocales,
      localizationsDelegates: [
        i18n_delegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          debugPrint("*language locale is null!!!");
          return supportedLocales.first;
        }
        for (Locale supportedLocale in supportedLocales) {
          //print (supportedLocale.languageCode);
          //print (locale.languageCode);
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      title: 'Flutter i18n',
      home: new MyHomePage(),
    );
  }
}

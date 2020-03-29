import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './i18n.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedLang;

  void onLocaleChange(Locale locale) async {
    await i18n_delegate().load(locale);
    setState(() {
      //print("[DEBUG] onLocalChange " + locale.languageCode.toString());
      _saveLocale(locale.languageCode.toString());
    });
  }

  _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('lang');
    return Locale(lang);
  }

  void _saveLocale(String lang) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', lang);
  }

  @override
  void initState() {
    super.initState();
    _readState();
  }

  void _readState() async {
    this._fetchLocale().then((locale) async {
      Locale old_locale;
      if (locale == null)
        old_locale = Locale('en');
      else
        old_locale = locale;
      await i18n_delegate().load(old_locale);
      setState(() {
        _selectedLang = old_locale.languageCode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: new DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: Text('Lang'),
                  value: _selectedLang,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLang = newValue;
                      onLocaleChange(Locale(newValue));
                      print("[DEBUG] newValue : " + newValue.toString());
                    });
                  },
                  items: supportedLangs.map((location) {
                    return DropdownMenuItem(
                      child: Image.asset('assets/flags/' + location + '.png',
                          width: 32, height: 32),
                      value: location,
                    );
                  }).toList(),
                ), // DropdownButton
              ), // DropdownButtonHideUnderLine
            ), // Expanded
            Expanded(
              flex: 1,
              child: Text(
                i18n.of(context).trans('hello_world'),
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}

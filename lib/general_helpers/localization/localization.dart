import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


const String code = 'languageCode';

//languages code
const String english = 'en';
const String indonesia = 'id';

  Future<Locale> setLocale(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(code, languageCode);
    return _locale(languageCode);
  }

  Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString(code) ?? english;
    return _locale(languageCode);
  }

  Locale _locale(String languageCode) {
    switch (languageCode) {
      case english:
        return const Locale(english, '');
      case indonesia:
        return const Locale(indonesia, '');
      default:
        return const Locale(english, '');
    }
  }

  AppLocalizations translation(BuildContext context) {
    return AppLocalizations.of(context)!;
  }


import 'package:flutter/material.dart';
import 'package:news_flutter_block/res/strings/english_strings.dart';
import 'package:news_flutter_block/res/strings/hindi_strings.dart';
import 'package:news_flutter_block/res/strings/strings.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Strings> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<Strings> load(Locale locale) => _load(locale);

  static Future<Strings> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return EnglishStrings();
      case 'hi':
        return HindiStrings();
      default:
        return EnglishStrings();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Strings> old) => false;
  
}
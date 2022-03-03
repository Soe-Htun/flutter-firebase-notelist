import 'package:flutter/material.dart';
import 'package:flutter_firebase_notelist/lang/en_us.dart';
import 'package:flutter_firebase_notelist/lang/my_mm.dart';
import 'package:get/get.dart';
import 'dart:ui';

// class LangController extends GetxController {
//   void changeLanguage(var language, var country){
//     var locale = Locale(language,country);
//     Get.updateLocale(locale);
//   }
// }

class LangService extends Translations {
  static final locale = Locale('my', 'MM');

  static final callBackLocale = Locale('en', 'US');

  // for display dropdown
  static final langs = [
    'Myanmar',
    'English',
  ];

  // support langs
  static final locales = [
    Locale('my', 'MM'),
    Locale('en', 'US'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'my_MM' : my,
    'en_US' : en,
  };

  Locale? getLocaleFromLang(String lang) {
    for(int i = 0; i< langs.length; i++) {
      if(lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
  void changeLanguage(String lang) {
    final locale = getLocaleFromLang(lang);
    Get.updateLocale(locale!);
  }
}
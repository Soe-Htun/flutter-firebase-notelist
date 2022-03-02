import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LangController extends GetxController {
  void changeLanguage(var language, var country){
    var locale = Locale(language,country);
    Get.updateLocale(locale);
  }
}
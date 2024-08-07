
import 'package:animattio_mobile_app/localization/en.dart';
import 'package:animattio_mobile_app/localization/pl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalizationService extends Translations{
  static final locale = Locale('en', '');
  static final fallBackLocale = Locale('en', '');
  static final languages = ['English', 'Polish'];
  static final locales = [Locale('en', ''),Locale('pl', '')];
  
  @override
  Map<String, Map<String, String>> get keys => {
  'en':en, 'pl': pl
};

void changeLocale(String language){
  final locale = getLocaleFromLanguage(language);
  final box = GetStorage();
  box.write('language', language);
  Get.updateLocale(locale!);
}
  
Locale? getLocaleFromLanguage(String language){
  for(int i=0; i < languages.length; i++){
if(language == languages[i]) return locales[i];
  }
  return Get.locale;
}
Locale getCurrentLocale(){
  final box = GetStorage();
  Locale defaultLocale;

  if(box.read('language') != null){
    final locale = getLocaleFromLanguage(box.read('language'));

    defaultLocale = locale!;
  }else{
    defaultLocale = Locale('en',''); //default language
  }
  return defaultLocale;
}

String getCurrentLanguage(){
  final box = GetStorage();
  return box.read('language') ?? 'English'; 
}
  
  }
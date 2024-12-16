import 'package:animattio_mobile_app/localization/en.dart';
import 'package:animattio_mobile_app/localization/pl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// A [LocalizationService] is a service that manages localization settings.
///
/// The [LocalizationService] class extends [Translations] and provides methods to
/// switch between available languages and update the application's locale based on user preferences.
///  It uses GetX's state management and storage to allow language switching across the whole app.
///
/// **Key Fields:**
/// - [locale]: The default locale.
/// - [fallBackLocale]: Locale used when the wanted locale is unavailable.
/// - [languages]: A list of available languages.
/// - [locales]: A list of corresponding [Locale] objects for each language.
///
class LocalizationService extends Translations {
  static final locale = Locale('en', '');
  static final fallBackLocale = Locale('en', '');
  static final languages = ['English', 'Polish'];
  static final locales = [Locale('en', ''), Locale('pl', '')];

  @override
  Map<String, Map<String, String>> get keys => {'en': en, 'pl': pl};

  /// [changeLocale] method changes the application's locale to the specified language.
  ///
  /// This method updates the locale by calling [getLocaleFromLanguage] with the provided [language].
  /// It saves the selected language in local storage with [GetStorage] and updates the
  /// current locale for the application using [Get.updateLocale].
  ///
  /// - [language]: The name of the new app language.
  void changeLocale(String language) {
    final locale = getLocaleFromLanguage(language);
    final box = GetStorage();
    box.write('language', language);
    Get.updateLocale(locale!);
  }

  /// [getLocaleFromLanguage] retrieves the corresponding [Locale] object based on the provided [language].
  ///
  /// - Returns: The [Locale] associated with the language.
  ///
  Locale? getLocaleFromLanguage(String language) {
    for (int i = 0; i < languages.length; i++) {
      if (language == languages[i]) return locales[i];
    }
    return Get.locale;
  }

  /// [getCurrentLocale] retrieves the currently selected locale.
  ///
  /// This method returns the corresponding [Locale] to the language that was fetched from storage.
  /// If no language is saved, it defaults to English.
  ///
  /// - Returns: The current [Locale] based on saved preferences or the default locale.
  Locale getCurrentLocale() {
    final box = GetStorage();
    Locale defaultLocale;

    if (box.read('language') != null) {
      final locale = getLocaleFromLanguage(box.read('language'));

      defaultLocale = locale!;
    } else {
      defaultLocale = Locale('en', '');
    }
    return defaultLocale;
  }

  /// [getCurrentLanguage] retrieves the current language.
  ///
  /// This method reads the saved language from local storage.
  ///  If no language is saved the default is 'English'.
  ///
  /// - Returns: The current language as a string or the default language.
  String getCurrentLanguage() {
    final box = GetStorage();
    return box.read('language') ?? 'English';
  }
}

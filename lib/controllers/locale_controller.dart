import 'package:animattio_mobile_app/services/localization_service.dart';
import 'package:get/get.dart';

/// A [LanguageController] is a controller that manages the current locale and allows user to swap language of the whole app.
///
/// The [LanguageController] class allows the user to change the app's language using [GetxController]
/// and ensures the chosen language is applied across all of the app pages.
///
/// This controller interacts with the [LocalizationService] to modify and get the current locale.
///
class LanguageController extends GetxController {
  var currentLocale = LocalizationService().getCurrentLocale().obs;

  /// [swapLanguages] swaps the current language between English and Polish, updating the app's locale.
  ///
  /// This method checks the current chosen language using [LocalizationService].
  /// It updates the [currentLocale] with the appropriate new value
  /// ensuring that the language change is visible on the whole app.
  ///
  void swapLanguages() {
    /// [currentLanguage] allows the UI to update when the language changes.
    var currentLanguage = LocalizationService().getCurrentLanguage();
    if (currentLanguage == 'English') {
      LocalizationService().changeLocale('Polish');
      currentLocale.value =
          LocalizationService().getLocaleFromLanguage('Polish')!;
    } else {
      LocalizationService().changeLocale('English');
      currentLocale.value =
          LocalizationService().getLocaleFromLanguage('English')!;
    }
  }
}

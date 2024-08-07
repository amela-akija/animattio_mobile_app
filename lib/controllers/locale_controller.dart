import 'package:animattio_mobile_app/services/localization_service.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var currentLocale = LocalizationService().getCurrentLocale().obs;

  //allows chosen language on all of the pages

  void swapLanguages() {
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

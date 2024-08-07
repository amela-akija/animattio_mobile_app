import 'package:animattio_mobile_app/localization/localization_service.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  var currentLocale = LocalizationService().getCurrentLocale().obs;

  void swapLanguages() {
    var currentLanguage = LocalizationService().getCurrentLanguage();
    if (currentLanguage == 'English') {
      LocalizationService().changeLocale('Polish');
      currentLocale.value = LocalizationService().getLocaleFromLanguage('Polish')!;
    } else {
      LocalizationService().changeLocale('English');
      currentLocale.value = LocalizationService().getLocaleFromLanguage('English')!;
    }
  }
}

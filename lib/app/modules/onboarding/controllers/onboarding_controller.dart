import 'package:get/get.dart';
import 'package:medi/app/routes/app_pages.dart';
import 'package:medi/app/core/helper/print_log.dart';

import '../../../../generated/assets.dart';
import '../../../core/helper/language_helper.dart';
import '../../../core/helper/shared_value_helper.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  var selectedLang = 'en'.obs;

  final List<Map<String, String>> languages = [
    {"value": "", "text": "Select an option"},
    {"value": "am", "text": "Amharic"},
    {"value": "ar", "text": "Arabic"},
    {"value": "hy", "text": "Armenian"},
    {"value": "eu", "text": "Basque"},
    {"value": "bn", "text": "Bengali"},
    {"value": "bg", "text": "Bulgarian"},
    {"value": "my", "text": "Burmese"},
    {"value": "ca", "text": "Catalan"},
    {"value": "zh", "text": "Chinese (Simplified)"},
    {"value": "hr", "text": "Croatian"},
    {"value": "cs", "text": "Czech"},
    {"value": "da", "text": "Danish"},
    {"value": "nl", "text": "Dutch"},
    {"value": "en", "text": "English"},
    {"value": "ja", "text": "Japanese"},
    {"value": "fi", "text": "Finnish"},
    {"value": "fr", "text": "French"},
    {"value": "ka", "text": "Georgian"},
    {"value": "de", "text": "German"},
    {"value": "el", "text": "Greek"},
    {"value": "he", "text": "Hebrew"},
    {"value": "hi", "text": "Hindi"},
    {"value": "hu", "text": "Hungarian"},
    {"value": "is", "text": "Icelandic"},
    {"value": "id", "text": "Indonesian"},
    {"value": "it", "text": "Italian"},
    {"value": "km", "text": "Khmer"},
    {"value": "ko", "text": "Korean"},
    {"value": "lo", "text": "Lao"},
    {"value": "mt", "text": "Maltese"},
    {"value": "mn", "text": "Mongolian"},
    {"value": "ne", "text": "Nepali"},
    {"value": "no", "text": "Norwegian"},
    {"value": "fa", "text": "Persian"},
    {"value": "pl", "text": "Polish"},
    {"value": "pt", "text": "Portuguese"},
    {"value": "ro", "text": "Romanian"},
    {"value": "ru", "text": "Russian"},
    {"value": "sr", "text": "Serbian"},
    {"value": "si", "text": "Sinhala"},
    {"value": "sk", "text": "Slovak"},
    {"value": "sl", "text": "Slovenian"},
    {"value": "es", "text": "Spanish"},
    {"value": "sw", "text": "Swahili"},
    {"value": "sv", "text": "Swedish"},
    {"value": "tl", "text": "Filipino"},
    {"value": "th", "text": "Thai"},
    {"value": "tr", "text": "Turkish"},
    {"value": "uk", "text": "Ukrainian"},
    {"value": "ur", "text": "Urdu"},
    {"value": "vi", "text": "Vietnamese"},
  ];

  final List<Map<String, String>> pages = [
    {
      'image': Assets.onboarding1,
      'title': 'onboarding.title1',
      'subtitle': 'onboarding.subtitle1',
    },
    {
      'image': Assets.onboarding2,
      'title': 'onboarding.title2',
      'subtitle': 'onboarding.subtitle2',
    },
    {
      'image': Assets.onboarding3,
      'title': 'onboarding.title3',
      'subtitle': 'onboarding.subtitle3',
    },
  ];

  void setLanguage(String lang) {
    selectedLang.value = lang;
    printLog('Saved language: $lang');
    selectedLanguage.$ = lang;
    selectedLanguage.save();
    LocalizationService.changeLocale(lang);
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      currentPage.value++;
    }
  }

  void finishOnboarding() async {
    onBoardView.$ = false;
    onBoardView.save();
    Get.offAllNamed(Routes.LOGIN);
  }
}

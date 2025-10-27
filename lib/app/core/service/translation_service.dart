import 'package:translator/translator.dart';
import 'package:get/get.dart';
import '../helper/print_log.dart';

class TranslationService {
  static final GoogleTranslator _translator = GoogleTranslator();

  // Map country codes to language codes
  static const Map<String, String> countryToLanguage = {
    'US': 'en', 'GB': 'en', 'AU': 'en', 'CA': 'en', 'NZ': 'en', 'IE': 'en',
    'ES': 'es', 'MX': 'es', 'AR': 'es', 'CO': 'es', 'PE': 'es', 'VE': 'es',
    'FR': 'fr', 'BE': 'fr', 'CH': 'fr', 'LU': 'fr', 'MC': 'fr',
    'DE': 'de', 'AT': 'de', 'LI': 'de',
    'IT': 'it', 'SM': 'it', 'VA': 'it',
    'PT': 'pt', 'BR': 'pt',
    'RU': 'ru', 'BY': 'ru', 'KZ': 'ru',
    'CN': 'zh', 'TW': 'zh', 'HK': 'zh', 'SG': 'zh',
    'JP': 'ja',
    'KR': 'ko',
    'IN': 'hi', 'BD': 'bn', 'PK': 'ur',
    'SA': 'ar', 'AE': 'ar', 'EG': 'ar', 'MA': 'ar', 'DZ': 'ar', 'JO': 'ar',
    'TR': 'tr',
    'GR': 'el',
    'NL': 'nl',
    'SE': 'sv', 'NO': 'no', 'DK': 'da', 'FI': 'fi',
    'PL': 'pl', 'CZ': 'cs', 'SK': 'sk', 'HU': 'hu',
    'RO': 'ro', 'BG': 'bg', 'HR': 'hr', 'SI': 'sl',
    'LT': 'lt', 'LV': 'lv', 'EE': 'et',
    'TH': 'th', 'VN': 'vi', 'MY': 'ms', 'ID': 'id',
    'PH': 'tl', 'MM': 'my',
    'ET': 'am', 'KE': 'sw', 'TZ': 'sw',
    'IL': 'he', 'AM': 'hy', 'GE': 'ka',
    'UZ': 'uz', 'KG': 'ky', 'TJ': 'tg', 'TM': 'tk',
    'AF': 'ps', 'IR': 'fa',
    'NP': 'ne', 'LK': 'si', 'MV': 'dv',
    'MN': 'mn', 'KH': 'km', 'LA': 'lo',
    'EU': 'eu', // Basque (Spain/France)
  };

  /// Get language code from country code
  static String getLanguageFromCountry(String countryCode) {
    return countryToLanguage[countryCode.toUpperCase()] ?? 'en';
  }

  /// Translate a single text string
  static Future<String> translateText(String text, String countryCode) async {
    try {
      if (text.isEmpty) return text;

      final targetLanguage = getLanguageFromCountry(countryCode);

      // Skip translation if target language is English
      if (targetLanguage == 'en') return text;

      printLog('Translating "$text" to $targetLanguage');

      final translation = await _translator.translate(text, to: targetLanguage);
      printLog('Translation result: ${translation.text}');

      return translation.text;
    } catch (e) {
      printLog('Translation error: $e');
      return text; // Return original text if translation fails
    }
  }

  /// Translate multiple texts
  static Future<List<String>> translateTexts(
    List<String> texts,
    String countryCode,
  ) async {
    try {
      final targetLanguage = getLanguageFromCountry(countryCode);

      // Skip translation if target language is English
      if (targetLanguage == 'en') return texts;

      List<String> translatedTexts = [];

      for (String text in texts) {
        if (text.isEmpty) {
          translatedTexts.add(text);
          continue;
        }

        final translation = await _translator.translate(
          text,
          to: targetLanguage,
        );
        translatedTexts.add(translation.text);
      }

      return translatedTexts;
    } catch (e) {
      printLog('Batch translation error: $e');
      return texts; // Return original texts if translation fails
    }
  }

  /// Translate a map of key-value pairs (useful for medical data)
  static Future<Map<String, String>> translateMap(
    Map<String, String> data,
    String countryCode,
  ) async {
    try {
      final targetLanguage = getLanguageFromCountry(countryCode);

      // Skip translation if target language is English
      if (targetLanguage == 'en') return data;

      Map<String, String> translatedData = {};

      for (var entry in data.entries) {
        if (entry.value.isEmpty) {
          translatedData[entry.key] = entry.value;
          continue;
        }

        final translatedValue = await translateText(entry.value, countryCode);
        translatedData[entry.key] = translatedValue;
      }

      return translatedData;
    } catch (e) {
      printLog('Map translation error: $e');
      return data; // Return original data if translation fails
    }
  }

  /// Check if translation is needed based on country code
  static bool shouldTranslate(String countryCode) {
    final targetLanguage = getLanguageFromCountry(countryCode);
    return targetLanguage != 'en';
  }

  /// Get language name from country code
  static String getLanguageName(String countryCode) {
    final languageCode = getLanguageFromCountry(countryCode);
    const languageNames = {
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
      'it': 'Italian',
      'pt': 'Portuguese',
      'ru': 'Russian',
      'zh': 'Chinese',
      'ja': 'Japanese',
      'ko': 'Korean',
      'hi': 'Hindi',
      'bn': 'Bengali',
      'ur': 'Urdu',
      'ar': 'Arabic',
      'tr': 'Turkish',
      'el': 'Greek',
      'nl': 'Dutch',
      'sv': 'Swedish',
      'no': 'Norwegian',
      'da': 'Danish',
      'fi': 'Finnish',
      'pl': 'Polish',
      'cs': 'Czech',
      'sk': 'Slovak',
      'hu': 'Hungarian',
      'ro': 'Romanian',
      'bg': 'Bulgarian',
      'hr': 'Croatian',
      'sl': 'Slovenian',
      'th': 'Thai',
      'vi': 'Vietnamese',
      'ms': 'Malay',
      'id': 'Indonesian',
      'tl': 'Filipino',
      'my': 'Myanmar',
      'am': 'Amharic',
      'sw': 'Swahili',
      'he': 'Hebrew',
      'hy': 'Armenian',
      'ka': 'Georgian',
      'eu': 'Basque',
    };
    return languageNames[languageCode] ?? 'English';
  }
}

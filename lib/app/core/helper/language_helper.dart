import 'dart:ui';
import 'package:get/get.dart';
import '../../core/translations/en_us.dart';
import '../../core/translations/ja_jp.dart';
import '../../core/translations/bn_bd.dart';
import '../../core/translations/ar_sa.dart';
import '../../core/translations/am_et.dart';
import '../../core/translations/bg_bg.dart';
import '../../core/translations/ca_es.dart';
import '../../core/translations/cs_cz.dart';
import '../../core/translations/da_dk.dart';
import '../../core/translations/de_de.dart';
import '../../core/translations/es_es.dart';
import '../../core/translations/eu_es.dart';
import '../../core/translations/fi_fi.dart';
import '../../core/translations/fr_fr.dart';
import '../../core/translations/hi_in.dart';
import '../../core/translations/hr_hr.dart';
import '../../core/translations/hy_am.dart';
import '../../core/translations/it_it.dart';
import '../../core/translations/ko_kr.dart';
import '../../core/translations/my_mm.dart';
import '../../core/translations/nl_nl.dart';
import '../../core/translations/pt_pt.dart';
import '../../core/translations/ru_ru.dart';
import '../../core/translations/th_th.dart';
import '../../core/translations/vi_vn.dart';
import '../../core/translations/zh_cn.dart';
import 'shared_value_helper.dart';

class LocalizationService extends Translations {
  static const locale = Locale('en', 'US');
  static const fallbackLocal = Locale('en', 'US');

  static final language = [
    'en',
    'ar',
    'bg',
    'bn',
    'ca',
    'cs',
    'da',
    'de',
    'es',
    'eu',
    'fi',
    'fr',
    'hi',
    'hr',
    'hy',
    'it',
    'ja',
    'ko',
    'my',
    'nl',
    'pt',
    'ru',
    'th',
    'vi',
    'zh',
  ];

  static final locals = [
    const Locale('en', 'US'),
    const Locale('ar', 'SA'),
    const Locale('bg', 'BG'),
    const Locale('bn', 'BD'),
    const Locale('ca', 'ES'),
    const Locale('cs', 'CZ'),
    const Locale('da', 'DK'),
    const Locale('de', 'DE'),
    const Locale('es', 'ES'),
    const Locale('eu', 'ES'),
    const Locale('fi', 'FI'),
    const Locale('fr', 'FR'),
    const Locale('hi', 'IN'),
    const Locale('hr', 'HR'),
    const Locale('hy', 'AM'),
    const Locale('it', 'IT'),
    const Locale('ja', 'JP'),
    const Locale('ko', 'KR'),
    const Locale('my', 'MM'),
    const Locale('nl', 'NL'),
    const Locale('pt', 'PT'),
    const Locale('ru', 'RU'),
    const Locale('th', 'TH'),
    const Locale('vi', 'VN'),
    const Locale('zh', 'CN'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'ar_SA': arSa,
    'bg_BG': bgBg,
    'bn_BD': bd,
    'ca_ES': caEs,
    'cs_CZ': csCz,
    'da_DK': daDk,
    'de_DE': deDe,
    'es_ES': esEs,
    'eu_ES': euEs,
    'fi_FI': fiFi,
    'fr_FR': frFr,
    'hi_IN': hiIn,
    'hr_HR': hrHr,
    'hy_AM': hyAm,
    'it_IT': itIt,
    'ja_JP': ja,
    'ko_KR': koKr,
    'my_MM': myMm,
    'nl_NL': nlNl,
    'pt_PT': ptPt,
    'ru_RU': ruRu,
    'th_TH': thTh,
    'vi_VN': viVn,
    'zh_CN': zhCn,
  };

  static void changeLocale(String lang) {
    final local = _getLanguageFromLanguage(lang);
    Get.updateLocale(local);
  }

  static Locale _getLanguageFromLanguage(String lang) {
    for (int i = 0; i < language.length; i++) {
      if (lang == language[i]) {
        return locals[i];
      }
    }
    return Get.locale ?? locale;
  }

  static Locale getInitialLocale() {
    selectedLanguage.load();
    final lang = selectedLanguage.$;
    for (int i = 0; i < language.length; i++) {
      if (lang == language[i]) {
        return locals[i];
      }
    }
    return locale;
  }
}

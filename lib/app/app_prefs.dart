import 'package:moro_shop/app/cache_helper.dart';
import 'package:moro_shop/presentation/resources/language_manager.dart';


const String langKey = 'lang_key';
const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";
const String prefsKeyOnBoardingScreenViewed =
    "PREFS_KEY_ON_BOARDING_SCREEN_VIEWED";
const String prefsKeySaveToken = "PREFS_KEY_SAVE_TOKEN";

class AppPreferences {

  static String getAppLanguage() {
    String? language = CacheHelper.getData(key: langKey)??'';

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  static Future<void> setUserLoggedIn() async {
    await CacheHelper.saveData(key: prefsKeyIsUserLoggedIn, value: true);
  }

  static Future<bool> isUserLoggedIn() async {
    return CacheHelper.getData(key: prefsKeyIsUserLoggedIn)??false;
  }

  static Future<void> setIntroScreenViewed() async {
    await CacheHelper.saveData(key: prefsKeyOnBoardingScreenViewed, value: true);
  }

  static Future<bool> isIntroScreenViewed() async {
    return CacheHelper.getData(key: prefsKeyOnBoardingScreenViewed)??false;
  }

  static Future<void> logout() async {
    await CacheHelper.removeData(key: prefsKeyIsUserLoggedIn);
    await CacheHelper.removeData(key: prefsKeySaveToken);
  }

  static Future<void> saveToken(String token) async {
    await CacheHelper.saveData(key: prefsKeySaveToken, value: token);
  }

  static String getToken() {
    return CacheHelper.getData(key: prefsKeySaveToken)??'';
  }
}

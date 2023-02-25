import 'package:moro_shop/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String langKey = 'lang_key';
const String prefsKeyIsUserLoggedIn = "PREFS_KEY_IS_USER_LOGGED_IN";


class AppPreferences {
  final SharedPreferences _sharedPreferences ;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(langKey);

        if(language != null && language.isNotEmpty){
          return language;
        }else{
          return LanguageType.english.getValue();
        }
  }

  Future<void> setUserLoggedIn() async{
    _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async{
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(prefsKeyIsUserLoggedIn);
  }
}
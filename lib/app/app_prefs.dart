import 'package:moro_shop/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String langKey = 'lang_key';

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
}
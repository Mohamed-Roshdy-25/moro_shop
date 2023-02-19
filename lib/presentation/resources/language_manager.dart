const String arabic = 'ar';
const String english = 'en';

enum LanguageType {
  arabic,
  english,
}

extension LanguageTypeExtension on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;
    }
  }
}
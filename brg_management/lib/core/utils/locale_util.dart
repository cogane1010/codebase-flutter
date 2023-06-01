import 'dart:ui';
import 'package:brg_management/core/shared_preferences/shared_preferences.dart';

Future<Locale> checkLocale() async {
  Locale _locale = Locale('vi', 'VN');
  SharedPreferences sharedPreferences = SharedPreferences.instance;

  if (await sharedPreferences.currentLanguage == null ||
      await sharedPreferences.currentLanguage == 'vi') {
    _locale = Locale('vi', 'VN');
  } else {
    _locale = Locale('en', 'US');
  }
  return _locale;
}

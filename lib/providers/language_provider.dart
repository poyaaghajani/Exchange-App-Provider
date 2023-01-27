import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  Locale locale = const Locale('en');

  bool get isPersian => locale == const Locale('fa');

  void toggleLanguageEn() {
    locale =
        locale == const Locale('en') ? const Locale('en') : const Locale('en');
    notifyListeners();
  }

  void toggleLanguagePer() {
    locale =
        locale == const Locale('fa') ? const Locale('fa') : const Locale('fa');
    notifyListeners();
  }
}

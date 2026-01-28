import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('pt'); 

  Locale get currentLocale => _currentLocale;

  void changeLanguage(Locale newLocale) {
    _currentLocale = newLocale;
    notifyListeners(); 
  }
}
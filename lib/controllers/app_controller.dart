import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

class AppController extends ChangeNotifier {
  // Singleton
  static AppController instance = AppController();

  bool isDarkTheme = false;
  final String _keyTheme = 'isDarkTheme'; 

  // Método para carregar o tema salvo quando o app abre
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // Tenta pegar o valor salvo. Se não tiver nada (primeira vez), usa false (Claro)
    isDarkTheme = prefs.getBool(_keyTheme) ?? false; 
    notifyListeners();
  }

  // Método para trocar e salvar
  void changeTheme() async {
    isDarkTheme = !isDarkTheme; 
    notifyListeners(); 

    // Salva na memória do celular em segundo plano
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyTheme, isDarkTheme);
  }
}
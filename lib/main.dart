import 'package:flutter/material.dart';
import 'package:loumar/app_widget.dart'; 
import 'package:loumar/controllers/app_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  
  //Garante que o motor do Flutter esteja pronto antes de carregar dados
  WidgetsFlutterBinding.ensureInitialized(); 

  // Carrega o tema salvo na memória
  await AppController.instance.loadTheme();

  final prefs = await SharedPreferences.getInstance();
  final bool isLogged = prefs.getBool('isLogged') ?? false;

  // Só depois de carregar, roda o App
  runApp(MyApp(isLogged: isLogged));
}
import 'package:flutter/material.dart';
import 'package:loumar/app_widget.dart'; 
import 'package:loumar/controllers/app_controller.dart';
import 'package:loumar/pages/login_page.dart'; 

void main() async {
  
  //Garante que o motor do Flutter esteja pronto antes de carregar dados
  WidgetsFlutterBinding.ensureInitialized(); 

  // Carrega o tema salvo na memória
  await AppController.instance.loadTheme();

  // Só depois de carregar, roda o App
  runApp(const MyApp());
}
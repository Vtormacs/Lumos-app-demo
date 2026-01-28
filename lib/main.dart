import 'package:flutter/material.dart';
import 'package:loumar/app_widget.dart'; 
import 'package:loumar/controllers/app_controller.dart';
import 'package:loumar/controllers/language_controller.dart';
import 'package:loumar/service/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  
  //Garante que o motor do Flutter esteja pronto antes de carregar dados
  WidgetsFlutterBinding.ensureInitialized(); 

  await initializeDateFormatting('pt_BR', null);

  await NotificationService().init();

  // Carrega o tema salvo na memória
  await AppController.instance.loadTheme();

  final prefs = await SharedPreferences.getInstance();
  final bool isLogged = prefs.getBool('isLogged') ?? false;

 runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MyApp(isLogged: isLogged),
    ),
  );
}
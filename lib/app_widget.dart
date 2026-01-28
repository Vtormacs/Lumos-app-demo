import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loumar/controllers/language_controller.dart';
import 'package:loumar/l10n/app_localizations.dart';
import 'package:provider/provider.dart'; 

import 'package:loumar/controllers/app_controller.dart';
import 'package:loumar/main_screen.dart';
import 'package:loumar/pages/login/onboarding_page.dart'; 

class MyApp extends StatelessWidget {
  final String titulo = 'App Loumar';
  final bool isLogged;

  const MyApp({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    // 1. O AnimatedBuilder escuta o tema (AppController)
    return AnimatedBuilder(
      animation: AppController.instance, 
      builder: (context, child) {
        
        // 2. O Consumer escuta o idioma (LanguageProvider)
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: titulo,

              // --- CONFIGURAÇÃO DE IDIOMA ---
              // Define o idioma atual baseado no Provider
              locale: languageProvider.currentLocale, 
              
              // Define os tradutores (Delegates)
              localizationsDelegates: const [
                AppLocalizations.delegate, // O arquivo gerado pelo Flutter
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              
              // Define quais idiomas o app suporta
              supportedLocales: const [
                Locale('pt'), // Português
                Locale('en'), // Inglês
                Locale('es'), // Espanhol (adicione se tiver o arquivo .arb)
              ],
              // ------------------------------

              // Sua configuração de tema existente
              theme: AppController.instance.isDarkTheme 
                  ? ThemeData.dark() 
                  : ThemeData.light(),
              
              home: isLogged ? const MainScreen() : const OnboardingPage(),
            );
          },
        );
      },
    );
  }
}
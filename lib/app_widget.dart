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
    return AnimatedBuilder(
      animation: AppController.instance, 
      builder: (context, child) {
        
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: titulo,

              locale: languageProvider.currentLocale, 
              
              localizationsDelegates: const [
                AppLocalizations.delegate, 
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              
              supportedLocales: const [
                Locale('pt'), // Português
                Locale('en'), // Inglês
                Locale('es'), // Espanhol (adicione se tiver o arquivo .arb)
              ],

              theme: AppController.instance.isDarkTheme 
                  ? ThemeData.dark() 
                  : ThemeData.light(),
              
              home: isLogged ?  MainScreen() : const OnboardingPage(),
            );
          },
        );
      },
    );
  }
}
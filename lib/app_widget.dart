import 'package:flutter/material.dart';
import 'package:loumar/controllers/app_controller.dart';
import 'package:loumar/main_screen.dart';
import 'package:loumar/pages/onboarding_page.dart'; 

class MyApp extends StatelessWidget {
  final String titulo = 'App Flutter';

  final bool isLogged;

  const MyApp({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance, 
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          
          theme: AppController.instance.isDarkTheme 
              ? ThemeData.dark() 
              : ThemeData.light(),
              
          home: isLogged ? const MainScreen() : const OnboardingPage(),
        );
      },
    );
  }
}
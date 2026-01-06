import 'package:flutter/material.dart';
import 'package:loumar/controllers/app_controller.dart';
import 'package:loumar/main_screen.dart'; 

class MeuApp extends StatelessWidget {
  final String titulo = 'App Flutter';

  const MeuApp({super.key});

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
              
          home: const MainScreen(),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:loumar/main_screen.dart'; 

class MeuApp extends StatelessWidget {
  final String titulo = 'App Flutter';

  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}
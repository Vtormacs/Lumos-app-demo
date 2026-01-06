import 'package:flutter/material.dart';
import 'package:loumar/main_screen.dart'; // Importe o arquivo novo

class MeuApp extends StatelessWidget {
  final String titulo = 'App Flutter';

  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Note que troquei HomePage por MainScreen aqui
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const MainScreen(),
    );
  }
}
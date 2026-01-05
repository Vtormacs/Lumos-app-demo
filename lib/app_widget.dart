import 'package:flutter/material.dart';
import 'package:loumar/home/home_page.dart';

class MeuApp extends StatelessWidget {
  final String titulo = 'App Flutter';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: HomePage());
  }
}
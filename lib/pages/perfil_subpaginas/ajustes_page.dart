import 'package:flutter/material.dart';
import 'package:loumar/controllers/app_controller.dart';

class AjustesPage extends StatefulWidget {
  const AjustesPage({super.key});

  @override
  State<AjustesPage> createState() => _AjustesPageState();
}

class _AjustesPageState extends State<AjustesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, 

      appBar: AppBar(
        backgroundColor: const Color(0xFF1D3B79), 
        title: const Text("Ajustes", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Tema Escuro"),
            const SizedBox(width: 10),
            Switch(
              value: AppController.instance.isDarkTheme, 
              
              onChanged: (bool value) {
                AppController.instance.changeTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SobreApp extends StatefulWidget {
  const SobreApp({super.key});

  @override
  State<SobreApp> createState() => _SobreAppState();
}

class _SobreAppState extends State<SobreApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, 

      appBar: AppBar(
        backgroundColor: const Color(0xFF1D3B79), 
        title: const Text("Sobre o App", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Loumar App\n\n"
                "Versão ---\n\n"
                "Desenvolvido por TR1.\n"
              ),
          ],
        ),
      ),
    );
  }
}
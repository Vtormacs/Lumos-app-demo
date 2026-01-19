import 'package:flutter/material.dart';

class SobreApp extends StatefulWidget {
  const SobreApp({super.key});

  @override
  _SobreAppState createState() => _SobreAppState();
}

class _SobreAppState extends State<SobreApp> {
  @override
  Widget build(BuildContext context) {
    final Color blueTop = const Color(0xFF1D3B79);
    final Color blueBottom = const Color(0xFF202F4D);

    return Scaffold(
      backgroundColor: blueBottom,

      body: Column(
        children: [
          // 1. CABEÇALHO AZUL
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [blueTop, blueBottom],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Sobre o App",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. CORPO BRANCO / LISTA
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Loumar App\n\n"
                    "Versão ---\n\n"
                    "Desenvolvido por TR1.\n",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

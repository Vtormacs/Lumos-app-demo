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
    final Color bgColor = const Color(0xFFFAFAFA);


    return Scaffold(
      body: Stack(
        children: [
          // 1. FUNDO GERAL 
         Container(
            height:
                MediaQuery.of(context).size.height *
                0.4, 
            width: double.infinity,
            color: blueTop,
            child: ClipRect(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Transform.translate(
                      offset: const Offset(0, -60),
                      child: Image.asset(
                        'assets/images/home/fundohome.jpg',
                        fit: BoxFit.cover,
                        opacity: const AlwaysStoppedAnimation(0.16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. CONTEÚDO (Título + Corpo Branco)
          Column(
            children: [
                SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 60,
                  child: Stack(
                    children: [
                      // Botão Voltar na Esquerda
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
                      
                      // Título Centralizado
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

              const SizedBox(height: 20),

              // 3. O CORPO BRANCO ARREDONDADO
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  
                   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Loumar App\n\n"
                    "Versão ---\n\n"
                    "Desenvolvido por TR1.\n",
                  ),
                ],
              ),
                  const SizedBox(height: 20),
                ],
              ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
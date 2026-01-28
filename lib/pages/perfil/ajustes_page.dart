import 'package:flutter/material.dart';
import 'package:loumar/controllers/language_controller.dart';
import 'package:provider/provider.dart'; 
import 'package:loumar/controllers/app_controller.dart';

class AjustesPage extends StatefulWidget {
  const AjustesPage({super.key});

  @override
  State<AjustesPage> createState() => _AjustesPageState();
}

class _AjustesPageState extends State<AjustesPage> {
  @override
  Widget build(BuildContext context) {
    final Color blueTop = const Color(0xFF1D3B79);
    final Color bgColor = const Color(0xFFFAFAFA);

    final languageProvider = context.watch<LanguageProvider>();
    final isPt = languageProvider.currentLocale.languageCode == 'pt';

    return Scaffold(
      body: Stack(
        children: [
          // 1. FUNDO GERAL
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
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
                          "Ajuste de App",
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
                        
                        // --- SWITCH DE TEMA ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tema Escuro",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Switch(
                              value: AppController.instance.isDarkTheme,
                              onChanged: (bool value) {
                                AppController.instance.changeTheme();
                              },
                              activeColor: blueTop,
                            ),
                          ],
                        ),

                        const Divider(height: 30), // Linha divisória

                        // --- SELETOR DE IDIOMA ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Idioma / Language",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            
                            // Botões de Troca
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  // Botão PT
                                  GestureDetector(
                                    onTap: () {
                                      languageProvider.changeLanguage(const Locale('pt'));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isPt ? blueTop : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "PT",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isPt ? Colors.white : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  // Botão EN
                                  GestureDetector(
                                    onTap: () {
                                      languageProvider.changeLanguage(const Locale('en'));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: !isPt ? blueTop : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "EN",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: !isPt ? Colors.white : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
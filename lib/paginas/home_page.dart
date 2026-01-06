import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. O Background gradiente (CSS: linear-gradient)
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1D3B79), // Do seu Figma
              Color(0xFF202F4D), // Do seu Figma
            ],
          ),
        ),
        child: Column(
          children: [
            // SafeArea garante que não fique embaixo do relógio/bateria
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- CABEÇALHO (Avatar + Nome + Sino) ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Avatar
                            const CircleAvatar(
                              radius: 22, // 44px / 2
                              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'), // Imagem temporária
                            ),
                            const SizedBox(width: 10),
                            // Textos de boas vindas
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Boas vindas,",
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                                Text(
                                  "Michelle Duarte! 👋",
                                  style: TextStyle(
                                    color: Colors.white, 
                                    fontSize: 16, 
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Botão de Notificação (Quadrado translúcido)
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(107, 122, 164, 0.47), // CSS: rgba(107, 122, 164, 0.47)
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.notifications_outlined, color: Colors.white),
                        )
                      ],
                    ),

                    const SizedBox(height: 30),

                    // --- AÇÕES RÁPIDAS (Grid de botões) ---
                    const Text(
                      "Ações Rápidas",
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    
                    // Linha com os 4 botões
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _botaoRapido(icon: "🗺️", label: "Guia do\nViajante"),
                        _botaoRapido(icon: "🌎", label: "Lorem\nIpsum"),
                        _botaoRapido(icon: "🇵🇾", label: "Busca\nParaguai"),
                        _botaoRapido(icon: "🛍️", label: "Minhas\nCompras"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // --- PARTE BRANCA INFERIOR ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24), // CSS: border-radius: 24px 24px 0px 0px
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Aqui virão as abas e o resto do conteúdo
                      Text("Conteúdo da Home...", style: TextStyle(color: Colors.grey[800])),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para criar os botões brancos quadrados
  Widget _botaoRapido({required String icon, required String label}) {
    return Column(
      children: [
        Container(
          width: 71, // Largura aproximada para caber 4 na tela
          height: 65,
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F0EF), // Cor do fundo do botão
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(icon, style: const TextStyle(fontSize: 24)), // Emoji temporário, depois trocamos por imagem
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.2),
        )
      ],
    );
  }
}
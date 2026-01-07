import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math; // Necessário para a matemática da rotação
import 'package:loumar/pages/login_page.dart'; // Importe sua página de login

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pegar o tamanho da tela para ajudar no posicionamento
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1. FUNDO GRADIENTE (CSS: linear-gradient)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1E3460), Color(0xFF00A2AE)],
              ),
            ),
          ),

          // 2. IMAGENS ROTACIONADAS (Vazando da tela)
          // Nota: Usei cores para ilustrar, troque 'color' por 'image: DecorationImage(...)'
          _buildRotatedCard(
            top: size.height * 0.3, left: -130, width: 165, height: 198, 
            imageUrl: 'https://picsum.photos/200/300' // Exemplo
          ),
          _buildRotatedCard(
            top: size.height * 0.25, left: 46, width: 213, height: 198, 
            imageUrl: 'https://picsum.photos/201/300'
          ),
          _buildRotatedCard(
            top: size.height * 0.18, left: 269, width: 213, height: 198, 
            imageUrl: 'https://picsum.photos/202/300'
          ),
          _buildRotatedCard(
            top: size.height * 0.47, left: -72, width: 494, height: 198, 
            imageUrl: 'https://picsum.photos/203/300'
          ),

          // 3. BASE BRANCA (Bottom Sheet Fixa)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 306, // Altura exata do Figma
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  children: [
                    // Indicadores (As bolinhas)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildDot(isActive: true),
                        const SizedBox(width: 4),
                        _buildDot(isActive: false),
                        const SizedBox(width: 4),
                        _buildDot(isActive: false),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Título (Montserrat)
                    Text(
                      "Sua viagem em Foz começa com a Loumar",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF252B37),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtítulo (Manrope)
                    Text(
                      "Seu app oficial para organizar passeios, compras e vantagens exclusivas.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF535862),
                      ),
                    ),
                    
                    const Spacer(), // Empurra o botão para baixo

                    // BOTÃO "ENTRAR"
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00A2AE), // Ciano
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          // Navegação para o Login
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        child: Text(
                          "Entrar",
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- COMPONENTES AUXILIARES ---

  // 1. Card Torto
  Widget _buildRotatedCard({
    required double top, 
    required double left, 
    required double width, 
    required double height, 
    required String imageUrl
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Transform.rotate(
        angle: -13.62 * (math.pi / 180), // Converte graus (-13.62) para radianos
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white, // Borda branca da foto (Polaroid style)
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          padding: const EdgeInsets.all(4), // Espessura da borda branca
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  // 2. Bolinhas de Paginação
  Widget _buildDot({required bool isActive}) {
    return Container(
      width: isActive ? 24 : 8,
      height: 4,
      decoration: BoxDecoration(
        // Se ativo: cor sólida. Se inativo: 50% opacidade.
        color: isActive ? const Color(0xFF00A2AE) : const Color(0xFF00A2AE).withOpacity(0.5),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
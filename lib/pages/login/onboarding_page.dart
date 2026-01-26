import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:loumar/pages/login/login_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    const double figmaDesignWidth = 375.0;
    
    final double centerX = (size.width - figmaDesignWidth) / 2;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none, 
        children: [
          // 1. FUNDO GRADIENTE
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1E3460), Color(0xFF00A2AE)],
              ),
            ),
          ),

          // 2. MOSAICO DE FOTOS
          _buildFigmaCard(offsetX: centerX, left: 109, top: -57.53, width: 299.17, height: 198.68, imagePath: 'assets/images/login/foto2.png'),
          _buildFigmaCard(offsetX: centerX, left: -84.03, top: 17, width: 182.77, height: 198.68, imagePath: 'assets/images/login/foto1.png'),
          _buildFigmaCard(offsetX: centerX, left: 269, top: 144, width: 213.75, height: 198.68, imagePath: 'assets/images/login/foto5.png'),
          _buildFigmaCard(offsetX: centerX, left: 46, top: 198.11, width: 213.75, height: 198.68, imagePath: 'assets/images/login/foto4.png'),
          _buildFigmaCard(offsetX: centerX, left: -130, top: 252.53, width: 165.25, height: 198.68, imagePath: 'assets/images/login/foto3.png'),
          _buildFigmaCard(offsetX: centerX, left: -70.61, top: 413.06, width: 494.26, height: 198.68, imagePath: 'assets/images/login/foto6.png'),

          // 3. BASE BRANCA RESPONSIVA
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              
              constraints: BoxConstraints(
                maxHeight: size.height * 0.5,
              ),
              
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(), 
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: SafeArea( 
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        // Indicadores
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     _buildDot(isActive: true),
                        //     const SizedBox(width: 4),
                        //     _buildDot(isActive: false),
                        //     const SizedBox(width: 4),
                        //     _buildDot(isActive: false),
                        //   ],
                        // ),
                        // const SizedBox(height: 24),

                        // Título
                        Text(
                          "Sua viagem em Foz começa com a Loumar",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF252B37),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Subtítulo
                        Text(
                          "Seu app oficial para organizar passeios, compras e vantagens exclusivas para viver Foz com leveza e tranquilidade.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF535862),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Botão Entrar
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00A2AE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text(
                              "Entrar",
                              style: TextStyle(
                                fontFamily: 'Manrope',
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
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS AUXILIARES
  Widget _buildFigmaCard({
    required double offsetX,
    required double left,
    required double top,
    required double width,
    required double height,
    required String imagePath,
  }) {
    return Positioned(
      left: left + offsetX, 
      top: top,
      child: Transform.rotate(
        angle: -13.62 * (math.pi / 180), 
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(4), 
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16), 
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12), 
            child: imagePath.isEmpty
                ? Container(color: Colors.grey[300], child: const Icon(Icons.image))
                : Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }


}
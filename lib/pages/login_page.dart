import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // extendBodyBehindAppBar permite que a imagem vá até o topo
      extendBodyBehindAppBar: true,

      // AppBar transparente apenas para o botão de voltar funcionar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Stack(
        children: [
          // 1. IMAGEM DE FUNDO 
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.35,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fundo_login.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter, 
                ),
              ),
            ),
          ),

          // 2. CARTÃO DE LOGIN 
          Positioned(
            top: size.height * 0.30,
            bottom: 0, 
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Puxador cinza
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 24),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // LOGO LOUMAR
                    Text(
                      "LOUMAR",
                      style: GoogleFonts.manrope(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF1E3460),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Títulos
                    Text(
                      "Que bom ter você por aqui",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF252B37),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Faça seu acesso para continuar sua jornada em Foz com a gente.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: const Color(0xFF414651),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Inputs
                    _buildCustomTextField(label: "CPF"),
                    const SizedBox(height: 16),
                    _buildCustomTextField(label: "Chave Loumar"),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Descobrir chave Loumar",
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF414651),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

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
                        onPressed: () {},
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

                    const SizedBox(height: 24),

                    // Divisor OU
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Color(0xFFE9EAEB))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text("OU", style: TextStyle(color: Colors.grey[500])),
                        ),
                        const Expanded(child: Divider(color: Color(0xFFE9EAEB))),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Botões do Rodapé
                    Row(
                      children: [
                        Expanded(
                          child: _buildOutlineButton(
                            icon: Icons.location_on_outlined,
                            text: "Onde estamos",
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildOutlineButton(
                            icon: Icons.chat_bubble_outline,
                            text: "Suporte",
                            onTap: () {},
                            isWhatsApp: true,
                          ),
                        ),
                      ],
                    ),
                    
                    // Um espacinho extra no final para garantir que o scroll vai até o fim
                    const SizedBox(height: 20),
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

  // 1. Campo de Texto Padrão (Figma)
  Widget _buildCustomTextField({required String label}) {
    return TextFormField(
      style: GoogleFonts.inter(fontSize: 16, color: const Color(0xFF181D27)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(color: const Color(0xFF717680)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        // Borda quando não clicado
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE9EAEB)),
        ),
        // Borda quando clicado (Foco)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF00A2AE), width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  // 2. Botão com Borda (Outline)
  Widget _buildOutlineButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isWhatsApp = false,
  }) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE9EAEB)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isWhatsApp ? Colors.green : const Color(0xFF1E3460),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w600, // SemiBold
                color: const Color(0xFF414651),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

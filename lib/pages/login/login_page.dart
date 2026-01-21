import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loumar/main_screen.dart';
import 'package:loumar/models/user_model.dart';
import 'package:loumar/widgets/LoumarKeyBottomSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 11) return oldValue;
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) formatted += '.';
      if (i == 9) formatted += '-';
      formatted += text[i];
    }
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();

  // Função para validar e entrar
  Future<void> _fazerLogin() async {
    String cpfLimpo = _cpfController.text.replaceAll(RegExp(r'[^0-9]'), '');
    String senha = _keyController.text;

    if (cpfLimpo == '11111111111' && senha == '123456') {
      UserModel user = UserModel.getUserTeste();

      //SALVAR NA MEMÓRIA DO CELULAR
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogged', true);
      await prefs.setString('userData', jsonEncode(user.toJson()));

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("CPF ou Chave inválidos! Tente novamente."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _keyController.dispose();
    super.dispose();
  }

  // Função para mostrar o bottom sheet
  void _showLoumarKeyBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return const LoumarKeyBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,

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
                  image: AssetImage('assets/images/login/fundo_login.png'),
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
                    // LOGO LOUMAR
                    Text(
                      "LOUMAR",
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        fontSize: 40,
                        color: const Color(0xFF1E3460),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Títulos
                    Text(
                      "Que bom ter você por aqui",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                        color: const Color(0xFF252b37),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Faça seu acesso para continuar sua jornada em Foz com a gente.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: const Color(0xFF414651),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Inputs
                    _buildCustomTextField(
                      label: "CPF",
                      controller: _cpfController,
                    ),
                    const SizedBox(height: 16),
                    _buildCustomTextField(
                      label: "Chave Loumar",
                      controller: _keyController,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _showLoumarKeyBottomSheet,
                        child: Text(
                          "Descobrir chave Loumar",
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF414651),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

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
                        onPressed: _fazerLogin,
                        child: Text(
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

                    const SizedBox(height: 10),

                    // Divisor OU
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(color: Color(0xFFE9EAEB)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "OU",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 114, 114, 114),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(color: Color(0xFFE9EAEB)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Botões do Rodapé
                    Row(
                      children: [
                        Expanded(
                          child: _buildOutlineButton(
                            svgAsset: 'assets/images/login/point.svg',
                            text: "Onde estamos",
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildOutlineButton(
                            svgAsset: 'assets/images/login/whatsapp.svg',
                            text: "Suporte",
                            onTap: () async {
                              final Uri whatsappUrl = Uri.parse(
                                'https://wa.me/554535214001?text=Olá,%20preciso%20de%20suporte%20no%20app%20da%20Loumar!',
                              );

                              if (await canLaunchUrl(whatsappUrl)) {
                                await launchUrl(
                                  whatsappUrl,
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Não foi possível abrir o WhatsApp. Verifique se está instalado.',
                                    ),
                                  ),
                                );
                              }
                            },
                            isWhatsApp: true,
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
    );
  }

  // --- COMPONENTES AUXILIARES ---

  // 1. Campo de Texto Padrão
  Widget _buildCustomTextField({
    required String label,
    required TextEditingController controller,
  }) {
    List<TextInputFormatter>? inputFormatters;
    TextInputType keyboardType = TextInputType.text;

    if (label == "CPF") {
      keyboardType = TextInputType.number;

      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        CpfInputFormatter(),
      ];
    }

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: false,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        color: const Color(0xFF181D27),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Inter',
          color: const Color(0xFF717680),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE9EAEB)),
        ),
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
    IconData? icon,
    String? svgAsset,
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
            if (svgAsset != null)
              SvgPicture.asset(svgAsset, width: 18, height: 18)
            else if (icon != null)
              Icon(
                icon,
                size: 18,
                color: isWhatsApp ? Colors.green : const Color(0xFF1E3460),
              ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF414651),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

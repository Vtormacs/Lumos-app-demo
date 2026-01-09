import 'package:flutter/material.dart';
import 'package:loumar/controllers/app_controller.dart';
import 'package:loumar/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loumar/models/user_model.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<UserModel?> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userData');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Verifica o tema atual
    bool isDarkTheme = AppController.instance.isDarkTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkTheme
                ? [AppColors.darkTop, AppColors.darkBottom]
                : [AppColors.blueTop, AppColors.blueBottom],
          ),
        ),
        child: Column(
          children: [
            // SafeArea garante que não fique embaixo do relógio/bateria
            SafeArea(
              bottom: false,

              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/background_home.jpg',
                    ), 
                    fit: BoxFit.cover,
                    //opacity: 0.8,
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- CABEÇALHO (Avatar + Nome + Sino) ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          

                          FutureBuilder<UserModel?>(
                            future: _loadUser(),
                            builder: (context, asyncSnapshot) {
                              String nome = "Usuário";
                              if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
                                nome = asyncSnapshot.data!.name;
                              }
                              return Row(
                                children: [
                                  // Avatar
                                  const CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                      'https://i.pravatar.cc/150?img=5',// Imagem temporária
                                    ), 
                                  ),
                                  const SizedBox(width: 10),
                                  // Textos de boas vindas
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Boas vindas,",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "$nome! 👋",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          ),
                          // Botão de Notificação 
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(107, 122, 164, 0.47),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset(
                              'assets/images/home/notificacaoVazia.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // --- AÇÕES RÁPIDAS (Grid de botões) ---
                      const Text(
                        "Ações Rápidas",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Linha com os 4 botões
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _botaoRapido(icon: "🗺️", label: "Guia do\nViajante"),
                          _botaoRapido(icon: "🌎", label: "Lorem\nIpsum"),
                          _botaoRapidoBusca(context: context, icon: "🇵🇾", label: "Busca\nParaguai", link: "https://www.google.com"),
                          _botaoRapido(icon: "🛍️", label: "Minhas\nCompras"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // --- PARTE BRANCA INFERIOR ---
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Conteúdo da Home...",
                        style: TextStyle(
                          color: isDarkTheme
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
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
          width: 69,
          height: 63,
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F0EF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(icon, style: const TextStyle(fontSize: 24)),
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            height: 1.2,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

Widget _botaoRapidoBusca({
  required BuildContext context,
  required String icon,
  required String label,
  String? link,  // Novo parâmetro opcional para o URL
}) {
  return GestureDetector(
    onTap: () async {
      if (link != null && link.isNotEmpty) {
        final Uri url = Uri.parse(link);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);  // Abre no browser externo
        } else {
          // Opcional: Mostre um erro se não puder abrir
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Não foi possível abrir o link: $link')),
            );
          }
        }
      }
    },
    child: Column(
      children: [
        Container(
          width: 69,
          height: 63,
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F0EF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(icon, style: const TextStyle(fontSize: 24)),
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            height: 1.2,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
}

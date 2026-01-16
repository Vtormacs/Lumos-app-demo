import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loumar/controllers/app_controller.dart';
import 'package:loumar/models/ticket_models.dart';
import 'package:loumar/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loumar/widgets/home_banner2.dart';
import 'package:loumar/widgets/ticket_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loumar/models/user_model.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:loumar/widgets/home_banner.dart';
import 'package:loumar/models/roteiro_model.dart';
import 'package:loumar/widgets/roteiro_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  int _selectedTab = 0;

  Future<UserModel?> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userData');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  final List<IngressoModel> _meusIngressos = MockData.getIngressos();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = AppController.instance.isDarkTheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                controller: _scrollController, 
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // --- PARTE SUPERIOR ---
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/home/fundohome.jpg'),
                              fit: BoxFit.cover,
                              opacity: 0.1,
                              filterQuality: FilterQuality.high
                            ),
                          ),
                          child: SafeArea(
                            bottom: false,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // CABEÇALHO
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      FutureBuilder<UserModel?>(
                                        future: _loadUser(),
                                        builder: (context, asyncSnapshot) {
                                          String nome = "Usuário";
                                          if (asyncSnapshot.hasData &&
                                              asyncSnapshot.data != null) {
                                            nome = asyncSnapshot.data!.name;
                                          }
                                          return Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
                                                    'https://i.pravatar.cc/150?img=5'),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                        },
                                      ),
                                      Container(
                                        width: 44,
                                        height: 44,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              107, 122, 164, 0.47),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/images/home/notificacaoVazia.svg',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                      height: constraints.maxHeight * 0.04),

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

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _botaoRapido(
                                          icon: "🗺️", label: "Guia do\nViajante"),
                                      _botaoRapido(
                                          icon: "🌎", label: "Lorem\nIpsum"),
                                      _botaoRapidoBusca(
                                        context: context,
                                        icon: "🇵🇾",
                                        label: "Busca\nParaguai",
                                        link: "https://www.buscaparaguai.com.br/",
                                      ),
                                      _botaoRapido(
                                          icon: "🛍️", label: "Minhas\nCompras"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // --- PARTE BRANCA INFERIOR ---
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isDarkTheme
                                  ? AppColors.darkBackground
                                  : const Color(0xFFFFFFFF),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 24, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ABAS
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Container(
                                      height: 44,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFAFAFA),
                                        border: Border.all(
                                            color: const Color(0xFFE9EAEB)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                     child: Row(
                                        children: [
                                          // --- ABA 1: INGRESSOS ---
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedTab = 0;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: _selectedTab == 0 
                                                      ? const Color(0xFFEFF8FF) 
                                                      : Colors.transparent,
                                                  borderRadius: BorderRadius.circular(6),
                                                  boxShadow: _selectedTab == 0 
                                                      ? const [
                                                          BoxShadow(
                                                            color: Color.fromRGBO(10, 13, 18, 0.1),
                                                            offset: Offset(0, 1),
                                                            blurRadius: 2,
                                                          )
                                                        ] 
                                                      : null,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Meus Ingressos (${_meusIngressos.length})",
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontWeight: _selectedTab == 0 ? FontWeight.w500 : FontWeight.w400,
                                                      fontSize: 14,
                                                      color: _selectedTab == 0 ? const Color(0xFF175CD3) : const Color(0xFF717680),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          
                                          // --- ABA 2: ROTEIROS ---
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedTab = 1;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: _selectedTab == 1 
                                                      ? const Color(0xFFEFF8FF) 
                                                      : Colors.transparent,
                                                  borderRadius: BorderRadius.circular(6),
                                                  boxShadow: _selectedTab == 1 
                                                      ? const [
                                                          BoxShadow(
                                                            color: Color.fromRGBO(10, 13, 18, 0.1),
                                                            offset: Offset(0, 1),
                                                            blurRadius: 2,
                                                          )
                                                        ] 
                                                      : null,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Meus Roteiros",
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontWeight: _selectedTab == 1 ? FontWeight.w500 : FontWeight.w400,
                                                      fontSize: 14,
                                                      color: _selectedTab == 1 ? const Color(0xFF175CD3) : const Color(0xFF717680),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 24),

                                  // --- CONTEÚDO CONDICIONAL ---
                                  if (_selectedTab == 0)
                                    _buildTicketList() 
                                  else
                                    _buildRoteirosContent(),

                                  const SizedBox(height: 24),

                                  const HomeBanner(),

                                  const SizedBox(height: 20),

                                  const HomeBanner2(),

                                  const SizedBox(height: 32),

                                  // BOTÃO VOLTAR AO TOPO 
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0), 
                                    child: SizedBox(
                                      height: 36, 
                                      width: double.infinity, 
                                      child: OutlinedButton(
                                        onPressed: _scrollToTop,
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide.none, 
                                          
                                          backgroundColor: Colors.transparent, 
                                          
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                          overlayColor: Colors.grey.shade100, 
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                           SvgPicture.asset('assets/images/home/top.svg', width: 16, height: 16, colorFilter: const ColorFilter.mode(Color(0xFF414651), BlendMode.srcIn)),
                                            const SizedBox(width: 10), 
                                            // Text
                                            const Text(
                                              "Voltar para o topo",
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600, 
                                                fontSize: 14,
                                                color: Color(0xFF252B37), 
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // --- WIDGET LISTA DE INGRESSOS ---
  Widget _buildTicketList() {
    final eventosUnicos = _meusIngressos.map((e) => e.event).toSet().toList();

    if (eventosUnicos.isEmpty) {
      return const Center(child: Text("Nenhum ingresso encontrado."));
    }

    return Column(
      children: eventosUnicos.map((evento) {
        final ingressosDoEvento =
            _meusIngressos.where((i) => i.event == evento).toList();

        return TicketSection(
          evento: evento,
          ingressos: ingressosDoEvento,
        );
      }).toList(),
    );
  }

 //  WIDGET ROTEIROS 
  Widget _buildRoteirosContent() {
    final List<RoteiroItemModel> roteiroItens = MockRoteiroData.getRoteiro();

    return Padding(
      padding: const EdgeInsets.only(right: 20.0), 
      child: RoteiroListWidget(itens: roteiroItens),
    );
  }

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
    String? link,
  }) {
    return GestureDetector(
      onTap: () async {
        if (link != null && link.isNotEmpty) {
          final Uri url = Uri.parse(link);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
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
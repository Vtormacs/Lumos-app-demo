import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loumar/models/user_model.dart';
import 'package:loumar/pages/login/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loumar/controllers/roteiro_controller.dart';
import 'package:loumar/widgets//roteiro_tab_bar.dart';
import 'package:loumar/widgets//roteiro_item_card.dart';
import 'package:loumar/models/roteiro/roteiro_base_model.dart';
import 'package:loumar/utils/date_utils.dart';

class RoteiroPage extends StatefulWidget {
  const RoteiroPage({super.key});

  @override
  _RoteiroPageState createState() => _RoteiroPageState();
}

class _RoteiroPageState extends State<RoteiroPage> {
  final RoteiroController _controller = RoteiroController();
  bool isMeuRoteiro = true;

  @override
  void initState() {
    super.initState();
    _controller.carregarRoteiro();
  }

  Future<UserModel?> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userData');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color blueTop = const Color(0xFF1D3B79);
    final Color bgColor = const Color(0xFFFAFAFA);

    return Scaffold(
      body: Stack(
        children: [
          // 1. FUNDO GERAL (Mantido do seu código)
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

          // 2. CONTEÚDO PRINCIPAL
          Column(
            children: [
              SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      "Roteiros",
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 3. O CORPO BRANCO COM A LISTA
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

                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      RoteiroTabBar(
                        isMeuRoteiroSelected: isMeuRoteiro,
                        onTapMeuRoteiro: () =>
                            setState(() => isMeuRoteiro = true),
                        onTapRoteiroDoDia: () =>
                            setState(() => isMeuRoteiro = false),
                      ),

                      Expanded(
                        child: ValueListenableBuilder<Map<DateTime, List<RoteiroItem>>>(
                          valueListenable: _controller.roteiroAgrupado,
                          builder: (context, roteiroMap, child) {
                            // Loading State
                            if (_controller.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                        
                            // Empty State
                            if (roteiroMap.isEmpty) {
                              return const Center(
                                child: Text("Nenhum roteiro encontrado."),
                              );
                            }
                        
                            // LISTA AGRUPADA (Meu Roteiro)
                            if (isMeuRoteiro) {
                              return ListView.builder(
                                padding: const EdgeInsets.only(
                                  top: 24,
                                  bottom: 40,
                                ),
                                itemCount: roteiroMap.keys.length,
                                itemBuilder: (context, index) {
                                  final DateTime dia = roteiroMap.keys.elementAt(
                                    index,
                                  );
                                  final List<RoteiroItem> itensDoDia =
                                      roteiroMap[dia]!;
                        
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          16,
                                          0,
                                          16,
                                          16,
                                        ),
                                        child: Text(
                                          RoteiroDateUtils.formatarCabecalho(dia),
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Color(0xFF1E3460),
                                          ),
                                        ),
                                      ),
                        
                                      // Lista de Cards daquele dia
                                      ...itensDoDia.map((item) {
                                        return RoteiroItemCard(
                                          item: item,
                                          onTap: () {
                                            print("Clicou em: ${item.titulo}");
                                          },
                                        );
                                      }).toList(),
                        
                                      const SizedBox(height: 24),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text("Visualização do Dia (Em breve)"),
                              );
                            }
                          },
                        ),
                      ),
                    ],
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

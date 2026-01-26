import 'package:flutter/material.dart';
import 'package:loumar/models/roteiro/hospedagem_roteiro.dart';
import 'package:loumar/models/roteiro/locacao_roteiro.dart';
import 'package:loumar/models/roteiro/passagem_roteiro.dart';
import 'package:loumar/models/roteiro/passerio_roteiro.dart';
import 'package:loumar/models/roteiro/transporte_roteiro.dart';
import 'package:loumar/pages/ingresso_pages/ingresso_detalhado.dart';
import 'package:loumar/pages/login/onboarding_page.dart';
import 'package:loumar/pages/roteiro_pages/hospedagem_detalhado.dart';
import 'package:loumar/pages/roteiro_pages/locacao_detalhado.dart';
import 'package:loumar/pages/roteiro_pages/passagem_detalhado.dart';
import 'package:loumar/pages/roteiro_pages/transporte_detalhado.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loumar/controllers/roteiro_controller.dart';
import 'package:loumar/widgets/roteiro/roteiro_tab_bar.dart';
import 'package:loumar/widgets/roteiro/roteiro_item_card.dart';
import 'package:loumar/models/roteiro/roteiro_base_model.dart';
import 'package:loumar/utils/date_utils.dart';
import 'package:loumar/widgets/roteiro/roteiro_dia_selector.dart';

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

  void _abrirDetalhes(RoteiroItem item) {
    switch (item.tipo) {
      case RoteiroTipo.hospedagem:
        final itemRoteiro = item as RoteiroHospedagem;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HospedagemDetalhado(hospedagem: itemRoteiro),
          ),
        );
        break;
      case RoteiroTipo.transporte:
        final itemRoteiro = item as RoteiroTransporte;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransporteDetalhado(transporte: itemRoteiro),
          ),
        );
        break;
      case RoteiroTipo.passagem:
        final itemRoteiro = item as RoteiroPassagem;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PassagemDetalhado(passagem: itemRoteiro),
          ),
        );
        break;
      case RoteiroTipo.passeio:
        final itemRoteiro = item as RoteiroPasseio;
        final ingressoReal = itemRoteiro.ingresso;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IngressoDetalhadoPage(ingresso: ingressoReal),
          ),
        );
        break;
      case RoteiroTipo.locacao:
        final itemRoteiro = item as RoteiroLocacao;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocacaoDetalhado(locacao: itemRoteiro),
          ),
        );
        break;
      case RoteiroTipo.passeio:
        final itemRoteiro = item as RoteiroPasseio;
        final ingressoReal = itemRoteiro.ingresso;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IngressoDetalhadoPage(ingresso: ingressoReal),
          ),
        );
        break;
      default:
        break;
    }
  }

  Map<String, List<RoteiroItem>> _agruparPorCategoria(List<RoteiroItem> itens) {
    final Map<String, List<RoteiroItem>> agrupado = {};

    for (var item in itens) {
      String chave = "Outros";
      switch (item.tipo) {
        case RoteiroTipo.transporte:
          chave = "Transportes";
          break;
        case RoteiroTipo.passagem:
          chave = "Passagens";
          break;
        case RoteiroTipo.hospedagem:
          chave = "Hospedagens";
          break;
        case RoteiroTipo.passeio:
          chave = "Passeios";
          break;
        case RoteiroTipo.locacao:
          chave = "Locação";
          break;
        default:
          chave = "Outros";
      }

      if (!agrupado.containsKey(chave)) {
        agrupado[chave] = [];
      }
      agrupado[chave]!.add(item);
    }
    return agrupado;
  }

  void _mudarDia(int dias) {
    if (_controller.diaSelecionado.value == null) return;

    // Garante que a lista de dias está ordenada
    final diasDisponiveis = _controller.roteiroAgrupado.value.keys.toList();
    diasDisponiveis.sort();

    final atual = _controller.diaSelecionado.value!;
    final indexAtual = diasDisponiveis.indexOf(atual);

    // Se por algum motivo o dia atual sumiu da lista, aborta
    if (indexAtual == -1) return;

    int novoIndex = indexAtual + dias;

    // --- CORREÇÃO AQUI: Use && (E), não || (OU) ---
    // Só acessa se estiver DENTRO dos limites (0 até tamanho-1)
    if (novoIndex >= 0 && novoIndex < diasDisponiveis.length) {
      _controller.selecionarDia(diasDisponiveis[novoIndex]);
    } else {
      debugPrint("Fim da lista alcançado.");
    }
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
                                  final DateTime dia = roteiroMap.keys
                                      .elementAt(index);
                                  final List<RoteiroItem> itensDoDia =
                                      roteiroMap[dia]!;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          16,
                                          0,
                                          16,
                                          16,
                                        ),
                                        child: Text(
                                          RoteiroDateUtils.formatarCabecalho(
                                            dia,
                                          ),
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
                                            _abrirDetalhes(item);
                                          },
                                        );
                                      }).toList(),

                                      const SizedBox(height: 24),
                                    ],
                                  );
                                },
                              );
                            }  else {
                              // VISUALIZAÇÃO "ROTEIRO DO DIA"
                              return ValueListenableBuilder<DateTime?>(
                                valueListenable: _controller.diaSelecionado,
                                builder: (context, diaSelecionado, _) {
                                  if (diaSelecionado == null) return const SizedBox();

                                  // 1. Pegamos a lista JÁ ORDENADA por horário (a controller já faz isso)
                                  final itensDoDia = roteiroMap[diaSelecionado] ?? [];

                                  if (itensDoDia.isEmpty) {
                                    return const Center(child: Text("Dia livre :)"));
                                  }

                                  return Column(
                                    children: [
                                      // SELETOR DE DIA
                                      RoteiroDiaSelector(
                                        diaSelecionado: diaSelecionado,
                                        onPrevious: () => _mudarDia(-1),
                                        onNext: () => _mudarDia(1),
                                      ),

                                      // LISTA INTELIGENTE (Cabeçalhos dinâmicos)
                                      Expanded(
                                        child: ListView.builder(
                                          padding: const EdgeInsets.only(bottom: 40),
                                          itemCount: itensDoDia.length,
                                          itemBuilder: (context, index) {
                                            final itemAtual = itensDoDia[index];
                                            
                                            // Verifica se precisa mostrar o cabeçalho
                                            // Mostra se for o primeiro item (index 0) 
                                            // OU se o tipo mudou em relação ao item anterior
                                            bool mostrarCabecalho = false;
                                            if (index == 0) {
                                              mostrarCabecalho = true;
                                            } else {
                                              final itemAnterior = itensDoDia[index - 1];
                                              if (itemAnterior.tipo != itemAtual.tipo) {
                                                mostrarCabecalho = true;
                                              }
                                            }

                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Se mudou a categoria, desenha o Título
                                                if (mostrarCabecalho) ...[
                                                  const SizedBox(height: 24),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                    child: Text(
                                                      _getTituloCategoria(itemAtual.tipo),
                                                      style: const TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                        color: Color(0xFF1E3460),
                                                      ),
                                                    ),
                                                  ),
                                                ],

                                                // Desenha o Card do Item
                                                RoteiroItemCard(
                                                  item: itemAtual,
                                                  onTap: () => _abrirDetalhes(itemAtual),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
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

  String _getTituloCategoria(RoteiroTipo tipo) {
    switch (tipo) {
      case RoteiroTipo.transporte:
        return "Transportes";
      case RoteiroTipo.passagem:
        return "Passagens"; // Ou "Aéreo"
      case RoteiroTipo.hospedagem:
        return "Hospedagens";
      case RoteiroTipo.passeio:
        return "Passeios";
      case RoteiroTipo.locacao:
        return "Locação";
      case RoteiroTipo.refeicao:
        return "Alimentação";
      default:
        return "Outros";
    }
  }
}

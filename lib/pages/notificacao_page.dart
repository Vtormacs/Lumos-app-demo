import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loumar/service/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- MODELO DE DADOS ---
class NotificacaoModel {
  final String titulo;
  final String mensagem;
  final String tipo; 
  final bool lida;

  NotificacaoModel({
    required this.titulo,
    required this.mensagem,
    required this.tipo,
    this.lida = false,
  });
}

class NotificacaoPage extends StatefulWidget {
  const NotificacaoPage({super.key});

  @override
  _NotificacaoPageState createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  List<NotificacaoModel> _notificacoes = [];

  @override
  void initState() {
    super.initState();
    _verificarEstadoInicial();
  }

  // Verifica se já existe notificação salva no disco
  Future<void> _verificarEstadoInicial() async {
    final prefs = await SharedPreferences.getInstance();
    bool temNotificacao = prefs.getBool('temNotificacao') ?? false;

    if (temNotificacao) {
      _carregarNotificacoesFakes(salvar: false);
    }
  }

  // Salva no disco para a Home saber
  Future<void> _atualizarEstadoNotificacao(bool temNotificacao) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('temNotificacao', temNotificacao);
  }

  // Cria dados fakes
  void _carregarNotificacoesFakes({bool salvar = true}) {
    setState(() {
      _notificacoes = [
        NotificacaoModel(
          titulo: "Oferta Especial no Paraguai",
          mensagem: "Encontre agora os melhores preços das lojas de Ciudad del Este e planeje sua compra antes de cruzar a ponte.",
          tipo: 'oferta', 
        ),
        NotificacaoModel(
          titulo: "Benefícios Exclusivos te Esperam",
          mensagem: "Ative sua cartela do Clube Apaixonados por Foz no WhatsApp e descubra vouchers disponíveis perto de você.",
          tipo: 'beneficio',
        ),
        NotificacaoModel(
          titulo: "Seu Ingresso Está Pronto para Usar",
          mensagem: "Confira as instruções de acesso e apresente seu QR Code na entrada da atração sem complicações.",
          tipo: 'ingresso', 
        ),
        NotificacaoModel(
          titulo: "Loja Próxima com Cupom Disponível",
          mensagem: "Você está perto de um estabelecimento parceiro com benefícios ativos — aproveite e garanta seu desconto agora.",
          tipo: 'loja', 
        ),
         NotificacaoModel(
          titulo: "Novidades no Seu Roteiro de Viagem",
          mensagem: "Adicionamos sugestões e recomendações personalizadas com base no seu itinerário em Foz do Iguaçu.",
          tipo: 'aviso',
        ),
      ];
    });

    if (salvar) {
      _atualizarEstadoNotificacao(true);
      NotificationService().showNotification(
        id: 1, 
        title: "Novas notificações disponíveis! 🛍️", 
        body: "Você tem ${_notificacoes.length} novas notificações. Toque para ver.",
      );
    }
  }

  // Limpa tudo (Estado Vazio)
  void _limparNotificacoes() {
    setState(() {
      _notificacoes = [];
    });
    _atualizarEstadoNotificacao(false);
  }

  @override
  Widget build(BuildContext context) {
    final Color blueTop = const Color(0xFF1D3B79);
    final Color bgColor = const Color(0xFFF9FAFB); 

    return Scaffold(
      backgroundColor: blueTop,
      
      // --- BOTÃO DE DEBUG 
      floatingActionButton: FloatingActionButton(
        onPressed: _notificacoes.isEmpty ? () => _carregarNotificacoesFakes(salvar: true) : _limparNotificacoes,
        backgroundColor: Colors.white,
        child: Text(
          _notificacoes.isEmpty ? "Adicionar" : "Limpar",
          style: const TextStyle(color: Colors.black),
        ),
      ),

      body: Column(
        children: [
          // 1. CABEÇALHO AZUL
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: blueTop,
              image: const DecorationImage(
                image: AssetImage('assets/images/home/fundohome.jpg'),
                fit: BoxFit.cover,
                opacity: 0.2, 
                filterQuality: FilterQuality.high,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
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
                  const Center(
                    child: Text(
                      "Notificações",
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

          // 2. CORPO BRANCO / LISTA
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: _notificacoes.isEmpty ? const Color(0xFFFAFAFA) : bgColor, 
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: _notificacoes.isEmpty 
                  ? _buildEmptyState() 
                  : _buildNotificationList(),
            ),
          ),
        ],
      ),
    );
  }

  // --- ESTADO VAZIO 
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/notificacao/notificacaovazia.png', 
            width: 118,
            height: 96,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          const Text(
            "Tudo tranquilo por enquanto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              height: 1.5, 
              color: Color(0xFF181D27),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Quando surgirem alertas, ofertas ou atualizações importantes, nós avisaremos você por aqui.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.4, 
              color: Color(0xFF414651),
            ),
          ),
        ],
      ),
    );
  }

  // --- LISTA DE NOTIFICAÇÕES  ---
  Widget _buildNotificationList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      itemCount: _notificacoes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12), 
      itemBuilder: (context, index) {
        final item = _notificacoes[index];
        return _buildNotificationCard(item);
      },
    );
  }

  Widget _buildNotificationCard(NotificacaoModel item) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ícone Quadrado
              _buildIconBox(item.tipo),
              
              const SizedBox(width: 16),
              
              // Texto Título
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.titulo,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.4,
                        color: Color(0xFF181D27),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 6), 
          
          Padding(
            padding: const EdgeInsets.only(left: 56),
            child: Text(
              item.mensagem,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.5, 
                color: Color(0xFF414651),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconBox(String tipo) {
    IconData iconData;
    Widget icon;
    
    switch (tipo) {
      case 'oferta':
        icon = SvgPicture.asset('assets/images/notificacao/oferta.svg', width: 20, height: 20);
        break;
      case 'beneficio':
        icon = SvgPicture.asset('assets/images/notificacao/beneficio.svg', width: 20, height: 20);
      case 'ingresso':
        icon = SvgPicture.asset('assets/images/notificacao/ingresso.svg', width: 16, height: 16);
      case 'loja':
        icon = SvgPicture.asset('assets/images/notificacao/loja.svg', width: 20, height: 20);
      case 'aviso':
        icon = SvgPicture.asset('assets/images/notificacao/aviso.svg', width: 20, height: 20);
      default:
        iconData = Icons.notifications_none;
        icon = Icon(iconData, size: 20);
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFEFF8FF), const Color(0xFFEFF8FF)],
        ),
        border: Border.all(color: const Color(0xFFEAECF5)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loumar/models/ticket_models.dart';
import 'package:intl/intl.dart'; 

class TicketSection extends StatelessWidget {
  final EventoModel evento;
  final List<IngressoModel> ingressos;

  const TicketSection({super.key, required this.evento, required this.ingressos});

  @override
  Widget build(BuildContext context) {
    // 1. Agrupar ingressos por data
    Map<String, List<IngressoModel>> ingressosPorData = {};
    Map<String, DateTime> dataOriginalMap = {};

    for (var ingresso in ingressos) {
      String dataKey = DateFormat("yyyy-MM-dd").format(ingresso.dataDoUso);
      
      if (!ingressosPorData.containsKey(dataKey)) {
        ingressosPorData[dataKey] = [];
        dataOriginalMap[dataKey] = ingresso.dataDoUso;
      }
      ingressosPorData[dataKey]!.add(ingresso);
    }

    var datasOrdenadas = ingressosPorData.keys.toList()
      ..sort((a, b) => a.compareTo(b));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- 1. CABEÇALHO DO EVENTO (Fixo, aparece só uma vez) ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(evento.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "${evento.title} (${ingressos.length} ingresso${ingressos.length > 1 ? 's' : ''})",
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF1E3460),
                  ),
                ),
              ),
            ],
          ),
        ),

        // --- REMOVIDO: O bloco de data que estava aqui antes causava a duplicação ---

        // --- 2. LOOP PELAS DATAS (Cria os grupos de cards) ---
        ...datasOrdenadas.map((dataKey) {
          List<IngressoModel> ingressosDoDia = ingressosPorData[dataKey]!;
          DateTime dataReal = dataOriginalMap[dataKey]!;
          
          String dateDisplay = DateFormat("EEEE, d 'de' MMM. y - HH:mm", 'pt_BR').format(dataReal);
          dateDisplay = dateDisplay[0].toUpperCase() + dateDisplay.substring(1);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Data e Hora (Cabeçalho da Seção) ---
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0, top: 8.0), // Ajustei o padding
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FC),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/home/data.svg', 
                        width: 15, 
                        height: 15, 
                        colorFilter: const ColorFilter.mode(Color(0xFF1E3460), BlendMode.srcIn)
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dateDisplay, 
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF181D27),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Lista Horizontal de Cards (Deste dia) ---
              SizedBox(
                height: 210, 
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ingressosDoDia.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0, bottom: 4), 
                      child: _TicketCardItem(ingresso: ingressosDoDia[index]),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 16), // Espaço entre os grupos de dias
            ],
          );
        }), 
      ],
    );
  }
}

// O restante (_TicketCardItem e TicketPainter) continua igual ao seu código anterior
class _TicketCardItem extends StatelessWidget {
  final IngressoModel ingresso;

  const _TicketCardItem({required this.ingresso});

  @override
  Widget build(BuildContext context) {
    final bool isInstructions = ingresso.status == TicketStatus.instructions;
    
    return CustomPaint(
      painter: TicketPainter(
        borderColor: const Color.fromARGB(255, 223, 223, 223), 
        bgColor: Colors.white,
      ),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max, 
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ingresso de",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Color(0xFF181D27),
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  ingresso.beneficiaryName,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF1E3460),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/home/ticket.svg', width: 16, height: 16, colorFilter: const ColorFilter.mode(Color(0xFF414651), BlendMode.srcIn)),
                    const SizedBox(width: 6),
                    Text(
                      ingresso.type,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF414651),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "ID do ingresso #${ingresso.id.replaceAll('#', '')}", 
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          color: Color(0xFF414651),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F9FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isInstructions ? "Retirar em loja" : "Ingresso digital",
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF026AA2),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const Spacer(),
            const Divider(height: 1, color: Color(0xFFE9EAEB)),
            const SizedBox(height: 17),
            SizedBox(
              width: double.infinity,
              height: 25,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isInstructions ? const Color.fromARGB(0, 255, 255, 255) : const Color.fromARGB(0, 239, 248, 255),
                  elevation: 0,
                  padding: EdgeInsets.zero
                ),
                child: Text(
                  isInstructions ? "Conferir instruções de retirada" : "Visualizar ingresso",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color(0xFF007A73),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TicketPainter extends CustomPainter {
  final Color borderColor;
  final Color bgColor;

  TicketPainter({required this.borderColor, required this.bgColor});

  @override
  void paint(Canvas canvas, Size size) {
    const double punchRadius = 10.0; 
    final double punchPositionFromBottom = size.height - (16 + 36 + 4); 

    final paintBg = Paint()..color = bgColor..style = PaintingStyle.fill;
    final paintBorder = Paint()..color = borderColor..strokeWidth = 1.0..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, 10); 
    path.quadraticBezierTo(0, 0, 10, 0); 
    path.lineTo(size.width - 10, 0);
    path.quadraticBezierTo(size.width, 0, size.width, 10); 

    path.lineTo(size.width, punchPositionFromBottom - punchRadius);
    path.arcToPoint(Offset(size.width, punchPositionFromBottom + punchRadius), radius: const Radius.circular(punchRadius), clockwise: false);
    path.lineTo(size.width, size.height - 10);
    path.quadraticBezierTo(size.width, size.height, size.width - 10, size.height);
    path.lineTo(10, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 10); 
    path.lineTo(0, punchPositionFromBottom + punchRadius);
    path.arcToPoint(Offset(0, punchPositionFromBottom - punchRadius), radius: const Radius.circular(punchRadius), clockwise: false);
    
    path.close();
    canvas.drawShadow(path, Colors.black.withOpacity(0.3), 8.0, false);
    canvas.drawPath(path, paintBg);
    canvas.drawPath(path, paintBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
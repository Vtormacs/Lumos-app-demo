import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loumar/models/ingresso_models.dart';
import 'package:loumar/pages/ingresso_pages/ingresso_detalhado.dart';

class IngressoList extends StatelessWidget {
  final List<IngressoModel> ingressos;

  const IngressoList({super.key, required this.ingressos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Lista de Cards
        ...ingressos.map((ingresso) => _IngressoListItem(ingresso: ingresso)),

        const SizedBox(height: 40),
      ],
    );
  }
}

class _IngressoListItem extends StatelessWidget {
  final IngressoModel ingresso;

  const _IngressoListItem({required this.ingresso});

  // Helpers para cores e textos baseados no Status
  Color _getStatusColor(TicketStatus status) {
    switch (status) {
      case TicketStatus.notPrinted:
        return const Color(0xFFCD3636);
      case TicketStatus.printed:
        return const Color(0xFFFBBC55);
      case TicketStatus.digital:
      default:
        return const Color(0xFF1F54C8);
    }
  }

  String _getStatusText(TicketStatus status) {
    switch (status) {
      case TicketStatus.notPrinted:
        return "Não Impresso";
      case TicketStatus.printed:
        return "Já Impresso";
      case TicketStatus.digital:
        return "Digital";
      default:
        return "Digital";
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd/MM/yyyy').format(ingresso.dataDoUso);
    final timeFormatted = DateFormat('HH:mm').format(ingresso.dataDoUso);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD5D5D9), width: 0.5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // --- 1. IMAGEM DO TOPO ---
          Container(
            height: 75,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              image: DecorationImage(
                image: NetworkImage(ingresso.event.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                ),
              ),
            ),
          ),

          // --- 2. CONTEÚDO ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Título do Evento
                Text(
                  ingresso.event.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF1E3460),
                  ),
                ),
                const SizedBox(height: 16),

                // Linha de Informações (Data, Horário, Status)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Coluna Data
                    _buildInfoColumn("Data:", dateFormatted),

                    // Coluna Horário
                    _buildInfoColumn("Horário:", timeFormatted),

                    // Coluna Status
                    Column(
                      children: [
                        const Text(
                          "Status:",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Color(0xFF1E3460),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getStatusColor(ingresso.status),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _getStatusText(ingresso.status),
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color(0xFF575467),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Botão + Detalhes
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              IngressoDetalhadoPage(ingresso: ingresso),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1E3C89)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "+ Detalhes",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF1E3C89),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFF1E3460),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF575467),
          ),
        ),
      ],
    );
  }
}

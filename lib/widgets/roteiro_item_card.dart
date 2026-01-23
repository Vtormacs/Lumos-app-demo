import 'package:flutter/material.dart';
import 'package:loumar/models/roteiro/roteiro_base_model.dart';
import 'package:loumar/utils/date_utils.dart'; // Certifique-se de ter criado o utils sugerido antes

class RoteiroItemCard extends StatelessWidget {
  final RoteiroItem item;
  final VoidCallback onTap;

  const RoteiroItemCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Definindo as cores baseadas no tipo (conforme CSS)
    Color barraColor;
    switch (item.tipo) {
      case RoteiroTipo.hospedagem:
        barraColor = const Color(0xFFE4BC0C); // Amarelo (Checkin)
        break;
      case RoteiroTipo.transporte:
        barraColor = const Color(0xFF00B4AB); // Verde Água (Transfer)
        break;
      case RoteiroTipo.aereo:
        barraColor = const Color(0xFF86DB5A); // Verde Claro (Embarque)
        break;
      case RoteiroTipo.passeio:
        barraColor = const Color(0xFF5769E3); // Azul (Ingresso)
        break;
      // Caso queira adicionar a cor Rosa para Locação, crie um tipo Locacao ou use o padrao
      default: 
        barraColor = const Color(0xFFCD309A); // Rosa (Locação/Outros)
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55, // Altura fixa conforme Figma
        color: Colors.white, // Fundo branco
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // COLUNA DO HORÁRIO (Frame 50611)
                  SizedBox(
                    width: 72,
                    child: Center(
                      child: Text(
                        RoteiroDateUtils.formatarHora(item.dataHora),
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFF575467),
                        ),
                      ),
                    ),
                  ),

                  // BARRA COLORIDA VERTICAL (Frame 50604)
                  Container(
                    width: 4,
                    height: double.infinity, // Preenche a altura (55px)
                    color: barraColor,
                  ),

                  // TÍTULO (Frame 50613)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Text(
                        item.titulo,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF1E3460),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  
                  // Ícone de seta (opcional, comum em listas clicáveis)
                  const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            // DIVISOR (Divisor 1)
            const Divider(
              height: 1, 
              thickness: 1, 
              color: Color(0xFFD5D5D9),
            ),
          ],
        ),
      ),
    );
  }
}
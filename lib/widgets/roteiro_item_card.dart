import 'package:flutter/material.dart';
import 'package:loumar/models/roteiro/roteiro_base_model.dart';
import 'package:loumar/utils/date_utils.dart'; 

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
    Color barraColor;
    switch (item.tipo) {
      case RoteiroTipo.hospedagem:
        barraColor = const Color(0xFFE4BC0C);
        break;
      case RoteiroTipo.transporte:
        barraColor = const Color(0xFF00B4AB); 
        break;
      case RoteiroTipo.aereo:
        barraColor = const Color(0xFF86DB5A);
        break;
      case RoteiroTipo.passeio:
        barraColor = const Color(0xFF5769E3); 
        break;
      case RoteiroTipo.locacao:
        barraColor = const Color(0xFFCD309A); 
        break;
      default: 
        barraColor = const Color(0xFFFF6B00); 
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55, 
        color: Colors.white, 
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // COLUNA DO HORÁRIO 
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

                  // BARRA COLORIDA VERTICAL 
                  Container(
                    width: 4,
                    height: double.infinity, 
                    color: barraColor,
                  ),

                  // TÍTULO 
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
                  
                ],
              ),
            ),
            // DIVISOR 
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
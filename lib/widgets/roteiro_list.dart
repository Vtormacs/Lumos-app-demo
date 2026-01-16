// lib/widgets/roteiro_list.dart
import 'package:flutter/material.dart';
import 'package:loumar/models/roteiro_model.dart';

class RoteiroListWidget extends StatelessWidget {
  final List<RoteiroItemModel> itens;

  const RoteiroListWidget({super.key, required this.itens});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Gera a lista de itens
        ...itens.map((item) => _buildRoteiroCard(item)).toList(),

        const SizedBox(height: 16),

        // Botão "Ver itinerário completo"
        SizedBox(
          width: double.infinity,
          height: 36,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF007A73),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(
              "Ver itinerário completo",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF007A73),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoteiroCard(RoteiroItemModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                height: 108,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: AssetImage(_getImageUrlByType(item.type)),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high
                  ),
                ),
              ),

              const SizedBox(width: 16), 

              //  CONTEÚDO DE TEXTO
              Expanded(
                child: SizedBox(
                  height: 120, 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Linha do Título e Badge
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título
                          Expanded(
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xFF181D27),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Badge 
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F9FF),
                              border: Border.all(color: const Color(0xFFB9E6FE)), 
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.dayLabel,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: Color(0xFF026AA2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 6),

                      // Descrição
                      Expanded(
                        child: Text(
                          item.description,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400, 
                            fontSize: 12,
                            height: 1.5,
                            color: Color(0xFF414651),
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          const Divider(height: 1, color: Color(0xFFF5F5F5)),
        ],
      ),
    );
  }

  // Helper para definir a imagem baseada no Enum
  String _getImageUrlByType(RoteiroType type) {
    switch (type) {
      case RoteiroType.partida:
        return "assets/images/home/partida.png"; // Avião
      case RoteiroType.chegada:
        return "assets/images/home/chegada.png"; // Hotel/Recepção
      case RoteiroType.passeio:
        return "assets/images/home/cataratas.png"; // Cataratas
      case RoteiroType.compras:
        return "assets/images/home/compras.png"; // Compras
      case RoteiroType.ultimoDia:
        return "assets/images/home/ultimo.png"; // Malas/Aeroporto
    }
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Adicione intl no pubspec.yaml se não tiver

class RoteiroDiaSelector extends StatelessWidget {
  final DateTime diaSelecionado;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const RoteiroDiaSelector({
    super.key,
    required this.diaSelecionado,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    // Formatações (Locale pt_BR deve estar configurado no main.dart)
    final diaSemana = DateFormat('EEEE', 'pt_BR').format(diaSelecionado);
    final diaSemanaCap = diaSemana[0].toUpperCase() + diaSemana.substring(1).split('-')[0]; // "Sexta"
    final dataNumerica = DateFormat('dd/MM', 'pt_BR').format(diaSelecionado); // "15/09"

    return Container(
      height: 92,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFD5D5D9), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Seta Esquerda
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1E3460)), // Use Icons.arrow_back ou SVG
          ),

          // Texto Central (Sexta 15/09)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                diaSemanaCap,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1E3460),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dataNumerica,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xFF1E3460),
                ),
              ),
            ],
          ),

          // Seta Direita
          IconButton(
            onPressed: onNext,
            icon: const Icon(Icons.arrow_forward, color: Color(0xFF1E3460)),
          ),
        ],
      ),
    );
  }
}
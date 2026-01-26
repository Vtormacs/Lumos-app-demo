import 'package:flutter/material.dart';

class RoteiroTabBar extends StatelessWidget {
  final bool isMeuRoteiroSelected;
  final VoidCallback onTapMeuRoteiro;
  final VoidCallback onTapRoteiroDoDia;

  const RoteiroTabBar({
    super.key,
    required this.isMeuRoteiroSelected,
    required this.onTapMeuRoteiro,
    required this.onTapRoteiroDoDia,
  });

  @override
  Widget build(BuildContext context) {
    const colorPrimary = Color(0xFF1E3460);

    return Container(
      height: 49,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Botão MEU ROTEIRO (Esquerda)
          Expanded(
            child: GestureDetector(
              onTap: onTapMeuRoteiro,
              child: Container(
                decoration: BoxDecoration(
                  color: isMeuRoteiroSelected ? colorPrimary : Colors.transparent,
                  border: Border.all(color: colorPrimary),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Meu Roteiro",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isMeuRoteiroSelected ? const Color(0xFFF8F8F8) : colorPrimary,
                  ),
                ),
              ),
            ),
          ),
          // Botão ROTEIRO DO DIA (Direita)
          Expanded(
            child: GestureDetector(
              onTap: onTapRoteiroDoDia,
              child: Container(
                decoration: BoxDecoration(
                  color: !isMeuRoteiroSelected ? colorPrimary : Colors.transparent,
                  border: Border.all(color: colorPrimary),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Roteiro do Dia",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: isMeuRoteiroSelected ? FontWeight.w400 : FontWeight.w600, // Bold se selecionado
                    fontSize: 14,
                    color: !isMeuRoteiroSelected ? const Color(0xFFF8F8F8) : colorPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
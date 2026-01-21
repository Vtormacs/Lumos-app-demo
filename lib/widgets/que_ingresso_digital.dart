import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QueIngressoDigital extends StatelessWidget {
  const QueIngressoDigital({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
      constraints: BoxConstraints(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "O que é um ingresso digital?",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xFF1E3460),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                      color: Color(0xFF1E3460),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "lorem ipsum dolor sit amet consectetur. Donec adipiscing pretium lorem quis. Curabitur lacinia in aenean ullamcorper ullamcorper id nisl eget. Integer nulla malesuada scelerisque lectus scelerisque.",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.2,
                  color: Color(0xFF575467),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Seção 2: Onde está a chave
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "E se eu estiver sem meu celular?",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1E3460),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Lorem ipsum dolor sit amet consectetur. Donec adipiscing pretium lorem quis. Curabitur lacinia in aenean ullamcorper ullamcorper id nisl eget. Integer nulla malesuada scelerisque lectus scelerisque.",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.2,
                  color: Color(0xFF575467),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          TextButton(
            onPressed: () async {
              
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/ingresso/lojasloumar.svg',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Lojas Loumar",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF1E3460),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

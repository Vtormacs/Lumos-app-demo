import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoumarKeyBottomSheet extends StatelessWidget {
  const LoumarKeyBottomSheet({super.key});

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
                        "O que é minha chave Loumar?",
                        style: TextStyle(
                          fontFamily: 'Manrope',
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
                "Para conseguir a chave você precisa lorem ipsum dolor sit amet consectetur. Donec adipiscing pretium lorem quis. Curabitur lacinia in aenean ullamcorper ullamcorper id nisl eget. Integer nulla malesuada scelerisque lectus scelerisque.",
                style: TextStyle(
                  fontFamily: 'Manrope',
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
                "Onde está minha chave Loumar?",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1E3460),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Para conseguir a chave você precisa Lorem ipsum dolor sit amet consectetur. Donec adipiscing pretium lorem quis. Curabitur lacinia in aenean ullamcorper ullamcorper id nisl eget. Integer nulla malesuada scelerisque lectus scelerisque.",
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.2,
                  color: Color(0xFF575467),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Botão "Falar com Especialista"
          TextButton(
            onPressed: () async {
              final Uri whatsappUrl = Uri.parse(
                'https://wa.me/554535214001?text=Olá,%20preciso%20falar%20com%20um%20especialista%20sobre%20como%20conseguir%20a%20chave%20Loumar!',
              );

              if (await canLaunchUrl(whatsappUrl)) {
                await launchUrl(
                  whatsappUrl,
                  mode: LaunchMode.externalApplication,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Não foi possível abrir o WhatsApp. Verifique se está instalado.',
                    ),
                  ),
                );
              }
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.phone, size: 20, color: Color(0xFF1E3460)),
                SizedBox(width: 8),
                Text(
                  "Falar com Especialista",
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF1E3460),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class IngressoVazio extends StatelessWidget {
  const IngressoVazio({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // Frame 50640
      // padding: 0px 16px;
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // align-items: center (no eixo cruzado em coluna esticada ou center, o botão pede stretch)
          mainAxisSize: MainAxisSize.min, // height: 166px (conteúdo dinâmico)
          children: [
            
            // Frame 50262 (Ícone + Texto)
            // opacity: 0.4;
            Opacity(
              opacity: 0.4,
              child: Column(
                children: [
                  // Frame 50261 + Vector
                  // width: 188.28px; height: 35px;
                  SvgPicture.asset(
                    'assets/images/ingresso/loumar.svg',
                    width: 188.28,
                    height: 35,
                    // background: #1E3460;
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF1E3460),
                      BlendMode.srcIn,
                    ),
                  ),

                  // gap: 32px (dentro do Frame 50262)
                  const SizedBox(height: 32),

                  // "Você não possui ingressos"
                  const Text(
                    "Você não possui ingressos",
                    style: TextStyle(
                      fontFamily: 'Inter', // CSS pede Inter
                      fontSize: 16,
                      fontWeight: FontWeight.w500, // weight: 500
                      height: 19 / 16, // line-height: 19px
                      color: Color(0xFF323232),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // gap: 32px (dentro do Frame 50640, entre o bloco de texto e o botão)
            const SizedBox(height: 32),

            // Field (Botão)
            // width: 328px (preenche o pai menos padding); height: 48px;
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3460),
                borderRadius: BorderRadius.circular(5),
                // border: 1px solid rgba(47, 43, 67, 0.1);
                border: Border.all(
                  color: const Color.fromRGBO(47, 43, 67, 0.1),
                  width: 1,
                ),
                // box-shadow: 0px 1px 3px rgba(47, 43, 67, 0.1)...
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(47, 43, 67, 0.1),
                    offset: Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  final Uri whatsappUrl = Uri.parse(
                    'https://wa.me/554535214001?text=Olá,%20preciso%20falar%20com%20um%20especialista%20sobre%20como%20conseguir%20ingressos',
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
                borderRadius: BorderRadius.circular(5),
                  child: const Center(
                    child: Text(
                      "Falar com Especialista", 
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600, 
                        height: 20 / 14,
                        letterSpacing: -0.01 * 14, 
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
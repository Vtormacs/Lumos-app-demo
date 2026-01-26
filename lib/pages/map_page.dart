import 'package:flutter/material.dart';
import 'package:loumar/pages/login/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
 
  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const OnboardingPage()),
    (route) => false,
  );
  }

   @override
  Widget build(BuildContext context) {
    final Color blueTop = const Color(0xFF1D3B79);
    final Color bgColor = const Color(0xFFFAFAFA);

    return Scaffold(
      body: Stack(
        children: [
          // 1. FUNDO GERAL 
          Container(
            height:
                MediaQuery.of(context).size.height *
                0.4, 
            width: double.infinity,
            color: blueTop,
            child: ClipRect(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Transform.translate(
                      offset: const Offset(0, -60),
                      child: Image.asset(
                        'assets/images/home/fundohome.jpg',
                        fit: BoxFit.cover,
                        opacity: const AlwaysStoppedAnimation(0.16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 2. CONTEÚDO (Título + Corpo Branco)
          Column(
            children: [
              SafeArea(
                bottom: false,
                child: SizedBox(
                  height: 60,
                  child: Center(
                    child: Text(
                      "Map",
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 3. O CORPO BRANCO ARREDONDADO
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        
                        // SEU CONTEÚDO VAI AQUI
                        const Text("Conteúdo da página de Roteiros..."),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

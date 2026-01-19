import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loumar/models/user_model.dart';
import 'package:loumar/pages/login/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IngressoPage extends StatefulWidget {
  const IngressoPage({super.key});

  @override
  _IngressoPageState createState() => _IngressoPageState();
}

class _IngressoPageState extends State<IngressoPage> {
  Future<UserModel?> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userData');
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }


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
    final Color bgColor = const Color(
      0xFFFAFAFA,
    );
    return Scaffold(
      backgroundColor:
          blueTop, 
      body: Column( 
        children: [

          // 1. O CABEÇALHO AZUL
          Container(
            height: 120, 
            width: double.infinity,
            decoration: BoxDecoration(
              color: blueTop,
              image: const DecorationImage(
                image: AssetImage('assets/images/home/fundohome.jpg'),
                fit: BoxFit.cover,
                opacity: 0.2, 
                filterQuality: FilterQuality.high,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Center(
                child: Text(
                  "Ingressos",
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

          // 2. O CORPO BRANCO ARREDONDADO
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

                   

                   


                 
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGETS AUXILIARES 

  


 

 

  // 5. Linha cinza divisória
  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF5F5F5));
  }
}

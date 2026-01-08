import 'package:flutter/material.dart';
import 'package:loumar/controllers/app_controller.dart';
import 'package:loumar/pages/home_page.dart';
import 'package:loumar/pages/perfil_page.dart';

// Tela principal com BottomNavigationBar customizado

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Lista das páginas que vão aparecer no meio
  final List<Widget> _pages = [
    const HomePage(),             // Índice 0: Sua Home atual
    const Center(child: Text("Tela de Ingressos")),           // Índice 1: LoginPage
    const Center(child: Text("Tela de Roteiros")),  // Índice 2: Placeholder
    const Center(child: Text("Tela de Mapa")),      // Índice 3: Placeholder
    const PerfilPage(),    // Índice 4: Placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    bool isDark = AppController.instance.isDarkTheme;

    return Scaffold(
      body: _pages[_selectedIndex],
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          border: Border(
            top: BorderSide(
              color: isDark ? const Color(0xFF333333) : const Color(0xFFE9EAEB),
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, 
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          elevation: 0, 
          
          selectedItemColor: isDark ? Colors.white : const Color(0xFF1E3460),
          unselectedItemColor: isDark ? Colors.grey : const Color(0xFF414651),
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Inter', 
            fontSize: 12, 
            fontWeight: FontWeight.w500
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Inter', 
            fontSize: 12, 
            fontWeight: FontWeight.w400
          ),
          
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          
          items: [
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.home_outlined, 0, isDark), // Passamos o isDark
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.confirmation_number_outlined, 1, isDark),
              label: 'Ingressos',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.route_outlined, 2, isDark),
              label: 'Roteiros',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.map_outlined, 3, isDark),
              label: 'Mapa',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.person_outline, 4, isDark),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomIcon(IconData icon, int index, bool isDark) {
    bool isSelected = _selectedIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSelected)
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? Colors.white : const Color(0xFF1E3460),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4), 
                bottomRight: Radius.circular(4)
              )
            ),
          )
        else
          const SizedBox(height: 4), 

        const SizedBox(height: 8), 
        Icon(icon),
      ],
    );
  }
}
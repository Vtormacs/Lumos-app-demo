import 'package:flutter/material.dart';
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
    const Center(child: Text("Tela de Ingressos")), // Índice 1: Placeholder
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
    return Scaffold(
      // O body muda conforme o índice selecionado
      body: _pages[_selectedIndex],
      
      // Aqui está o segredo para a borda superior do CSS
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE9EAEB), // Cor da borda do Figma
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Necessário para mais de 3 itens
          backgroundColor: Colors.white, // Fundo branco do Figma
          elevation: 0, // Remove a sombra padrão do Material para ficar flat
          
          // Cores baseadas no seu CSS
          selectedItemColor: const Color(0xFF1E3460), // Azul escuro
          unselectedItemColor: const Color(0xFF414651), // Cinza escuro
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
              icon: _buildCustomIcon(Icons.home_outlined, 0),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.confirmation_number_outlined, 1),
              label: 'Ingressos',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.route_outlined, 2),
              label: 'Roteiros',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.map_outlined, 3),
              label: 'Mapa',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomIcon(Icons.person_outline, 4),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  // Função auxiliar para desenhar a "linha" em cima do ícone ativo (conforme Figma)
  Widget _buildCustomIcon(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min, // Ocupa o mínimo de espaço
      children: [
        // A linha superior azul que aparece no Figma quando selecionado
        if (isSelected)
          Container(
            width: 40,
            height: 4,
            decoration: const BoxDecoration(
              color: Color(0xFF1E3460),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(4), 
                bottomRight: Radius.circular(4)
              )
            ),
          )
        else
          const SizedBox(height: 4), // Espaço vazio para alinhar

        const SizedBox(height: 8), // Espaçamento entre a linha e o ícone
        Icon(icon),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:loumar/controllers/app_controller.dart';
import 'package:loumar/pages/home_page.dart';
import 'package:loumar/pages/ingresso_page.dart';
import 'package:loumar/pages/map_page.dart';
import 'package:loumar/pages/perfil_page.dart';
import 'package:loumar/pages/roteiro_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const IngressoPage(),
    const RoteiroPage(),
    const MapPage(),
    const PerfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = AppController.instance.isDarkTheme;

  
    final Color selectedColor = isDark ? Colors.white : const Color(0xFF1E3460);
    final Color unselectedColor = isDark ? Colors.grey : const Color(0xFF414651);

    return Scaffold(
      body: _pages[_selectedIndex],
bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          
          border: Border.all(
            color: isDark ? const Color(0xFF333333) : const Color(0xFFE9EAEB),
            width: 1.5,
          ),
        ),
        
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            
            backgroundColor: Colors.transparent, 
            elevation: 0,
            
            selectedItemColor: selectedColor,
            unselectedItemColor: unselectedColor,
            
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w500
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w400
            ),
            
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            
            items: [
              BottomNavigationBarItem(
                icon: _buildSvgIcon('assets/images/menu/home.svg', 0, isDark), 
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: _buildSvgIcon('assets/images/menu/ingresso.svg', 1, isDark),
                label: 'Ingressos',
              ),
              BottomNavigationBarItem(
                icon: _buildSvgIcon('assets/images/menu/roteiro.svg', 2, isDark),
                label: 'Roteiros',
              ),
              BottomNavigationBarItem(
                icon: _buildSvgIcon('assets/images/menu/mapa.svg', 3, isDark),
                label: 'Mapa',
              ),
              BottomNavigationBarItem(
                icon: _buildSvgIcon('assets/images/menu/perfil.svg', 4, isDark),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSvgIcon(String assetName, int index, bool isDark) {
    bool isSelected = _selectedIndex == index;
    
    final Color iconColor = isSelected 
        ? (isDark ? Colors.white : const Color(0xFF1E3460)) 
        : (isDark ? Colors.grey : const Color(0xFF414651));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // A linha azul no topo
        if (isSelected)
          Container(
            width: 50,
            height: 3,
            decoration: BoxDecoration(
              color: isDark ? Colors.white : const Color(0xFF1E3460),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(3),
                bottomRight: Radius.circular(3)
              )
            ),
          )
        else
          const SizedBox(height: 4),

        const SizedBox(height: 8),
        
        SvgPicture.asset(
          assetName,
          width: 24, 
          height: 24,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ],
    );
  }
}
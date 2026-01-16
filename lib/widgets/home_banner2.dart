import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBanner2 extends StatefulWidget {
  const HomeBanner2({super.key});

  @override
  State<HomeBanner2> createState() => _HomeBanner2State();
}

class _HomeBanner2State extends State<HomeBanner2> with SingleTickerProviderStateMixin {
  int _current = 0;
  
  late AnimationController _progressController;

  final List<Map<String, String>> bannerList = [
    {
      "image": "https://img.freepik.com/vetores-gratis/fundo-abstrato-azul-de-meio-tom-com-espaco-de-texto_1017-41428.jpg?semt=ais_hybrid&w=740&q=80",
      "link": "https://www.loumarturismo.com.br/compras-paraguai",
    },
    {
      "image": "https://t3.ftcdn.net/jpg/03/91/44/92/360_F_391449299_xWOBVaVrXLyf0duErkPPLMWmJcCPTryH.jpg",
      "link": "https://www.loumarturismo.com.br/cataratas",
    },
    
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextPage();
      }
    });

    _progressController.forward(); 
  }

  void _nextPage() {
    if (mounted) {
      setState(() {
        _current = (_current + 1) % bannerList.length;
      });
      _progressController.reset(); 
      _progressController.forward(); 
    }
  }

  @override
  void dispose() {
    _progressController.dispose(); 
    super.dispose();
  }

  Future<void> _abrirLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Não foi possível abrir $uri');
    }
  }

  void _onSwipe(DragEndDetails details) {
    _progressController.stop();
    
    if (details.primaryVelocity! > 0) {
      setState(() {
        _current = (_current - 1 + bannerList.length) % bannerList.length;
      });
    } else if (details.primaryVelocity! < 0) {
      setState(() {
        _current = (_current + 1) % bannerList.length;
      });
    }
    _progressController.reset();
    _progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final currentBanner = bannerList[_current];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Títulos ---
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sugestões da Loumar',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color(0xFF181D27),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Para Você!',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color(0xFF181D27),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // --- CONTAINER ---
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onHorizontalDragEnd: _onSwipe,
            onTap: () => _abrirLink(currentBanner['link']!),
            child: Container(
              height: 390,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // --- IMAGEM ---
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Image.network(
                        currentBanner['image']!,
                        key: ValueKey<String>(currentBanner['image']!),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        width: double.infinity,
                        height: double.infinity,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                                child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                          );
                        },
                      ),
                    ),
                  ),

                  // --- INDICADORES TIPO BARRA DE PROGRESSO ---
                  Positioned(
                    bottom: 24,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: bannerList.asMap().entries.map((entry) {
                        bool isActive = _current == entry.key;
                        
                        return Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _current = entry.key;
                              });
                              _progressController.reset();
                              _progressController.forward();
                            },
                            child: Container(
                              height: 6.0,
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    Container(
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    
                                    if (isActive)
                                      AnimatedBuilder(
                                        animation: _progressController,
                                        builder: (context, child) {
                                          return FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: _progressController.value, 
                                            child: Container(
                                              color: Colors.white, 
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
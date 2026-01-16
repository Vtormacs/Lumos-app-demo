import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  // LISTA DE BANNERS
  final List<Map<String, String>> bannerList = [
    {
      "image": "https://img.freepik.com/vetores-gratis/fundo-abstrato-azul-de-meio-tom-com-espaco-de-texto_1017-41428.jpg?semt=ais_hybrid&w=740&q=80",
      "link": "https://www.loumarturismo.com.br/compras-paraguai",
    },
    {
      "image": "https://t3.ftcdn.net/jpg/03/91/44/92/360_F_391449299_xWOBVaVrXLyf0duErkPPLMWmJcCPTryH.jpg",
      "link": "https://www.loumarturismo.com.br/cataratas",
    },
    {
      "image": "https://img.myloview.com/posters/simple-modern-red-orange-yellow-abstract-banner-background-with-line-stripes-700-237793842.jpg",
      "link": "https://www.loumarturismo.com.br",
    },
    {
      "image": "https://img.freepik.com/vetores-gratis/bandeira-de-linhas-vermelhas-digitais-elegantes-a-moda_1017-23964.jpg?semt=ais_hybrid&w=740&q=80",
      "link": "https://www.loumarturismo.com.br",
    },
  ];

  Future<void> _abrirLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Não foi possível abrir $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
            'Confira as novidades!',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : const Color(0xFF181D27),
            ),
          ),

        const SizedBox(height: 16),

        // --- O CARROSSEL ---
        CarouselSlider(
          items: bannerList.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () => _abrirLink(item['link']!),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(right: 16.0), 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item['image']!,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
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
                );
              },
            );
          }).toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: 100,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 8),
            
            // --- CONFIGURAÇÕES IMPORTANTES PARA O LAYOUT ---
            padEnds: false, 
            enableInfiniteScroll: false, 
            viewportFraction: 0.9, 
            clipBehavior: Clip.none,
            
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),

        const SizedBox(height: 16),

        // --- INDICADORES  ---
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerList.asMap().entries.map((entry) {
            bool isActive = _current == entry.key;
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isActive ? 32.0 : 8.0, 
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(29), 
                  color: isActive 
                      ? const Color(0xFF007A73) 
                      : const Color(0xFFE9EAEB), 
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
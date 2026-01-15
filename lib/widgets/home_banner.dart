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
      "image": "https://loumarturismo.com.br/img/banners/home-destaque-compras-paraguai.jpg", 
      "link": "https://www.loumarturismo.com.br/compras-paraguai"
    },
    {
      "image": "https://loumarturismo.com.br/img/banners/home-destaque-cataratas.jpg", 
      "link": "https://www.loumarturismo.com.br/cataratas"
    },
    {
      "image": "https://via.placeholder.com/800x400.png?text=Promoção+Itaipu",
      "link": "https://www.loumarturismo.com.br"
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
      children: [

        Text(
          'Ofertas Especiais',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : const Color(0xFF1E3460),
          ),
        ),

        // --- O CARROSSEL ---
        CarouselSlider(
          items: bannerList.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () => _abrirLink(item['link']!),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      // Sombra suave
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    // ClipRRect para arredondar a imagem
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
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
            height: 180, // Altura do banner
            autoPlay: true, 
            autoPlayInterval: const Duration(seconds: 5),
            enlargeCenterPage: false,
            clipBehavior: Clip.none,
            viewportFraction: 0.8,
            aspectRatio: 16 / 9,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),

        const SizedBox(height: 10),

        // --- INDICADORES (BOLINHAS) ---
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: bannerList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : const Color(0xFF1E3460)) 
                      .withOpacity(_current == entry.key ? 0.9 : 0.2),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:loumar/paginas/ajustes_page.dart'; // <--- Importe o arquivo que criamos no Passo 1

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Cores extraídas do seu CSS/Figma
    final Color blueTop = const Color(0xFF1D3B79);
    final Color blueBottom = const Color(0xFF202F4D);
    final Color bgColor = const Color(
      0xFFFAFAFA,
    ); // Fundo cinza claro da parte de baixo

    return Scaffold(
      backgroundColor:
          blueTop, // Garante que o topo da tela (status bar) fique azul
      body: Column(
        children: [
          // ---------------------------------------------
          // 1. O CABEÇALHO AZUL (Fixo no topo)
          // ---------------------------------------------
          Container(
            height: 120, // Altura fixa para o cabeçalho
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [blueTop, blueBottom],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Center(
                child: Text(
                  "Perfil",
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

          // ---------------------------------------------
          // 2. O CORPO BRANCO ARREDONDADO
          // ---------------------------------------------
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                // Aqui fazemos a curva apenas no topo (border-radius: 24px 24px 0px 0px)
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              // SingleChildScrollView permite rolar se a tela for pequena
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- CARTÃO DO USUÁRIO ---
                    _buildUserCard(),

                    const SizedBox(height: 24),

                    // --- SEÇÃO: INFORMAÇÕES PESSOAIS ---
                    _buildSectionTitle("Informações pessoais"),
                    const SizedBox(height: 8),
                    _buildMenuContainer(
                      children: [
                        _buildMenuItem(
                          icon: Icons.person_outline,
                          text: "Editar perfil",
                        ),
                        _buildDivider(), // Linha divisória
                        _buildMenuItem(
                          icon: Icons.lock_outline,
                          text: "Alterar senha",
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.shopping_bag_outlined,
                          text: "Histórico de compras",
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // --- SEÇÃO: CONFIGURAÇÕES ---
                    _buildSectionTitle("Configurações"),
                    const SizedBox(height: 8),
                    _buildMenuContainer(
                      children: [
                        _buildMenuItem(
                          icon: Icons.notifications_none,
                          text: "Notificações",
                          onTap: () {
                            print("Clicou em Notificações");
                          },
                        ),
                        _buildDivider(),

                        _buildMenuItem(
                          icon: Icons.settings_outlined,
                          text: "Ajuste de App",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AjustesPage(),
                              ),
                            );
                          },
                        ),

                        _buildDivider(),

                        _buildMenuItem(
                          icon: Icons.lock_outline,
                          text: "Alterar senha",
                        ), // Repetido no seu Figma, mantive igual
                      ],
                    ),

                    const SizedBox(height: 24),

                    // --- SEÇÃO: SUPORTE & APP ---
                    _buildSectionTitle("Suporte & App"),
                    const SizedBox(height: 8),
                    _buildMenuContainer(
                      children: [
                        _buildMenuItem(
                          icon: Icons.help_outline,
                          text: "Perguntas frequentes",
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.headset_mic_outlined,
                          text: "Ajuda / Suporte",
                        ),
                        _buildDivider(),
                        _buildMenuItem(
                          icon: Icons.info_outline,
                          text: "Sobre o app",
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // --- BOTÃO DE SAIR ---
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          // Lógica de sair
                          print("Sair da conta");
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Color(0xFFD92D20),
                          size: 20,
                        ),
                        label: const Text(
                          "Sair da conta",
                          style: TextStyle(
                            color: Color(0xFFD92D20),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
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

  // ==========================================================
  // WIDGETS AUXILIARES (Para limpar o código principal)
  // ==========================================================

  // 1. O Cartão do Usuário (Foto + Nome + Email)
  Widget _buildUserCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9EAEB)), // Borda sutil
      ),
      child: Row(
        children: [
          // Foto de Perfil
          Stack(
            children: [
              const CircleAvatar(
                radius: 32, // Tamanho da foto (64px)
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=5',
                ),
              ),
              // Ícone da câmera azulzinho
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1D3B79),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Textos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Michelle Duarte",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF181D27),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "michelle.duarte123@gmail.com",
                  style: TextStyle(color: Color(0xFF414651), fontSize: 13),
                  overflow: TextOverflow.ellipsis, // Corta se for muito longo
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. Título das seções (ex: "Informações pessoais")
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, color: Color(0xFF252B37)),
    );
  }

  // 3. Container Branco que agrupa os itens do menu
  Widget _buildMenuContainer({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF5F5F5)),
      ),
      child: Column(children: children),
    );
  }

  // 4. O item do menu em si (Ícone + Texto + Setinha)
  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return InkWell(
      // InkWell dá o efeito de clique
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF535862), size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF181D27),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF535862), size: 24),
          ],
        ),
      ),
    );
  }

  // 5. Linha cinza divisória
  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF5F5F5));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loumar/models/compra_model.dart';

class CompraDetalhadaPage extends StatelessWidget {
  const CompraDetalhadaPage({super.key, required this.compra});

  final CompraModel compra;

  @override
  Widget build(BuildContext context) {
    // Formatadores
    final dateFormatted = DateFormat('dd/MM/yyyy').format(compra.dataCompra);
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final valorTotalFormatted = currencyFormat.format(compra.valorTotal);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: SvgPicture.asset(
              "assets/images/ingresso/arrow_left.svg",
              width: 15,
              height: 15,
            ),
          ),
          title: Text(
            "Compra Cód. ${compra.id}",
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF1E3460),
            ),
          ),
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
        ),
        
        // --- BOTÃO DE BAIXAR COMPROVANTE (FIXO EMBAIXO) ---
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFEAECF5))),
          ),
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download, size: 20),
            label: const Text(
              "Baixar Comprovante",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3460),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CABEÇALHO DE INFORMAÇÕES ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _buildInfoItem(
                              "Nome do Titular", compra.nomeTitular)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildInfoItem(
                              "Forma de Pgto:", compra.formaPagamentoResumo)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _buildInfoItem("Valor:", valorTotalFormatted)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildInfoItem("Data:", dateFormatted)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child:
                              _buildInfoItem("Cód. Loumar:", compra.loumarKey)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildInfoItem("Tarifa:", compra.tarifaTipo)),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // --- TAB BAR ---
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFD5D5D9),
                    width: 1.0,
                  ),
                ),
              ),
              child: const TabBar(
                indicatorColor: Color(0xFF1E3460),
                indicatorWeight: 1.5,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Color(0xFF1E3460),
                labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelColor: Color(0xFF575467),
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                tabs: [
                  Tab(text: "Detalhes de Compra"),
                  Tab(text: "Dados de Pagamento"),
                ],
              ),
            ),

            // --- CONTEÚDO DAS ABAS ---
            Expanded(
              child: TabBarView(
                children: [
                  // ABA 1: ITENS
                  _buildItensTab(currencyFormat),

                  // ABA 2: PAGAMENTOS
                  _buildPagamentosTab(currencyFormat),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET DA ABA 1: ITENS ---
  Widget _buildItensTab(NumberFormat currencyFormat) {
    return Column(
      children: [
        // Header da Tabela
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: const [
              Expanded(flex: 3, child: Text("Item", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E3460)))),
              Expanded(flex: 1, child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E3460)))),
              Expanded(flex: 1, child: Text("Valor", textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E3460)))),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFEAECF5)),
        
        // Lista
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: compra.itens.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = compra.itens[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Coluna 1: Ícone + Título
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        _buildItemIcon(item.tipo),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            item.titulo,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xFF1E3460),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  
                  // Coluna 2: Status
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: Color(0xFF2563EB)), // Azul
                        const SizedBox(width: 4),
                        Text(
                          item.status,
                          style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Color(0xFF2563EB), // Azul
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Coluna 3: Valor
                  Expanded(
                    flex: 1,
                    child: Text(
                      currencyFormat.format(item.valor),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xFF575467),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // --- WIDGET DA ABA 2: PAGAMENTOS ---
  Widget _buildPagamentosTab(NumberFormat currencyFormat) {
    return Column(
      children: [
        // Header da Tabela
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: const [
              Expanded(flex: 1, child: Text("Data", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E3460)))),
              Expanded(flex: 2, child: Center(child: Text("Método Pgto.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E3460))))),
              Expanded(flex: 1, child: Text("Valor", textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1E3460)))),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFEAECF5)),

        // Lista
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: compra.pagamentos.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final pgto = compra.pagamentos[index];
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(pgto.data),
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF575467),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      pgto.metodo,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xFF2563EB), // Azul Link
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      currencyFormat.format(pgto.valor),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xFF575467),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // Helper para o texto do Header (Label/Value)
  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1E3460),
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF575467),
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // Helper para ícones coloridos
  Widget _buildItemIcon(TipoItem tipo) {
    Color bgColor;
    IconData iconData;

    switch (tipo) {
      case TipoItem.hotel:
        bgColor = const Color(0xFFE4BC0C); // Amarelo
        iconData = Icons.bed; 
        break;
      case TipoItem.aviao:
        bgColor = const Color(0xFF86DB5A); // Verde
        iconData = Icons.flight;
        break;
      case TipoItem.transporte:
        bgColor = const Color(0xFF00B4AB); // Ciano
        iconData = Icons.directions_bus;
        break;
      default:
        bgColor = Colors.grey;
        iconData = Icons.confirmation_number;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: Colors.white, size: 16),
    );
  }
}
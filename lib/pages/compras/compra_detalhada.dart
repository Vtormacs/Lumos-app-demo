import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loumar/models/compra_model.dart';

class CompraDetalhadaPage extends StatelessWidget {
  const CompraDetalhadaPage({super.key, required this.compra});

  final CompraModel compra;

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd/MM/yyyy').format(compra.dataDoUso);

    return DefaultTabController(
      length: 2, 
      child: Scaffold(
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
            "Compra Cód. #${compra.codCompra}",
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
        backgroundColor: const Color(0xFFFFFFFF),
        
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          child:
                              _buildInfoItem("Forma de Pgto:", compra.pagamento)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: _buildInfoItem("Valor:", compra.valor)),
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
                          child: _buildInfoItem("Tarifa:", compra.rateType)),
                    ],
                  ),
                  const SizedBox(height: 24), 
                ],
              ),
            ),

            // --- TAB BAR 
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

                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Center(child: Text("Lista de itens da compra aqui...")),
                      ],
                    ),
                  ),

                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text("Lista de pagamentos aqui...")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
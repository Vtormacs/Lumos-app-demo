import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loumar/models/compra_model.dart';
import 'package:loumar/pages/compras/compra_detalhada.dart';

class ComprasList extends StatelessWidget {
  final List<CompraModel> compras;

  const ComprasList({super.key, required this.compras});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Lista de Cards
        ...compras.map((compra) => _CompraListItem(compra: compra)),

        const SizedBox(height: 40),
      ],
    );
  }
}

class _CompraListItem extends StatelessWidget {
  final CompraModel compra;

  const _CompraListItem({required this.compra});

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd/MM/yyyy').format(compra.dataCompra);
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final valorFormatado = currencyFormat.format(compra.valorTotal);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD5D5D9), width: 0.5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // --- 1. IMAGEM DO TOPO ---
          Container(
            height: 63,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: Color(0xFF1E3460),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Center(
                    child: Text(
                      "Compra Cód. ${compra.id}", 
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  Container(
                    width: 57,
                    height: 31,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      border: Border.all(color: const Color(0xFFEAECF5)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${compra.itens.length}", 
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          
                            const Spacer(),
                            const Text(
                              "itens",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- 2. CONTEÚDO ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoColumn("Data:", dateFormatted),

                    _buildInfoColumn("Pagamento:", compra.formaPagamentoResumo),

                    _buildInfoColumn("Valor:", valorFormatado),
                    
                  ],
                ),

                const SizedBox(height: 16),

                // Botão + Detalhes
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CompraDetalhadaPage(compra: compra),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1E3C89)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "+ Detalhes",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF1E3C89),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Expanded( 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Color(0xFF1E3460),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 2, // Limite para não estourar
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFF575467),
            ),
          ),
        ],
      ),
    );
  }
}
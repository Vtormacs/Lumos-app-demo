import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loumar/models/roteiro/locacao_roteiro.dart';

class LocacaoDetalhado extends StatelessWidget {
  const LocacaoDetalhado({super.key, required this.locacao});

  final RoteiroLocacao locacao;

  Color _getStatusColor(StatusLocacao status) {
    switch (status) {
      case StatusLocacao.cancelado:
        return const Color(0xFFCD3636);
      case StatusLocacao.aretirar:
        return const Color(0xFFFBBC55);
      case StatusLocacao.retirado:
        return const Color(0xFF34A853);
    }
  }

  String _getStatusText(StatusLocacao status) {
    switch (status) {
      case StatusLocacao.cancelado:
        return "Cancelado";
      case StatusLocacao.aretirar:
        return "A Retirar";
      case StatusLocacao.retirado:
        return "Retirado";
    }
  }

  String _getCategoriaText(CategoriaLocacao categoria) {
    switch (categoria) {
      case CategoriaLocacao.carro:
        return "Carro";
      case CategoriaLocacao.moto:
        return "Moto";
      case CategoriaLocacao.bicicleta:
        return "Bicicleta";
      case CategoriaLocacao.van:
        return "Van";
      case CategoriaLocacao.onibus:
        return "Ônibus";
      case CategoriaLocacao.cortesia:
        return "Cortesia";
      case CategoriaLocacao.outros:
        return "Outros";
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd/MM/yyyy').format(locacao.dataHora);
    final timeFormatted = DateFormat('HH:mm').format(locacao.dataHora);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(
            "assets/images/ingresso/arrow_left.svg",
            width: 15,
            height: 15,
          ),
        ),
        title: const Text(
          'Locação',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color(0xFF1E3460),
          ),
        ),
        backgroundColor: const Color(0xFFFFFFFF),
      ),

      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCD309A),
                      border: Border.all(color: const Color(0xFFEAECF5)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/icons/locacao.svg",
                        width: 16,
                        height: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      locacao.titulo,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF1E3460),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Linha 1
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildInfoItem("Chave Loumar:", locacao.chaveLoumar),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: _buildInfoItem("Tarifa:", locacao.tarifa)),
                ],
              ),
              const SizedBox(height: 16),
              // Linha 2
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      "Nome do Local:",
                      locacao.local,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoItem(
                      "Endereço:",
                      locacao.endereco,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Linha 3
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildInfoItem("Data de Uso:", dateFormatted),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: _buildInfoItem("Horário:", timeFormatted)),
                ],
              ),
              const SizedBox(height: 16),

              // Linha 4
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Categoria:",
                          style: TextStyle(
                            color: const Color(0xFF1E3460),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              _getCategoriaText(locacao.categoria),
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color(0xFF575467),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Text(
                          "Status:",
                          style: TextStyle(
                            color: const Color(0xFF1E3460),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _getStatusColor(locacao.status),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _getStatusText(locacao.status),
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color(0xFF575467),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              Text(
                "Informações Adicionais:",
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1E3460),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: locacao.additionalInfo.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 9, right: 9),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "•",
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.1,
                            color: Color(0xFF575467),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFF575467),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // Ação ao clicar no botão
                  },
                  child: Text(
                    "Onde retirar o carro ?",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E3460),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar
  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF1E3460),
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: const Color(0xFF575467),
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loumar/models/roteiro/transporte_roteiro.dart';

class TransporteDetalhado extends StatelessWidget {
  const TransporteDetalhado({super.key, required this.transporte});

  final RoteiroTransporte transporte;

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd/MM/yyyy').format(transporte.dataHora);
    final timeFormatted = DateFormat('HH:mm').format(transporte.dataHora);
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
          'Transporte',
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
                      color: const Color(0xFF00B4AB),
                      border: Border.all(color: const Color(0xFFEAECF5)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/icons/transporte.svg",
                        width: 16,
                        height: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      transporte.titulo,
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
                    child: _buildInfoItem(
                      "Ponto de Embarque:",
                      transporte.origem,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoItem("Data de Serviço:", dateFormatted),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Linha 2
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      "Ida:",
                      timeFormatted,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoItem(
                      "Retorno:",
                      timeFormatted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Linha 4
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildInfoItem("Especialista:", transporte.motorista),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoItem("Voucher:", transporte.localizador),
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
                children: transporte.additionalInfo.map((item) {
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

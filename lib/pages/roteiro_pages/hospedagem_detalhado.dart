import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loumar/models/roteiro/hospedagem_roteiro.dart';

class HospedagemDetalhado extends StatelessWidget {
  const HospedagemDetalhado({super.key, required this.hospedagem});

  final RoteiroHospedagem hospedagem;

  @override
  Widget build(BuildContext context) {
    final checkin = DateFormat('dd/MM/yyyy').format(hospedagem.checkin);
    final checkiout = DateFormat('dd/MM/yyyy').format(hospedagem.checkiout);
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
          'Hospedagem',
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
                      color: const Color(0xFFE4BC0C),
                      border: Border.all(color: const Color(0xFFEAECF5)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/icons/hospedagem.svg",
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      hospedagem.titulo,
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
                  Expanded(child: _buildInfoItem("Check-in:", checkin)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildInfoItem("Check-out:", checkiout)),
                ],
              ),
              const SizedBox(height: 16),
              // Linha 2
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      "Nome do Hotel:",
                      hospedagem.nomeHotel,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoItem("Endereço:", hospedagem.endereco),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildInfoItem("Titular:", hospedagem.titular),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      "Tipo de Quarto:",
                      hospedagem.tipoQuarto,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                "Hóspede(s):",
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1E3460),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: hospedagem.hospedes.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 9, right: 9),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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

              Text(
                "Observações:",
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1E3460),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: hospedagem.obrservacoes.map((item) {
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

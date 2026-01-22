import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loumar/models/ingresso_models.dart';
import 'package:loumar/widgets/qrcode_modal.dart';
import 'package:loumar/widgets/que_ingresso_digital.dart';
import 'package:loumar/widgets/onde_imprimir.dart';

class IngressoDetalhadoPage extends StatelessWidget {
  const IngressoDetalhadoPage({super.key, required this.ingresso});

  final IngressoModel ingresso;

  // Helpers para cores e textos baseados no Status
  Color _getStatusColor(TicketStatus status) {
    switch (status) {
      case TicketStatus.notPrinted:
        return const Color(0xFFCD3636);
      case TicketStatus.printed:
        return const Color(0xFFFBBC55);
      case TicketStatus.digital:
      default:
        return const Color(0xFF1F54C8);
    }
  }

  String _getStatusText(TicketStatus status) {
    switch (status) {
      case TicketStatus.notPrinted:
        return "Não Impresso";
      case TicketStatus.printed:
        return "Já Impresso";
      case TicketStatus.digital:
        return "Digital";
      default:
        return "Digital";
    }
  }

  String _getStatusTextIngressp(TicketStatus status) {
    switch (status) {
      case TicketStatus.notPrinted:
      case TicketStatus.printed:
        return "Onde imprimir meu ingresso?";
      case TicketStatus.digital:
        return "O que é um ingresso Digital?";
      default:
        return "Não identificado";
    }
  }

  void _showQueIngressoDigital(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return const QueIngressoDigital();
      },
    );
  }

  void _showOndeImpresso(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return const OndeImprimir();
      },
    );
  }

  // --- LÓGICA DE DECISÃO ---
  void _handleActionPress(BuildContext context) {
    switch (ingresso.status) {
      case TicketStatus.digital:
        _showQueIngressoDigital(context);
        break;
      case TicketStatus.printed:
      case TicketStatus.notPrinted:
        _showOndeImpresso(context);
        break;
      default:
        _showQueIngressoDigital(context);
    }
  }

  void _showQrCodeModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (BuildContext context) {
        return QrCodeModal(
          qrCodeImageUrl: ingresso.qrCodeImageUrl,
          voucherCode: ingresso.voucherCode,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd/MM/yyyy').format(ingresso.dataDoUso);
    final timeFormatted = DateFormat('HH:mm').format(ingresso.dataDoUso);

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
        title: const Text('Ingresso', style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Color(0xFF1E3460),
        ),),
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
                      color: const Color(0xFF5769E3),
                      border: Border.all(color: const Color(0xFFEAECF5)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/ingresso/ticket.svg",
                        width: 16,
                        height: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      ingresso.event.title,
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
                    child: _buildInfoItem("Chave Loumar:", ingresso.loumarKey),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: _buildInfoItem("Tarifa:", ingresso.rateType)),
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
                      ingresso.event.venueName,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoItem(
                      "Endereço:",
                      ingresso.event.venueAddress,
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
                    child: _buildInfoItem("Especialista:", ingresso.agentName),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInfoItem("Voucher:", ingresso.voucherCode),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => _showQrCodeModal(context),
                        child: Image.network(
                          ingresso.qrCodeImageUrl,
                          width: 124,
                          height: 124,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.qr_code_2,
                              color: Color(0xFF1E3460),
                              size: 124,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const SizedBox(
                              width: 124,
                              height: 124,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoItem("Categoria:", ingresso.type),
                        const SizedBox(height: 16),

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
                                color: _getStatusColor(ingresso.status),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _getStatusText(ingresso.status),
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
                "Sobre o ingresso:",
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF1E3460),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: ingresso.event.about.map((item) {
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
                children: ingresso.event.additionalInfo.map((item) {
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
                  onPressed: () => _handleActionPress(context),
                  child: Text(
                    _getStatusTextIngressp(ingresso.status),
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
